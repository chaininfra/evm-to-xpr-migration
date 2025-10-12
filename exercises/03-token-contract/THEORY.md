# Theory: Token Contract & Token Economics

## Learning Objectives
- Understand token economics and fungible tokens
- Master ERC20 standard and implementation
- Practice tokenomics design and supply management
- Understand RAM management in token contracts
- Learn authorization patterns and security considerations

## Prerequisites
- Completed Simple Storage contract
- Understanding of state management and TableStore
- Basic knowledge of token economics

## 1. Token Contract Basics

### 1.1 Token Data Structures
Using XPR Network Contract SDK storage system:

```typescript
import { TableStore, Table, Asset, Symbol, Name } from "proton-tsc";

// Global token statistics
@table("stat")
class Stat extends Table {
    constructor(
        public symbol: Symbol = new Symbol("CINFRA", 4),
        public supply: Asset = new Asset(),
        public issuer: Name = new Name()
    ) { super(); }
    
    @primary get primary(): u64 { return this.symbol.code(); }
}

// User account balances
@table("accounts")
class Account extends Table {
    constructor(public balance: Asset = new Asset()) { super(); }
    
    @primary get primary(): u64 { return this.balance.symbol.code(); }
}
```

### 1.2 Basic Token Operations
```typescript
@contract
export class erc20like extends Contract {
    private statTable: TableStore<Stat>;
    
    constructor(receiver: u64, firstReceiver: u64, action: u64) {
        super(Name.fromU64(receiver), Name.fromU64(firstReceiver), Name.fromU64(action));
        const self = this.receiver;
        this.statTable = new TableStore<Stat>(self, self);
    }
}
```

## 2. ERC20 Standard Overview

### 2.1 ERC20 Interface
```typescript
// Core ERC20 functions
interface ERC20Interface {
    // Transfer functions
    transfer(to: Name, amount: Asset): void;
    transferFrom(from: Name, to: Name, amount: Asset): void;
    
    // Approval functions
    approve(spender: Name, amount: Asset): void;
    allowance(owner: Name, spender: Name): Asset;
    
    // Query functions
    balanceOf(account: Name): Asset;
    totalSupply(): Asset;
    
    // Events
    Transfer(from: Name, to: Name, amount: Asset): void;
    Approval(owner: Name, spender: Name, amount: Asset): void;
}
```

### 2.2 ERC20 vs Proton Implementation
```solidity
// Solidity (EVM)
contract ERC20 {
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    
    function transfer(address to, uint256 amount) public returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }
}
```

```typescript
// AssemblyScript (Proton)
@contract
export class erc20like extends Contract {
    private statTable: TableStore<Stat>;
    private accountsTable: TableStore<Account>;
    private allowancesTable: TableStore<Allowance>;
    
    @action("transfer")
    transfer(from: Name, to: Name, quantity: Asset, memo: string = ""): void {
        requireAuth(from);
        // Transfer logic
    }
}
```

## 3. Token Contract Architecture

### 3.1 Data Structures
```typescript
// Global token statistics
@table("stat")
class Stat extends Table {
    constructor(
        public symbol: Symbol = new Symbol("CINFRA", 4),
        public supply: Asset = new Asset(),
        public issuer: Name = new Name()
    ) { super(); }
    
    @primary get primary(): u64 { return this.symbol.code(); }
}

// User account balances
@table("accounts")
class Account extends Table {
    constructor(public balance: Asset = new Asset()) { super(); }
    
    @primary get primary(): u64 { return this.balance.symbol.code(); }
}

// Spending allowances
@table("allowances")
class Allowance extends Table {
    constructor(
        public spender: Name = new Name(),
        public amount: Asset = new Asset()
    ) { super(); }
    
    @primary get primary(): u64 { return this.spender.N; }
}
```

### 3.2 Table Scoping Strategy
```typescript
// Scoping for efficient queries
private getAccountsTable(owner: Name): TableStore<Account> { 
    return new TableStore<Account>(this.receiver, owner); 
}

private getAllowancesTable(owner: Name): TableStore<Allowance> { 
    return new TableStore<Allowance>(this.receiver, owner); 
}
```

**Benefits:**
- Efficient queries by owner
- Reduced RAM usage
- Better performance
- Clear data organization

## 4. Token Supply Management

