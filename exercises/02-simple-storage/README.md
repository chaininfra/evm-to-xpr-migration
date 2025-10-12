# Simple Storage Contract - Developer Guide

## Project Overview

This is a complete **Smart Contract** on **Proton Blockchain** using **TypeScript**. This project provides a solid foundation for developing blockchain applications with:

- **Smart Contract Development** with Proton TSC framework
- **Table Storage** and data persistence patterns
- **Authorization** and security mechanisms
- **Backend Integration** with blockchain data
- **Production-ready** code with comprehensive error handling

## System Architecture

### Contract Features

Contract `Counter` implements a **bounded counter** with advanced features:

```typescript
// Core Features
- State Management     - Store counter state
- History Tracking     - Track all changes
- Bounds Checking      - Overflow/underflow protection
- Authorization        - Access control
- Error Handling       - Comprehensive error handling
- Debug Logging        - Detailed console output
```

### Data Structure

#### State Table (Singleton Pattern)
```typescript
@table("state")
export class State extends Table {
  constructor(
    public id: u64 = 0,           // Primary key (always = 0)
    public value: u64 = 0,        // Current counter value
    public lastUpdater: Name = new Name(),  // Last updater
    public lastHistoryId: u64 = 0 // Last history entry ID
  ) {
    super();
  }
}
```

#### History Table (Auto-increment Pattern)
```typescript
@table("history")
export class History extends Table {
  constructor(
    public id: u64 = 0,           // Primary key (auto-increment)
    public oldValue: u64 = 0,     // Old value
    public newValue: u64 = 0,     // New value
    public updater: Name = new Name()  // Who made the change
  ) {
    super();
  }
}
```

## Installation and Setup

### Prerequisites

```bash
# System Requirements
Node.js >= 18.0.0
npm or yarn
Proton CLI tools
```

### Installation

```bash
# Clone repository
git clone <repository-url>
cd 02-simple-storage

# Install dependencies
npm install

# Build contract
npm run build

# Run backend service
npm run be
```

## Using the Contract

### Deploy Contract

```bash
# 1. Build contract first
npm run build

# 2. Deploy contract to blockchain
proton action eosio setcode '{"account":"chaininfradv","vmtype":0,"vmversion":0,"code":"'$(xxd -p -c 0 target/contract.wasm)'"}' chaininfradv@active

# 3. Set ABI (if needed)
proton action eosio setabi '{"account":"chaininfradv","abi":"'$(cat target/contract.abi | jq -c .)'"}' chaininfradv@active
```

### Set Counter Values

#### Set specific value
```bash
# Set counter = 100
proton action chaininfradv set '{"actor": "chaininfradv", "value": 100}' chaininfradv@active

# Set counter = 500
proton action chaininfradv set '{"actor": "chaininfradv", "value": 500}' chaininfradv@active

# Set counter = 1000
proton action chaininfradv set '{"actor": "chaininfradv", "value": 1000}' chaininfradv@active
```

#### Increment Counter
```bash
# Increment counter by 1
proton action chaininfradv increment '{"actor": "chaininfradv"}' chaininfradv@active

# Increment multiple times
for i in {1..5}; do
  proton action chaininfradv increment '{"actor": "chaininfradv"}' chaininfradv@active
done
```

#### Decrement Counter
```bash
# Decrement counter by 1
proton action chaininfradv decrement '{"actor": "chaininfradv"}' chaininfradv@active

# Decrement multiple times
for i in {1..3}; do
  proton action chaininfradv decrement '{"actor": "chaininfradv"}' chaininfradv@active
done
```

### Query Data

#### Get current value
```bash
# Print current value to console
proton action chaininfradv get '{}' chaininfradv@active

# Get last updater info
proton action chaininfradv getlastupdt '{}' chaininfradv@active

# Get history info
proton action chaininfradv gethistory '{}' chaininfradv@active
```

