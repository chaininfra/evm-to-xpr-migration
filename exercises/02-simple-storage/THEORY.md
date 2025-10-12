# Theory: Simple Storage & State Management

## Learning Objectives
- Understand state management in smart contracts
- Master TableStore and database operations
- Practice singleton pattern and auto-increment
- Understand RAM management and resource optimization
- Learn history tracking and audit trails

## Prerequisites
- Completed Hello World contract
- Basic understanding of decorators and actions
- Knowledge of database concepts

## 1. XPR Network Storage System

### 1.1 TableStore Overview
The XPR Network Contract SDK provides TableStore for persistent data storage:

```typescript
import { TableStore, Table } from "proton-tsc";

@table("state")
export class State extends Table {
    constructor(
        public id: u64 = 0,
        public value: u64 = 0,
        public lastUpdater: Name = new Name(),
        public lastHistoryId: u64 = 0
    ) { super(); }
    
    @primary
    get primary(): u64 {
        return this.id;
    }
}
```

### 1.2 Basic Storage Operations
```typescript
// Initialize TableStore
private stateTable: TableStore<State> = new TableStore<State>(this.receiver);

// Store new data
const state = new State(0, 100, new Name(), 0);
this.stateTable.store(state, this.receiver);

// Retrieve data
const existingState = this.stateTable.get(0);

// Update data
existingState.value = 200;
this.stateTable.update(existingState, this.receiver);
```

## 2. TableStore Deep Dive

### 2.1 TableStore Architecture
```typescript
// TableStore provides database-like operations
private stateTable: TableStore<State> = new TableStore<State>(this.receiver);
```

**Components:**
- `TableStore<T>`: Generic type for type safety
- `State`: Data structure definition
- `this.receiver`: Contract account (scope)

### 2.2 CRUD Operations
```typescript
// Create (Store)
const newState = new State(0, 100, new Name(), 0);
this.stateTable.store(newState, this.receiver);

// Read (Get)
const state = this.stateTable.get(0);

// Update
state.value = 200;
this.stateTable.update(state, this.receiver);

// Delete (Remove)
this.stateTable.remove(state);
```

### 2.3 Primary Keys
```typescript
@table("state")
export class State extends Table {
    constructor(
        public id: u64 = 0,  // Primary key
        public value: u64 = 0,
        // ... other fields
    ) { super(); }

    @primary
    get primary(): u64 {
        return this.id;  // Must return unique identifier
    }
}
```

## 3. Singleton Pattern

### 3.1 What is Singleton Pattern?
```typescript
// Singleton: Only one instance exists
private getOrInitState(): State {
    let s = this.stateTable.get(0);  // Always use key = 0
    if (!s) {
        s = new State(0, 0, new Name(), 0);
        this.stateTable.store(s, this.receiver);
    }
    return s as State;
}
```

**Characteristics:**
- Single instance per contract
- Lazy initialization
- Global access point
- Thread-safe (blockchain guarantees)

### 3.2 When to Use Singleton
```typescript
// Good for singleton:
- Global configuration
- Contract settings
- Single counter/state
- Protocol parameters

// Bad for singleton:
- User-specific data
- Multiple records
- Dynamic collections
- User accounts
```

### 3.3 Implementation Patterns
```typescript
// Pattern 1: Lazy Initialization
private getOrInitState(): State {
    let state = this.stateTable.get(0);
    if (!state) {
        state = new State(0, 0, new Name(), 0);
        this.stateTable.store(state, this.receiver);
    }
    return state as State;
}

// Pattern 2: Check-then-Initialize
@action("init")
init(): void {
    const existing = this.stateTable.get(0);
    check(existing == null, "Already initialized");
    
    const state = new State(0, 0, new Name(), 0);
    this.stateTable.store(state, this.receiver);
}
```

## 4. Auto-Increment Pattern

### 4.1 What is Auto-Increment?
```typescript
// Auto-increment: Sequential ID generation
const historyId = this.historyTable.availablePrimaryKey;
const history = new History(historyId, oldValue, newValue, updater);
this.historyTable.store(history, this.receiver);
```

**Benefits:**
- Unique identifiers
- Sequential ordering
- No ID conflicts
- Easy to implement