### 4.1 Minting Mechanism
```typescript
@action("mint")
mint(to: Name, quantity: Asset): void {
    check(isAccount(to), "to account does not exist");
    check(quantity.isValid(), "invalid quantity");
    check(quantity.amount > 0, "must mint positive quantity");

    let stat = this.statTable.first();
    if (stat == null) {
        // First mint: initialize token
        const issuer = Name.fromString("chaininfradv");
        stat = new Stat(quantity.symbol, new Asset(0, quantity.symbol), issuer);
        this.statTable.store(stat, this.receiver);
    }

    requireAuth(stat.issuer);
    this.sameSymbol(quantity, stat.supply);

    // Update total supply
    stat.supply = Asset.add(stat.supply, quantity);
    this.statTable.set(stat, this.receiver);

    // Update user balance
    const accts = this.getAccountsTable(to);
    let row = accts.get(stat.symbol.code());
    if (row == null) { 
        row = new Account(new Asset(0, stat.symbol)); 
        accts.store(row, stat.issuer); 
    }
    row.balance = Asset.add(row.balance, quantity);
    accts.set(row, stat.issuer);

    requireRecipient(to);
    print(`[Mint] ${quantity.toString()} -> ${to.toString()}`);
}
```

### 4.2 Supply Control Patterns
```typescript
// Pattern 1: Fixed supply
const MAX_SUPPLY: u64 = 1_000_000_000_000;

@action("mint")
mint(to: Name, quantity: Asset): void {
    const stat = this.readStatRequired();
    check(stat.supply.amount + quantity.amount <= MAX_SUPPLY, "Exceeds max supply");
    // ... mint logic
}

// Pattern 2: Deflationary (burn on transfer)
@action("transfer")
transfer(from: Name, to: Name, quantity: Asset, memo: string = ""): void {
    // ... transfer logic
    
    // Burn 1% of transfer
    const burnAmount = quantity.amount / 100;
    stat.supply.amount -= burnAmount;
    this.statTable.set(stat, this.receiver);
}

// Pattern 3: Inflationary (mint over time)
@action("mint_inflation")
mintInflation(): void {
    const stat = this.readStatRequired();
    const timeElapsed = Date.now() - stat.lastMint;
    const inflationRate = 1000; // 0.1% per day
    
    if (timeElapsed >= 86400000) { // 24 hours
        const inflationAmount = (stat.supply.amount * inflationRate) / 1000000;
        const inflationAsset = new Asset(inflationAmount, stat.supply.symbol);
        
        stat.supply = Asset.add(stat.supply, inflationAsset);
        stat.lastMint = Date.now();
        this.statTable.set(stat, this.receiver);
    }
}
```

## 5. Transfer Mechanisms

### 5.1 Direct Transfer
```typescript
@action("transfer")
transfer(from: Name, to: Name, quantity: Asset, memo: string = ""): void {
    check(isAccount(to), "to account does not exist");
    check(from != to, "cannot transfer to self");
    check(quantity.isValid(), "invalid quantity");
    check(quantity.amount > 0, "must transfer positive quantity");
    requireAuth(from);

    const stat = this.readStatRequired();
    this.sameSymbol(quantity, stat.supply);

    const fromTable = this.getAccountsTable(from);
    const toTable = this.getAccountsTable(to);

    let fromRow = fromTable.get(stat.symbol.code());
    check(fromRow != null, "no balance object found");
    check(Asset.gte(fromRow!.balance, quantity), "overdrawn balance");

    // Deduct from sender
    fromRow!.balance = Asset.sub(fromRow!.balance, quantity);
    fromTable.set(fromRow!, from);

    // Add to recipient
    let toRow = toTable.get(stat.symbol.code());
    if (toRow == null) { 
        toRow = new Account(new Asset(0, stat.symbol)); 
        toTable.store(toRow, from); 
    }
    toRow.balance = Asset.add(toRow.balance, quantity);
    toTable.set(toRow, from);

    requireRecipient(from);
    requireRecipient(to);
    print(`[Transfer] ${from.toString()} -> ${to.toString()} : ${quantity.toString()} | memo="${memo}"`);
}
```