#### Query tables directly
```bash
# Query state table
curl -X POST https://testnet-api.chaininfra.net/v1/chain/get_table_rows \
  -H "Content-Type: application/json" \
  -d '{"code":"chaininfradv","table":"state","scope":"chaininfradv","limit":10,"json":true}' | jq

# Query history table
curl -X POST https://testnet-api.chaininfra.net/v1/chain/get_table_rows \
  -H "Content-Type: application/json" \
  -d '{"code":"chaininfradv","table":"history","scope":"chaininfradv","limit":10,"json":true}' | jq
```

### Check Contract

#### Check account info
```bash
# Check account and RAM
curl -X POST https://testnet-api.chaininfra.net/v1/chain/get_account \
  -H "Content-Type: application/json" \
  -d '{"account_name":"chaininfradv"}' | jq '.ram_usage, .ram_quota'
```

#### Check ABI
```bash
# Get contract ABI
curl -X POST https://testnet-api.chaininfra.net/v1/chain/get_abi \
  -H "Content-Type: application/json" \
  -d '{"account_name":"chaininfradv"}' | jq '.abi.actions[]'
```

## Resource Management

### Buy RAM
```bash
# Buy RAM for account (required to deploy contract)
proton action eosio buyram '{"payer":"chaininfradv","receiver":"chaininfradv","quant":"100.0000 XPR"}' chaininfradv@active

# Buy more RAM if needed
proton action eosio buyram '{"payer":"chaininfradv","receiver":"chaininfradv","quant":"200.0000 XPR"}' chaininfradv@active
```

### Stake Resources
```bash
# Stake CPU and NET
proton action eosio delegatebw '{"from":"chaininfradv","receiver":"chaininfradv","stake_net_quantity":"100.0000 XPR","stake_cpu_quantity":"100.0000 XPR","transfer":false}' chaininfradv@active
```

## Development Guide

### Level 1: Basic Understanding

#### 1.1 Contract Structure
```typescript
// File: contract.ts
@contract
export class Counter extends Contract {
  // Table stores
  private stateTable: TableStore<State> = new TableStore<State>(this.receiver);
  private historyTable: TableStore<History> = new TableStore<History>(this.receiver);
  
  // Actions
  @action("set") set(actor: Name, value: u64): void { ... }
  @action("get") get(): void { ... }
  @action("increment") increment(actor: Name): void { ... }
  @action("decrement") decrement(actor: Name): void { ... }
}
```

**Knowledge gained:**
- Contract class structure
- Table store initialization
- Action decorators
- TypeScript types in blockchain

#### 1.2 Constants and Bounds Checking
```typescript
const MIN_VALUE: u64 = 0;
const MAX_VALUE: u64 = 1_000_000_000_000;

private enforceBounds(next: u64): void {
  check(next >= MIN_VALUE, `Value underflows MIN (${MIN_VALUE.toString()})`);
  check(next <= MAX_VALUE, `Value overflows MAX (${MAX_VALUE.toString()})`);
}
```

**Knowledge gained:**
- Security patterns
- Overflow/underflow protection
- Error handling with `check()`
- Constants best practices

### Level 2: Patterns and Architecture

#### 2.1 Singleton Pattern for State
```typescript
private getOrInitState(): State {
  let s = this.stateTable.get(0);
  if (!s) {
    s = new State(0, 0, new Name(), 0);
    this.stateTable.store(s, this.receiver);
    print(`Initialized state with value=${s.value.toString()}`);
  }
  return s as State;
}
```

**Knowledge gained:**
- Lazy initialization
- Singleton pattern in blockchain
- State management
- Memory optimization

#### 2.2 History Tracking Pattern
```typescript
private appendHistory(oldValue: u64, newValue: u64, updater: Name): u64 {
  const h = new History(0, oldValue, newValue, updater);
  this.historyTable.store(h, this.receiver);
  return 0;
}
```

**Knowledge gained:**
- Audit trail implementation
- Data immutability
- Transaction logging
- Compliance patterns

#### 2.3 Authorization Pattern
```typescript
@action("set")
set(actor: Name, value: u64): void {
  requireAuth(actor);  // Check authorization
  // ... rest of logic
}
```

**Knowledge gained:**
- Security best practices
- Permission management
- Access control
- Multi-signature patterns

