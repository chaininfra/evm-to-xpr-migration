# Migrate EVM to XPR Concepts

## Overview

This course guides developers to migrate from Ethereum Virtual Machine (EVM) to XPR Network Contract SDK, helping you master new concepts and patterns in smart contract development on XPR Network.

## Course Objectives

- **Understand the differences** between EVM and XPR Network architecture
- **Master XPR Network Contract SDK** and its main components
- **Practice migration patterns** from Solidity to AssemblyScript
- **Build complete DeFi applications** on XPR Network
- **Apply best practices** for security and performance

## Course Structure

Follow the exercises in order — each builds on concepts from the previous one. Every folder contains its own `README.md` (usage), `THEORY.md` (concepts), and `contract.ts` (implementation).

| # | Exercise | Difficulty | Focus | Key concepts introduced |
|---|---|---|---|---|
| 0 | [Proton CLI Setup](exercises/0-protoncli-setup/) | — | Tooling | CLI install, key pairs, account creation, network config |
| 1 | [Hello World](exercises/01-hello-world/) | Beginner | Contract structure | `@contract`, `@action`, input validation, dev workflow |
| 2 | [Simple Storage](exercises/02-simple-storage/) | Beginner | State management | `TableStore`, singleton rows, auto-increment IDs, RAM payer, audit history |
| 3 | [Token Contract](exercises/03-token-contract/) | Intermediate | Fungible tokens | ERC20-equivalent supply/transfer/approve, `Asset` precision, auth patterns |
| 4 | [Voting System](exercises/04-voting-system/) | Intermediate | Governance | Proposal lifecycle, quorum, Sybil resistance, multi-row state |
| 5 | [NFT Marketplace](exercises/05-nft-marketplace/) | Advanced | Non-fungible tokens | Ownership transfer, metadata, listings, IPFS, marketplace mechanics |
| 6 | [DeFi Lending](exercises/06-defi-lending/) | Advanced | DeFi protocols | Collateralized borrowing, oracles, liquidation, health-factor math |

## Prerequisites

### Required Knowledge
- **Blockchain fundamentals** - Basic understanding of blockchain
- **Smart contract development** - Experience with Solidity (optional)
- **TypeScript/JavaScript** - Programming knowledge
- **DeFi concepts** - Basic understanding of DeFi (for exercise 6)

### Required Tools
- **Node.js v18+** - JavaScript runtime
- **Proton CLI** - Command line tools
- **Proton Wallet** - Wallet for testing
- **Code Editor** - VS Code, WebStorm, etc.

## Installation & Setup

### 1. Clone Repository
```bash
git clone https://github.com/<your-org>/evm-to-xpr-migration.git
cd evm-to-xpr-migration
```

### 2. Install Dependencies
```bash
# Install dependencies for each exercise
cd exercises/01-hello-world
npm install

cd ../02-simple-storage
npm install

# ... continue for other exercises
```

### 3. Setup Development Environment
```bash
# Install Proton CLI
npm install -g @proton/cli

# Setup Proton account
proton account:create <account-name>
```

## Quick Start

```bash
# 1. Set up the CLI (once)
cd exercises/0-protoncli-setup
# follow README.md to install Proton CLI and create an account

# 2. For each exercise:
cd exercises/01-hello-world   # or whichever you're on
npm install
npm run build
npm test                       # where tests are provided
```

Difficulty escalates with each exercise — see the table above. New to XPR Network? Start at 0 and go in order. Already comfortable with `@contract` / `TableStore`? You can jump in at 3 (tokens) or 4 (voting).

## Key Differences: EVM vs XPR Network

### Architecture Comparison
| Aspect | EVM (Ethereum) | XPR Network |
|--------|----------------|-------------|
| **Virtual Machine** | EVM | WebAssembly (WASM) |
| **Language** | Solidity | AssemblyScript/TypeScript |
| **Gas Model** | Gas fees | RAM + CPU + NET |
| **Account Model** | Externally Owned + Contract | Account-based |
| **Consensus** | Proof of Stake | Delegated Proof of Stake |
| **Storage** | Global variables | TableStore |
| **Memory** | Manual management | Automatic management |

### EVM → XPR Cheatsheet

A one-page lookup table for the concepts you'll hit on day one. Each row maps a Solidity primitive to its XPR Network Contract SDK equivalent — and flags the cases where the mental model genuinely changes, not just the syntax.