### 5.2 Delegated Transfer (transferFrom)
```typescript
@action("transferfrom")
transferFrom(spender: Name, from: Name, to: Name, amount: Asset, memo: string = ""): void {
    check(isAccount(to), "to account does not exist");
    check(from != to, "cannot transfer to self");
    check(amount.isValid(), "invalid asset");
    check(amount.amount > 0, "must transfer positive amount");
    requireAuth(spender);

    const stat = this.readStatRequired();
    this.sameSymbol(amount, stat.supply);

    // Check allowance
    const allowances = this.getAllowancesTable(from);
    let allow = allowances.get(spender.N);
    check(allow != null, "no allowance for spender");
    check(Asset.gte(allow!.amount, amount), "insufficient allowance");

    // Reduce allowance
    allow!.amount = Asset.sub(allow!.amount, amount);
    allowances.set(allow!, from);

    // Perform transfer
    const fromTable = this.getAccountsTable(from);
    const toTable = this.getAccountsTable(to);

    let fromRow = fromTable.get(stat.symbol.code());
    check(fromRow != null, "no balance object found");
    check(Asset.gte(fromRow!.balance, amount), "overdrawn balance");

    fromRow!.balance = Asset.sub(fromRow!.balance, amount);
    fromTable.set(fromRow!, from);

    let toRow = toTable.get(stat.symbol.code());
    if (toRow == null) { 
        toRow = new Account(new Asset(0, stat.symbol)); 
        toTable.store(toRow, from); 
    }
    toRow.balance = Asset.add(toRow.balance, amount);
    toTable.set(toRow, from);

    requireRecipient(from);
    requireRecipient(to);
    requireRecipient(spender);
    print(`[TransferFrom] ${spender.toString()} : ${from.toString()} -> ${to.toString()} : ${amount.toString()} | memo="${memo}"`);
}
```

## 6. Approval System

### 6.1 Granting Allowance
```typescript
@action("approve")
approve(owner: Name, spender: Name, amount: Asset): void {
    check(isAccount(spender), "spender account does not exist");
    check(owner != spender, "cannot approve self");
    check(amount.isValid(), "invalid asset");
    check(amount.amount >= 0, "amount must be non-negative");
    requireAuth(owner);

    const stat = this.readStatRequired();
    this.sameSymbol(amount, stat.supply);

    const allowances = this.getAllowancesTable(owner);
    let row = allowances.get(spender.N);
    if (row == null) { 
        row = new Allowance(spender, new Asset(0, stat.symbol)); 
        allowances.store(row, owner); 
    }
    row.amount = amount;
    allowances.set(row, owner);

    requireRecipient(owner);
    requireRecipient(spender);
    print(`[Approval] ${owner.toString()} -> ${spender.toString()} : ${amount.toString()}`);
}
```

### 6.2 Allowance Patterns
```typescript
// Pattern 1: Fixed allowance
@action("approve_fixed")
approveFixed(spender: Name, amount: Asset): void {
    this.approve(this.receiver, spender, amount);
}

// Pattern 2: Unlimited allowance
@action("approve_unlimited")
approveUnlimited(spender: Name): void {
    const unlimitedAmount = new Asset(0xFFFFFFFFFFFFFFFF, this.getSymbol());
    this.approve(this.receiver, spender, unlimitedAmount);
}

// Pattern 3: Time-limited allowance
@table("time_allowances")
class TimeAllowance extends Table {
    constructor(
        public spender: Name = new Name(),
        public amount: Asset = new Asset(),
        public expiresAt: u64 = 0
    ) { super(); }
    
    @primary get primary(): u64 { return this.spender.N; }
}

@action("approve_time_limited")
approveTimeLimited(spender: Name, amount: Asset, duration: u64): void {
    const expiresAt = Date.now() + duration;
    const timeAllowance = new TimeAllowance(spender, amount, expiresAt);
    this.timeAllowancesTable.store(timeAllowance, this.receiver);
}
```

## 7. RAM Management in Token Contracts

### 7.1 RAM Cost Analysis
```typescript
// RAM costs for different operations
const RAM_COSTS = {
    newAccount: 200,      // Creating new account
    balanceUpdate: 50,    // Updating existing balance
    allowanceUpdate: 50,  // Updating allowance
    transfer: 100,        // Transfer operation
    mint: 250,           // Minting new tokens
};
```

### 7.2 RAM Optimization Strategies
```typescript
// Strategy 1: Lazy account creation
@action("transfer")
transfer(from: Name, to: Name, quantity: Asset, memo: string = ""): void {
    // ... validation logic
    
    // Create recipient account only when needed
    let toRow = toTable.get(stat.symbol.code());
    if (toRow == null) { 
        toRow = new Account(new Asset(0, stat.symbol)); 
        toTable.store(toRow, from); // Sender pays RAM
    }
    
    // ... transfer logic
}

// Strategy 2: Batch operations
@action("batch_transfer")
batchTransfer(transfers: TransferData[]): void {
    for (let i = 0; i < transfers.length; i++) {
        const transfer = transfers[i];
        this.transfer(transfer.from, transfer.to, transfer.quantity, transfer.memo);
    }
}

// Strategy 3: RAM cleanup
@action("cleanup_zero_balances")
cleanupZeroBalances(): void {
    let account = this.accountsTable.first();
    while (account != null) {
        const next = this.accountsTable.next(account);
        if (account.balance.amount == 0) {
            this.accountsTable.remove(account);
        }
        account = next;
    }
}
```