### 4.2 Implementation Details
```typescript
@table("history")
export class History extends Table {
    constructor(
        public id: u64 = 0,  // Auto-increment ID
        public oldValue: u64 = 0,
        public newValue: u64 = 0,
        public updater: Name = new Name()
    ) { super(); }

    @primary
    get primary(): u64 {
        return this.id;
    }
}

// Usage
private appendHistory(oldValue: u64, newValue: u64, updater: Name): u64 {
    const id = this.historyTable.availablePrimaryKey;  // Get next ID
    const history = new History(id, oldValue, newValue, updater);
    this.historyTable.store(history, this.receiver);
    return id;
}
```

### 4.3 Alternative ID Strategies
```typescript
// Strategy 1: Timestamp-based
const id = Date.now();

// Strategy 2: Hash-based
const id = hash(updater.toString() + oldValue.toString());

// Strategy 3: Composite key
const id = (updater.N << 32) | (oldValue & 0xFFFFFFFF);
```

## 5. RAM Management

### 5.1 RAM Cost Model
```typescript
// RAM costs for different operations
store()    // ~200 bytes per row
update()   // ~50 bytes per change
remove()   // ~50 bytes per deletion
```

### 5.2 RAM Optimization Strategies
```typescript
// Good: Efficient data structures
@table("optimized")
export class Optimized extends Table {
    constructor(
        public id: u64 = 0,
        public value: u64 = 0,  // Use u64 instead of string
        public flag: boolean = false  // Use boolean instead of string
    ) { super(); }
}

// Bad: Inefficient data structures
@table("inefficient")
export class Inefficient extends Table {
    constructor(
        public id: u64 = 0,
        public value: string = "",  // String uses more RAM
        public flag: string = ""    // String uses more RAM
    ) { super(); }
}
```

### 5.3 RAM Cleanup
```typescript
// Clean up unused data
@action("cleanup")
cleanup(): void {
    // Remove old history entries
    let history = this.historyTable.first();
    while (history != null) {
        const next = this.historyTable.next(history);
        if (history.id < currentId - 1000) {  // Keep last 1000 entries
            this.historyTable.remove(history);
        }
        history = next;
    }
}
```

## 6. History Tracking & Audit Trails

### 6.1 Why Track History?
```typescript
// Audit trail benefits:
- Compliance requirements
- Debugging and troubleshooting
- User transparency
- Legal requirements
- Security monitoring
```

### 6.2 History Implementation
```typescript
@table("history")
export class History extends Table {
    constructor(
        public id: u64 = 0,
        public oldValue: u64 = 0,
        public newValue: u64 = 0,
        public updater: Name = new Name()
    ) { super(); }
}

// Record every change
private appendHistory(oldValue: u64, newValue: u64, updater: Name): u64 {
    const history = new History(0, oldValue, newValue, updater);
    this.historyTable.store(history, this.receiver);
    return 0;
}
```

### 6.3 History Query Patterns
```typescript
// Query recent changes
@action("gethistory")
getHistory(): void {
    const last = this.historyTable.last();
    if (last) {
        print(`Last change: ${last.oldValue} → ${last.newValue} by ${last.updater}`);
    }
}

// Query by user
private getUserHistory(user: Name): History[] {
    const history: History[] = [];
    let current = this.historyTable.first();
    
    while (current != null) {
        if (current.updater == user) {
            history.push(current);
        }
        current = this.historyTable.next(current);
    }
    
    return history;
}
```

## 7. Bounds Checking & Validation

### 7.1 Overflow Protection
```typescript
// Prevent integer overflow
private enforceBounds(next: u64): void {
    check(next >= MIN_VALUE, `Value underflows MIN (${MIN_VALUE.toString()})`);
    check(next <= MAX_VALUE, `Value overflows MAX (${MAX_VALUE.toString()})`);
}

// Safe arithmetic
private safeIncrement(current: u64): u64 {
    const next = current + 1;
    this.enforceBounds(next);
    return next;
}
```

### 7.2 Input Validation Patterns
```typescript
// Pattern 1: Range validation
check(value >= MIN_VALUE && value <= MAX_VALUE, "Value out of range");

// Pattern 2: Type validation
check(typeof value === 'u64', "Invalid value type");

// Pattern 3: Business logic validation
check(value != oldValue, "No change detected");
```

## 8. Error Handling Best Practices