| Solidity / EVM | XPR Network | Notes for migrators |
|---|---|---|
| `address` | `Name` (12-char base32, a-z 1-5) | Account-based. No `0x` addresses; account names are human-readable and registered on-chain. |
| `msg.sender` | Action `actor` arg + `requireAuth(actor)` | No implicit sender. The caller is an explicit parameter on every action; you must `requireAuth` it. |
| `mapping(k => v)` | `TableStore<Row>` with primary + secondary indexes | Indexed row-based storage, not a hash map. Max 4 secondary indexes per table. |
| `struct` (storage) | `@table` class extending `Table` | Each row is a class instance; primary key is a `u64` method. |
| `modifier onlyOwner` | Inline `requireAuth(owner)` at top of action | No modifier system; compose with helper methods if reused. |
| `require(cond, "msg")` | `check(cond, "msg")` | Same semantics — aborts the transaction. |
| `revert("msg")` | `check(false, "msg")` | |
| `event Foo(...)` + `emit` | `require_recipient(account)` / action traces | **No native events.** Off-chain indexers tail action traces or recipient notifications. Biggest mental shift. |
| `payable` / `msg.value` | `transfer` notification handler on `eosio.token` | No value-bearing calls. Tokens are a separate contract; you handle their inline transfer notifications. |
| `block.timestamp` | `currentTimePoint()` / `currentTimeSec()` | |
| `block.number` | `currentBlock()` / tapos block num | |
| `tx.origin` | No equivalent — by design | Use the action's `actor` arg. |
| `uint256` | `u64` or `Asset` (i64 amount + symbol) | **No native 256-bit.** Token amounts use `Asset`'s fixed precision. Watch for overflow on `u64`. |
| `int256` | `i64` | |
| `address(this)` | `this.receiver` | The account hosting the contract. |
| `external` / `public` call | `@action` | All actions are externally callable; visibility is enforced via auth, not modifier. |
| `internal` / `private` fn | Plain class method | Not exposed unless decorated `@action`. |
| Cross-contract call | Inline action (`sendInline` / `Action.new(...).send()`) | Synchronous within the same transaction; same auth rules. |
| `delegatecall` | No equivalent | Different upgrade model — see "Contract upgrades" below. |
| `selfdestruct` | `proton contract:clear` (CLI) | No in-contract self-destruct opcode. |
| Gas | RAM + CPU + NET | **Pre-paid by the account that pays for the action**, not per-tx. RAM is purchased and persistent; CPU/NET refill over time. |
| Reentrancy via external call | Inline actions are synchronous; recipient notifications run *after* the calling action | Different attack surface — see "Common pitfalls" below. |
| Contract upgrade via proxy | `proton contract:set` redeploys the WASM in place | State (tables) is preserved across deploys unless schema changes. No proxy pattern needed. |
| `keccak256` | `sha256` / `ripemd160` available; no native keccak | If porting hash-dependent logic, plan for hash function divergence. |
| `abi.encodePacked` | `Pack`/`Unpack` from the SDK | Different serialization (FlatBuffers-style). |
| `view` / `pure` functions | Read tables from off-chain via `get_table_rows` RPC | **No on-chain read-only calls.** Read paths live off-chain. |
| Reverting state on error | `check()` aborts the whole transaction | Same effect — all writes in the transaction roll back. |

### Common Pitfalls for EVM Developers

The traps that catch every migrator at least once. Each is rooted in a place where the XPR mental model diverges from EVM in a non-obvious way.

1. **There is no `msg.sender`.** Every action takes the caller as an explicit `Name` argument, and you must `requireAuth(that_name)` yourself. Forget the `requireAuth` and *anyone* can call your action claiming to be anyone.
2. **RAM is paid storage, not free.** Every row you insert costs the payer RAM (in bytes, priced on-chain). If the user pays, they must sign; if the contract pays, the contract account must hold the RAM. Plan a RAM-payer strategy *before* writing the table.
3. **No events.** Off-chain consumers read action traces or rely on `require_recipient()`-driven notifications. If you `emit`-ed in Solidity, the equivalent here is "make sure the action argument list contains everything an indexer needs."
4. **Notification handlers run *after* the originating action.** When `eosio.token::transfer` notifies your contract, your handler executes in the same transaction but after the transfer is already booked. You cannot prevent the transfer — you can only react and `check()` to abort the whole tx.
5. **No `payable`.** To receive value, you handle the `transfer` notification from `eosio.token` (or whatever token contract). The amount and sender come from the action data, not implicit globals.
6. **Reentrancy looks different.** Inline actions execute synchronously and atomically, so classic ETH reentrancy via `.call{value:}` doesn't exist. But notification-handler ordering and deferred-action patterns introduce their own ordering footguns — assume re-entry via notification and write idempotent handlers.
7. **`Asset` has fixed precision per symbol.** `Asset(1, "4,XPR")` is 0.0001 XPR, not 1 XPR. Symbol precision is part of the symbol; mixing precisions silently produces garbage. Always validate symbol on incoming transfers.
8. **No 256-bit math.** Most token math is `u64` or `Asset`. Multiplying two large `u64` values overflows silently. Use checked arithmetic helpers or pre-scale.
9. **Secondary indexes are capped.** A `TableStore` row supports at most 4 secondary indexes. If your Solidity contract leaned on many `mapping`s keyed off the same struct, you'll need to denormalize or use multiple tables.
10. **Deferred transactions are deprecated/disabled.** Patterns that relied on `transaction.send_deferred()` for "callbacks" need to be redesigned as off-chain workers that submit follow-up actions.
11. **Contract upgrades are in-place.** `proton contract:set` overwrites the WASM. There is no proxy pattern. But if you change a table's schema, existing rows won't auto-migrate — write a migration action.
12. **CPU/NET exhaustion looks like a hang, not a revert.** If a transaction blows the CPU budget of its payer, it fails with a billing error, not a `require` revert. Test with realistic data volumes against a constrained account.
13. **`get_table_rows` is the only "view" path.** There is no on-chain `view` function callable from another contract. If contract A needs to read contract B's state on-chain, B must expose it via a write action or A must read its tables directly with `TableStore<...>(other_account)`.
14. **String operations are expensive.** AssemblyScript strings are UTF-16 internally and concat/format eats CPU. Prefer fixed-size encodings and `Name` where possible.