## 8. Authorization Patterns

### 8.1 Owner-Based Authorization
```typescript
// Pattern 1: Token owner controls their tokens
@action("transfer")
transfer(from: Name, to: Name, quantity: Asset, memo: string = ""): void {
    requireAuth(from); // Only token owner can transfer
    // ... transfer logic
}

// Pattern 2: Issuer controls supply
@action("mint")
mint(to: Name, quantity: Asset): void {
    const stat = this.readStatRequired();
    requireAuth(stat.issuer); // Only issuer can mint
    // ... mint logic
}
```

### 8.2 Multi-Signature Authorization
```typescript
// Pattern 3: Multi-signature for sensitive operations
@action("emergency_pause")
emergencyPause(): void {
    requireAuth(this.receiver);
    requireAuth(Name.fromString("admin1"));
    requireAuth(Name.fromString("admin2"));
    
    this.paused = true;
    print("Token contract paused");
}

// Pattern 4: Time-locked operations
@table("time_locks")
class TimeLock extends Table {
    constructor(
        public action: string = "",
        public lockedUntil: u64 = 0,
        public authorizedBy: Name = new Name()
    ) { super(); }
}

@action("schedule_action")
scheduleAction(action: string, delay: u64): void {
    requireAuth(this.receiver);
    
    const timeLock = new TimeLock(action, Date.now() + delay, this.receiver);
    this.timeLocksTable.store(timeLock, this.receiver);
    
    print(`Action ${action} scheduled for ${delay}ms from now`);
}
```

## 9. Security Considerations

### 9.1 Common Vulnerabilities
```typescript
// Vulnerability 1: Integer overflow
// Bad: No overflow protection
@action("unsafe_transfer")
unsafeTransfer(amount: Asset): void {
    this.balance += amount.amount; // Potential overflow
}

// Good: Overflow protection
@action("safe_transfer")
safeTransfer(amount: Asset): void {
    check(this.balance + amount.amount >= this.balance, "Overflow detected");
    this.balance += amount.amount;
}

// Vulnerability 2: Reentrancy
// Bad: External call before state update
@action("unsafe_withdraw")
unsafeWithdraw(amount: Asset): void {
    requireRecipient(this.receiver); // External call
    this.balance -= amount.amount;   // State update after
}

// Good: State update before external call
@action("safe_withdraw")
safeWithdraw(amount: Asset): void {
    this.balance -= amount.amount;   // State update first
    requireRecipient(this.receiver); // External call after
}
```

### 9.2 Input Validation
```typescript
// Comprehensive input validation
@action("validated_transfer")
validatedTransfer(from: Name, to: Name, quantity: Asset, memo: string = ""): void {
    // 1. Account validation
    check(isAccount(from), "from account does not exist");
    check(isAccount(to), "to account does not exist");
    
    // 2. Amount validation
    check(quantity.isValid(), "invalid quantity");
    check(quantity.amount > 0, "amount must be positive");
    check(quantity.amount <= MAX_TRANSFER, "amount exceeds maximum");
    
    // 3. Business logic validation
    check(from != to, "cannot transfer to self");
    check(!this.isPaused, "contract is paused");
    
    // 4. Authorization validation
    requireAuth(from);
    
    // 5. State validation
    const fromBalance = this.getBalance(from);
    check(Asset.gte(fromBalance, quantity), "insufficient balance");
    
    // ... transfer logic
}
```

## 10. Event Logging & Monitoring