### Level 3: Advanced Features

#### 3.1 Debug and Logging
```typescript
@action("set")
set(actor: Name, value: u64): void {
  print(`DEBUG: set action called with actor=${actor.toString()}, value=${value.toString()}`);
  requireAuth(actor);
  
  const s = this.getOrInitState();
  const oldValue = s.value;
  print(`DEBUG: current state value=${oldValue.toString()}`);
  
  // ... logic
  
  print(`DEBUG: state updated successfully`);
  print(`set -> ${value.toString()} by ${actor.toString()}`);
}
```

**Knowledge gained:**
- Debugging techniques
- Console logging
- Transaction tracing
- Performance monitoring

#### 3.2 Error Handling
```typescript
if (value == oldValue) {
  print(`no change (value remains ${value.toString()})`);
  return;
}

check(s.value > MIN_VALUE, `Cannot decrement below MIN (${MIN_VALUE.toString()})`);
```

**Knowledge gained:**
- Defensive programming
- User experience
- Error messages
- Edge case handling

## Backend Integration

### Backend Service (`be.ts`)

Backend service using `@proton/js` to interact with blockchain:

```typescript
// Configuration
const CONTRACT_ACCOUNT = 'chaininfradv';
const RPC_ENDPOINT = 'https://testnet-api.chaininfra.net';

// API Functions
export async function getCurrentState(): Promise<StateData | null>
export async function getHistory(limit?: number): Promise<HistoryData[]>
export async function getLastUpdater(): Promise<string | null>
export async function getCurrentValue(): Promise<number>
export async function getAllContractData(): Promise<ContractResponse>
```

### Usage Examples

#### Basic Usage
```typescript
import { getAllContractData } from './be';

const data = await getAllContractData();
console.log(`Current value: ${data.currentValue}`);
console.log(`Last updater: ${data.lastUpdater}`);
console.log(`History entries: ${data.history.length}`);
```

#### Express.js Integration
```typescript
import express from 'express';
import { getAllContractData } from './be';

const app = express();

app.get('/api/contract', async (req, res) => {
  try {
    const data = await getAllContractData();
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

## Debugging and Monitoring

### Backend Service
```bash
# Run backend service to monitor data
npm run be

# Expected output:
# Example: Fetching contract data...
# Contract Summary:
#    Current Value: 333
#    Last Updater: chaininfradv
#    History Entries: 1
```

### Debug Console Output
```bash
# Each action will print debug info to console
proton action chaininfradv set '{"actor": "chaininfradv", "value": 333}' chaininfradv@active

# Console output will show:
# DEBUG: set action called with actor=chaininfradv, value=333
# Initialized state with value=0
# DEBUG: current state value=0
# DEBUG: history entry created with id=0
# DEBUG: state updated successfully
# set -> 333 by chaininfradv
```

## Performance and Optimization

### RAM Management
```bash
# Check RAM usage
curl -s https://testnet-api.chaininfra.net/v1/chain/get_account \
  -X POST -d '{"account_name":"chaininfradv"}' | jq '.ram_usage, .ram_quota'

# Buy RAM if needed
proton action eosio buyram '{"payer":"chaininfradv","receiver":"chaininfradv","quant":"100.0000 XPR"}' chaininfradv@active
```

### Gas Optimization
- Use `store()` for new data
- Use `update()` for existing data
- Minimize table operations
- Optimize string operations

## Security Best Practices

### Input Validation
```typescript
// Bounds checking
this.enforceBounds(value);

// Authorization
requireAuth(actor);

// Type safety
check(typeof value === 'u64', 'Invalid value type');
```

### Access Control
```typescript
// Single user access
requireAuth(actor);

// Multi-signature (advanced)
// requireAuth2([actor1, actor2], [permission1, permission2]);
```

## Monitoring and Analytics

### Contract Metrics
```typescript
// Track usage
print(`Action called: ${actionName} by ${actor.toString()}`);