### 8.1 Defensive Programming
```typescript
@action("set")
set(actor: Name, value: u64): void {
    // 1. Authorization check
    requireAuth(actor);
    
    // 2. Input validation
    this.enforceBounds(value);
    
    // 3. State validation
    const s = this.getOrInitState();
    const oldValue = s.value;
    
    // 4. Business logic validation
    if (value == oldValue) {
        print(`no change (value remains ${value.toString()})`);
        return;
    }
    
    // 5. Execute with error handling
    try {
        this.appendHistory(oldValue, value, actor);
        s.value = value;
        s.lastUpdater = actor;
        this.stateTable.update(s, this.receiver);
        print(`set -> ${value.toString()} by ${actor.toString()}`);
    } catch (error) {
        print(`Error: ${error.message}`);
        throw error;
    }
}
```

### 8.2 Error Message Guidelines
```typescript
// Good: Specific and actionable
check(value > 0, "Value must be positive");
check(value <= MAX_VALUE, `Value cannot exceed ${MAX_VALUE}`);

// Bad: Generic and unhelpful
check(value > 0, "Invalid value");
check(value <= MAX_VALUE, "Error");
```

## 9. Performance Optimization

### 9.1 Table Operations Optimization
```typescript
// Good: Batch operations
@action("batch_update")
batchUpdate(): void {
    const state = this.getOrInitState();
    
    // Multiple changes in one transaction
    state.value += 10;
    state.lastUpdater = this.receiver;
    state.lastHistoryId = this.appendHistory(oldValue, newValue, this.receiver);
    
    // Single update call
    this.stateTable.update(state, this.receiver);
}

// Bad: Multiple separate operations
@action("inefficient")
inefficient(): void {
    // Multiple separate updates
    this.stateTable.update(state1, this.receiver);
    this.stateTable.update(state2, this.receiver);
    this.stateTable.update(state3, this.receiver);
}
```

### 9.2 Memory Management
```typescript
// Good: Reuse objects
private createHistory(oldValue: u64, newValue: u64, updater: Name): History {
    return new History(0, oldValue, newValue, updater);
}

// Bad: Create new objects unnecessarily
private inefficientHistory(oldValue: u64, newValue: u64, updater: Name): History {
    const history = new History();
    history.id = 0;
    history.oldValue = oldValue;
    history.newValue = newValue;
    history.updater = updater;
    return history;
}
```

## 10. Security Considerations

### 10.1 Authorization Patterns
```typescript
// Pattern 1: Owner-only
@action("owner_only")
ownerOnly(): void {
    requireAuth(this.receiver);
    // Only contract owner can call
}

// Pattern 2: User-specific
@action("user_specific")
userSpecific(actor: Name): void {
    requireAuth(actor);
    // Only specified user can call
}

// Pattern 3: Multi-signature
@action("multisig")
multisig(actor1: Name, actor2: Name): void {
    requireAuth(actor1);
    requireAuth(actor2);
    // Both users must authorize
}
```

### 10.2 Input Sanitization
```typescript
// Sanitize user inputs
@action("safe_input")
safeInput(userInput: string): void {
    // Remove dangerous characters
    const sanitized = userInput.replace(/[<>]/g, "");
    
    // Validate length
    check(sanitized.length <= 100, "Input too long");
    
    // Use sanitized input
    this.processInput(sanitized);
}
```

## 11. Testing Strategies

### 11.1 Unit Testing
```typescript
describe('Counter Contract', () => {
    it('should increment counter', () => {
        const initialValue = contract.get();
        contract.increment("alice");
        const newValue = contract.get();
        expect(newValue).toBe(initialValue + 1);
    });
    
    it('should enforce bounds', () => {
        expect(() => contract.set("alice", MAX_VALUE + 1))
            .toThrow("Value overflows MAX");
    });
});
```

### 11.2 Integration Testing
```typescript
describe('Counter Integration', () => {
    it('should maintain history', () => {
        contract.set("alice", 100);
        contract.increment("alice");
        
        const history = contract.getHistory();
        expect(history).toHaveLength(2);
        expect(history[0].oldValue).toBe(0);
        expect(history[0].newValue).toBe(100);
    });
});
```

## 12. Common Patterns & Anti-Patterns