### 10.1 Event Logging Patterns
```typescript
// Pattern 1: Standard events
@action("transfer")
transfer(from: Name, to: Name, quantity: Asset, memo: string = ""): void {
    // ... transfer logic
    
    // Log events for off-chain monitoring
    print(`[Transfer] ${from.toString()} -> ${to.toString()} : ${quantity.toString()}`);
    print(`[Transfer] Memo: ${memo}`);
    print(`[Transfer] Timestamp: ${Date.now()}`);
}

// Pattern 2: Detailed event logging
@action("detailed_transfer")
detailedTransfer(from: Name, to: Name, quantity: Asset, memo: string = ""): void {
    const fromBalance = this.getBalance(from);
    const toBalance = this.getBalance(to);
    
    // ... transfer logic
    
    print(`[Transfer] From: ${from.toString()} (${fromBalance.toString()})`);
    print(`[Transfer] To: ${to.toString()} (${toBalance.toString()})`);
    print(`[Transfer] Amount: ${quantity.toString()}`);
    print(`[Transfer] Memo: ${memo}`);
    print(`[Transfer] Block: ${this.currentBlock}`);
    print(`[Transfer] Transaction: ${this.currentTransaction}`);
}
```

### 10.2 Monitoring & Analytics
```typescript
// Pattern 3: Analytics tracking
@table("analytics")
class Analytics extends Table {
    constructor(
        public metric: string = "",
        public value: u64 = 0,
        public timestamp: u64 = 0
    ) { super(); }
    
    @primary get primary(): u64 { return this.timestamp; }
}

@action("track_transfer")
trackTransfer(from: Name, to: Name, quantity: Asset): void {
    // Track transfer metrics
    const transferCount = new Analytics("transfer_count", 1, Date.now());
    this.analyticsTable.store(transferCount, this.receiver);
    
    const transferVolume = new Analytics("transfer_volume", quantity.amount, Date.now());
    this.analyticsTable.store(transferVolume, this.receiver);
    
    // Track user activity
    const userActivity = new Analytics(`user_${from.toString()}_transfers`, 1, Date.now());
    this.analyticsTable.store(userActivity, this.receiver);
}
```

## 11. Testing Strategies

### 11.1 Unit Testing
```typescript
describe('Token Contract', () => {
    it('should mint tokens correctly', () => {
        const initialSupply = contract.getTotalSupply();
        contract.mint("alice", Asset.fromString("1000.0000 CINFRA"));
        const newSupply = contract.getTotalSupply();
        expect(newSupply.amount).toBe(initialSupply.amount + 1000);
    });
    
    it('should transfer tokens correctly', () => {
        contract.mint("alice", Asset.fromString("1000.0000 CINFRA"));
        contract.transfer("alice", "bob", Asset.fromString("100.0000 CINFRA"), "test");
        
        const aliceBalance = contract.getBalance("alice");
        const bobBalance = contract.getBalance("bob");
        
        expect(aliceBalance.amount).toBe(900);
        expect(bobBalance.amount).toBe(100);
    });
    
    it('should handle insufficient balance', () => {
        contract.mint("alice", Asset.fromString("100.0000 CINFRA"));
        
        expect(() => {
            contract.transfer("alice", "bob", Asset.fromString("200.0000 CINFRA"), "test");
        }).toThrow("overdrawn balance");
    });
});
```

### 11.2 Integration Testing
```typescript
describe('Token Integration', () => {
    it('should handle complex transfer scenarios', () => {
        // Setup
        contract.mint("alice", Asset.fromString("1000.0000 CINFRA"));
        contract.mint("bob", Asset.fromString("500.0000 CINFRA"));
        
        // Alice approves Bob to spend 200 tokens
        contract.approve("alice", "bob", Asset.fromString("200.0000 CINFRA"));
        
        // Bob transfers 150 tokens from Alice to Charlie
        contract.transferFrom("bob", "alice", "charlie", Asset.fromString("150.0000 CINFRA"), "delegated");
        
        // Verify balances
        expect(contract.getBalance("alice").amount).toBe(850);
        expect(contract.getBalance("bob").amount).toBe(500);
        expect(contract.getBalance("charlie").amount).toBe(150);
        
        // Verify allowance
        expect(contract.getAllowance("alice", "bob").amount).toBe(50);
    });
});
```

## 12. Common Patterns & Anti-Patterns

### 12.1 Good Patterns
```typescript
// Pattern 1: Comprehensive validation
@action("validated_action")
validatedAction(param: Asset): void {
    check(param.isValid(), "invalid asset");
    check(param.amount > 0, "amount must be positive");
    requireAuth(this.receiver);
    // ... action logic
}

// Pattern 2: Proper error handling
@action("safe_action")
safeAction(): void {
    try {
        // ... action logic
        print("Action completed successfully");
    } catch (error) {
        print(`Error: ${error.message}`);
        throw error;
    }
}

// Pattern 3: Event logging
@action("logged_action")
loggedAction(): void {
    // ... action logic
    print(`[Action] Executed at ${Date.now()}`);
    print(`[Action] By ${this.receiver.toString()}`);
}
```