// Performance metrics
print(`CPU usage: ${cpu_usage_us}μs`);
print(`RAM delta: ${ram_delta} bytes`);
```

### Business Intelligence
```typescript
// Usage analytics
const history = await getHistory(1000);
const usageStats = analyzeUsage(history);

// User behavior
const userActivity = trackUserActivity(history);
```

## Customization and Extension

### Modify Contract

#### Change bounds
```typescript
// In contract.ts, change constants
const MIN_VALUE: u64 = 0;
const MAX_VALUE: u64 = 10_000_000_000; // Increase limit
```

#### Add new action
```typescript
@action("reset")
reset(actor: Name): void {
  requireAuth(actor);
  const s = this.getOrInitState();
  const oldValue = s.value;
  
  if (oldValue == 0) {
    print(`already at zero`);
    return;
  }
  
  const hid = this.appendHistory(oldValue, 0, actor);
  s.value = 0;
  s.lastUpdater = actor;
  s.lastHistoryId = hid;
  this.stateTable.update(s, this.receiver);
  
  print(`reset -> 0 by ${actor.toString()}`);
}
```

### Production Deployment

#### Mainnet Deployment
```bash
# Change endpoint to mainnet
# In be.ts: const RPC_ENDPOINT = 'https://proton.greymass.com';

# Deploy to mainnet
proton action eosio setcode '{"account":"yourcontract","vmtype":0,"vmversion":0,"code":"'$(xxd -p -c 0 target/contract.wasm)'"}' yourcontract@active
```

#### Environment Configuration
```typescript
// be.ts - Environment config
const CONTRACT_ACCOUNT = process.env.CONTRACT_ACCOUNT || 'chaininfradv';
const RPC_ENDPOINT = process.env.RPC_ENDPOINT || 'https://testnet-api.chaininfra.net';
const HISTORY_LIMIT = parseInt(process.env.HISTORY_LIMIT || '100');
```

## Troubleshooting

### Common Issues

#### 1. RAM Insufficient
```bash
Error: account has insufficient ram; needs 172965 bytes has 58398 bytes
Solution: Buy more RAM
proton action eosio buyram '{"payer":"account","receiver":"account","quant":"200.0000 XPR"}' account@active
```

#### 2. Invalid Iterator
```bash
Error: invalid iterator
Solution: Check table operations, avoid using .last() on empty tables
```

#### 3. Authorization Failed
```bash
Error: transaction declares authority but does not have signatures
Solution: Check account permissions and signatures
```

#### 4. Build Errors
```bash
Error: Not implemented: Exceptions
Solution: Remove try-catch blocks (AssemblyScript doesn't support exceptions)
```

### Debug Techniques

#### 1. Console Logging
```typescript
print(`DEBUG: Variable value = ${variable.toString()}`);
```

#### 2. State Inspection
```typescript
const state = await getCurrentState();
console.log('Current state:', state);
```

#### 3. Transaction Analysis
```bash
# Check transaction details
proton get transaction <transaction_id>
```

## Contributing

### Code Standards
- Use TypeScript strict mode
- Comment all functions thoroughly
- Follow naming conventions
- Include error handling

### Testing Requirements
- Unit tests for all functions
- Integration tests for contract
- Performance benchmarks
- Security audits

## 📄 License

MIT License - See [LICENSE](LICENSE) file for details.

---

## Conclusion

This project provides a **production-ready smart contract** on Proton blockchain with complete features:

- **Complete Contract** - Counter with bounds checking and history tracking
- **Backend Integration** - Service to query data from blockchain
- **Security Features** - Authorization and input validation
- **Error Handling** - Comprehensive error handling and logging
- **Documentation** - Complete usage and customization guide

### Quick Start
```bash
# 1. Setup
npm install && npm run build

# 2. Deploy
proton action eosio setcode '{"account":"chaininfradv","vmtype":0,"vmversion":0,"code":"'$(xxd -p -c 0 target/contract.wasm)'"}' chaininfradv@active

# 3. Use
proton action chaininfradv set '{"actor": "chaininfradv", "value": 100}' chaininfradv@active

# 4. Monitor
npm run be
```

**Ready to build amazing blockchain applications!**