### 12.1 Good Patterns
```typescript
// Singleton for global state
private getOrInitState(): State {
    let state = this.stateTable.get(0);
    if (!state) {
        state = new State(0, 0, new Name(), 0);
        this.stateTable.store(state, this.receiver);
    }
    return state as State;
}

// Auto-increment for unique IDs
private appendHistory(oldValue: u64, newValue: u64, updater: Name): u64 {
    const id = this.historyTable.availablePrimaryKey;
    const history = new History(id, oldValue, newValue, updater);
    this.historyTable.store(history, this.receiver);
    return id;
}

// Bounds checking
private enforceBounds(value: u64): void {
    check(value >= MIN_VALUE, `Value underflows MIN`);
    check(value <= MAX_VALUE, `Value overflows MAX`);
}
```

### 12.2 Anti-Patterns
```typescript
// No bounds checking
@action("unsafe")
unsafe(value: u64): void {
    this.state.value = value;  // No validation
}

// No authorization
@action("public")
public(): void {
    // Anyone can call this
}

// No error handling
@action("risky")
risky(): void {
    const result = this.riskyOperation();
    // No error handling
}
```

## 13. Advanced Concepts

### 13.1 Event Logging
```typescript
@action("log_event")
logEvent(): void {
    // Log events for off-chain monitoring
    print(`[Event] Counter updated at ${Date.now()}`);
    print(`[Event] New value: ${this.state.value}`);
    print(`[Event] Updated by: ${this.state.lastUpdater}`);
}
```

### 13.2 Contract Upgrades
```typescript
// Version management
@table("version")
export class Version extends Table {
    constructor(
        public id: u64 = 0,
        public version: string = "1.0.0",
        public upgradedAt: u64 = 0
    ) { super(); }
}

@action("upgrade")
upgrade(newVersion: string): void {
    requireAuth(this.receiver);
    
    const version = new Version(0, newVersion, Date.now());
    this.versionTable.store(version, this.receiver);
    
    print(`Contract upgraded to version ${newVersion}`);
}
```

## 14. Comparison with EVM

### 14.1 Storage Models
```solidity
// Solidity (EVM)
contract Counter {
    uint256 public value;
    mapping(uint256 => uint256) public history;
    
    function set(uint256 _value) public {
        value = _value;
        history[block.timestamp] = _value;
    }
}
```

```typescript
// AssemblyScript (Proton)
@contract
export class Counter extends Contract {
    private stateTable: TableStore<State> = new TableStore<State>(this.receiver);
    private historyTable: TableStore<History> = new TableStore<History>(this.receiver);
    
    @action("set")
    set(actor: Name, value: u64): void {
        const state = this.getOrInitState();
        state.value = value;
        this.stateTable.update(state, this.receiver);
        
        this.appendHistory(state.value, value, actor);
    }
}
```

### 14.2 Key Differences
| Feature | Solidity | AssemblyScript |
|---------|----------|----------------|
| Storage | Global variables | TableStore |
| History | Manual tracking | Built-in support |
| Types | Dynamic | Static |
| Memory | Manual | Automatic |

## 15. Next Steps

### 15.1 What You've Learned
- State management patterns
- TableStore operations
- Singleton implementation
- Auto-increment IDs
- RAM optimization
- History tracking
- Bounds checking
- Error handling

### 15.2 What's Next
- Token economics (Token Contract)
- Governance mechanisms (Voting System)
- NFT mechanics (NFT Marketplace)
- DeFi protocols (Lending Protocol)

## 16. Resources

### 16.1 Documentation
- [XPR Network Contract SDK - Storage](https://docs.xprnetwork.org/contract-sdk/storage.html)
- [XPR Network Contract SDK - Execution Order](https://docs.xprnetwork.org/contract-sdk/execution-order.html)
- [XPR Network Contract SDK - Notifications](https://docs.xprnetwork.org/contract-sdk/notifications.html)
- [XPR Network Contract SDK - Testing](https://docs.xprnetwork.org/contract-sdk/testing.html)
- [XPR Network Contract SDK - Security](https://docs.xprnetwork.org/contract-sdk/security.html)

### 16.2 Tools
- Proton CLI
- Block Explorer
- Development Tools
- Testing Frameworks


---

**Remember**: State management is the foundation of smart contract development. Master these concepts before moving to more complex topics like token economics and DeFi protocols.