### 12.2 Anti-Patterns
```typescript
// Anti-pattern 1: No validation
@action("unsafe_action")
unsafeAction(param: Asset): void {
    // No validation - dangerous!
    this.balance += param.amount;
}

// Anti-pattern 2: No authorization
@action("public_action")
publicAction(): void {
    // Anyone can call this - security risk!
    this.adminFunction();
}

// ❌ Anti-pattern 3: No error handling
@action("risky_action")
riskyAction(): void {
    // No error handling - can fail silently
    const result = this.riskyOperation();
    // What if result is null?
}
```

## 13. Advanced Concepts

### 13.1 Token Standards Extensions
```typescript
// ERC20 + additional features
@contract
export class ExtendedToken extends Contract {
    // Standard ERC20 functions
    @action("transfer") transfer(from: Name, to: Name, quantity: Asset): void { /* ... */ }
    @action("approve") approve(owner: Name, spender: Name, amount: Asset): void { /* ... */ }
    
    // Additional features
    @action("pause") pause(): void { /* ... */ }
    @action("unpause") unpause(): void { /* ... */ }
    @action("burn") burn(amount: Asset): void { /* ... */ }
    @action("mint") mint(to: Name, amount: Asset): void { /* ... */ }
}
```

### 13.2 Cross-Chain Considerations
```typescript
// Pattern for cross-chain compatibility
@action("bridge_transfer")
bridgeTransfer(to: Name, amount: Asset, targetChain: string): void {
    // Lock tokens on source chain
    this.lockTokens(to, amount);
    
    // Emit event for bridge to pick up
    print(`[Bridge] Transfer ${amount.toString()} to ${targetChain}`);
    print(`[Bridge] Target: ${to.toString()}`);
    print(`[Bridge] Timestamp: ${Date.now()}`);
}
```

## 14. Comparison with EVM

### 14.1 Storage Models
```solidity
// Solidity (EVM)
contract ERC20 {
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    
    function transfer(address to, uint256 amount) public returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }
}
```

```typescript
// AssemblyScript (Proton)
@contract
export class erc20like extends Contract {
    private statTable: TableStore<Stat>;
    private accountsTable: TableStore<Account>;
    private allowancesTable: TableStore<Allowance>;
    
    @action("transfer")
    transfer(from: Name, to: Name, quantity: Asset, memo: string = ""): void {
        // ... transfer logic
    }
}
```

### 14.2 Key Differences
| Feature | Solidity | AssemblyScript |
|---------|----------|----------------|
| Storage | Global mappings | TableStore |
| Types | Dynamic | Static |
| Memory | Manual | Automatic |
| Gas | Variable | Fixed RAM/CPU/NET |

## 15. Next Steps

### 15.1 What You've Learned
- ✅ Token economics fundamentals
- ✅ ERC20 standard implementation
- ✅ Supply management patterns
- ✅ Transfer mechanisms
- ✅ Approval system
- ✅ RAM optimization
- ✅ Authorization patterns
- ✅ Security considerations
- ✅ Event logging
- ✅ Testing strategies

### 15.2 What's Next
- 🔄 Governance mechanisms (Voting System)
- 🔄 NFT mechanics (NFT Marketplace)
- 🔄 DeFi protocols (Lending Protocol)

## 16. Resources

### 16.1 Documentation
- [XPR Network Contract SDK - Storage](https://docs.xprnetwork.org/contract-sdk/storage.html)
- [XPR Network Contract SDK - Execution Order](https://docs.xprnetwork.org/contract-sdk/execution-order.html)
- [XPR Network Contract SDK - Notifications](https://docs.xprnetwork.org/contract-sdk/notifications.html)
- [XPR Network Contract SDK - Testing](https://docs.xprnetwork.org/contract-sdk/testing.html)
- [XPR Network Contract SDK - Security](https://docs.xprnetwork.org/contract-sdk/security.html)

### 16.2 Standards
- [ERC20 Token Standard](https://eips.ethereum.org/EIPS/eip-20)
- [AssemblyScript Documentation](https://www.assemblyscript.org)

### 16.3 Tools
- Proton CLI
- Proton Wallet
- Block Explorer
- Development Tools


---

**Remember**: Token contracts are the foundation of DeFi. Understanding token economics, security patterns, and optimization techniques is crucial for building robust financial applications on blockchain.