### Migration Patterns

#### 1. Contract Structure
```solidity
// Solidity (EVM)
contract HelloWorld {
    function greet(string memory name) public pure returns (string memory) {
        return string(abi.encodePacked("Hello, ", name, "!"));
    }
}
```

```typescript
// AssemblyScript (XPR Network)
@contract
export class HelloWorld extends Contract {
    @action("greet")
    greet(name: string): string {
        return "Hello, " + name + "!";
    }
}
```

#### 2. State Management
```solidity
// Solidity (EVM)
contract Counter {
    uint256 public value;
    
    function increment() public {
        value += 1;
    }
}
```

```typescript
// AssemblyScript (XPR Network)
@contract
export class Counter extends Contract {
    private stateTable: TableStore<State> = new TableStore<State>(this.receiver);
    
    @action("increment")
    increment(): void {
        const state = this.getOrInitState();
        state.value += 1;
        this.stateTable.update(state, this.receiver);
    }
}
```

#### 3. Token Implementation
```solidity
// Solidity (EVM)
contract ERC20 {
    mapping(address => uint256) public balanceOf;
    
    function transfer(address to, uint256 amount) public returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        return true;
    }
}
```

```typescript
// AssemblyScript (XPR Network)
@contract
export class erc20like extends Contract {
    private accountsTable: TableStore<Account> = new TableStore<Account>(this.receiver);
    
    @action("transfer")
    transfer(from: Name, to: Name, quantity: Asset): void {
        requireAuth(from);
        // Transfer logic with TableStore
    }
}
```

## Best Practices

### 1. Security Patterns
- **Input validation** - Always validate user inputs
- **Authorization checks** - Use `requireAuth()` appropriately
- **Bounds checking** - Prevent overflow/underflow
- **State consistency** - Maintain data integrity

### 2. Performance Optimization
- **RAM management** - Optimize storage usage
- **Batch operations** - Group related operations
- **Efficient queries** - Use proper indexing
- **Memory management** - Avoid memory leaks

### 3. Code Organization
- **Modular design** - Separate concerns
- **Clear naming** - Use descriptive names
- **Documentation** - Comment complex logic
- **Testing** - Comprehensive test coverage

## Testing Strategy

### 1. Unit Testing
- Test individual functions
- Mock external dependencies
- Validate edge cases
- Check error conditions

### 2. Integration Testing
- Test complete workflows
- Validate state changes
- Check cross-contract interactions
- Performance testing

### 3. Security Testing
- Authorization testing
- Input validation testing
- Edge case testing
- Attack vector testing

## Deployment Guide

Proton CLI selects the target network via `proton chain:set` (persisted) or a per-command `--url` flag — **there is no `--mainnet` flag**.

### 1. Testnet Deployment
```bash
# Point CLI at testnet (one-time)
proton chain:set https://testnet.rockerone.io

# Build contract
npm run build

# Deploy
proton contract:set <account> ./target

# Verify deployment
proton action <account> <action> '[]' <account>@active
```

### 2. Mainnet Deployment
```bash
# Point CLI at mainnet (one-time)
proton chain:set https://proton.greymass.com

# Build contract
npm run build

# Deploy
proton contract:set <account> ./target

# Verify deployment
proton action <account> <action> '[]' <account>@active
```

> Confirm the current endpoints against [docs.xprnetwork.org](https://docs.xprnetwork.org) before relying on them — RPC URLs rotate.

## Resources

### Documentation
- [XPR Network Contract SDK - Storage](https://docs.xprnetwork.org/contract-sdk/storage.html)
- [XPR Network Contract SDK - Execution Order](https://docs.xprnetwork.org/contract-sdk/execution-order.html)
- [XPR Network Contract SDK - Notifications](https://docs.xprnetwork.org/contract-sdk/notifications.html)
- [XPR Network Contract SDK - Testing](https://docs.xprnetwork.org/contract-sdk/testing.html)
- [XPR Network Contract SDK - Security](https://docs.xprnetwork.org/contract-sdk/security.html)


## Contributing

### How to Contribute
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

### Code Standards
- Use TypeScript strict mode
- Follow naming conventions
- Add comprehensive comments
- Include error handling
- Write tests for all functions

## License

MIT License - See [LICENSE](LICENSE) file for details.

## Support

### Getting Help
- Check the [XPR Network Documentation](https://docs.xprnetwork.org)
- Review [EVM to XPR Migration Guide](https://docs.xprnetwork.org/migration)