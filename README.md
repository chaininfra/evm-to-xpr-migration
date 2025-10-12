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

### Introduction: Proton CLI Setup
**Objective**: Set up development environment with Proton CLI

**Main Content**:
- Proton CLI installation from source
- Key management and account creation
- Network configuration for development
- Basic command usage and troubleshooting

**Key Concepts**:
- Local development setup
- Key pair generation
- Account management
- Network configuration
- CLI operations

**Files**:
- `README.md` - Comprehensive setup guide
- `SETUP.md` - Quick setup reference
- `imgs/` - Visual guides and screenshots

---

### Exercise 1: Hello World Contract
**Objective**: Get familiar with basic structure of XPR Network smart contracts

**Main Content**:
- XPR Network Contract SDK overview
- Basic contract structure with decorators `@contract` and `@action`
- Input validation and error handling
- Basic development workflow

**Key Concepts**:
- Contract decorators
- Action implementation
- Error handling patterns
- Basic security

**Files**:
- `contract.ts` - Main contract implementation
- `THEORY.md` - Detailed theory
- `README.md` - Usage guide

---

### Exercise 2: Simple Storage & State Management
**Objective**: Understand state management in XPR Network contracts

**Main Content**:
- TableStore and database operations
- Singleton pattern implementation
- Auto-increment ID generation
- History tracking and audit trails
- RAM management optimization

**Key Concepts**:
- State persistence
- TableStore operations
- Singleton pattern
- Auto-increment pattern
- RAM optimization

**Files**:
- `contract.ts` - Counter contract with history tracking
- `be.ts` - Backend integration service
- `THEORY.md` - Theory about state management
- `README.md` - Deployment and usage guide

---

### Exercise 3: Token Contract & Token Economics
**Objective**: Build ERC20-like token contract on XPR Network

**Main Content**:
- Token economics fundamentals
- ERC20 standard implementation
- Supply management patterns
- Transfer mechanisms
- Approval system
- RAM management in token contracts

**Key Concepts**:
- Fungible tokens
- Token supply management
- Transfer mechanisms
- Approval system
- RAM optimization
- Authorization patterns

**Files**:
- `contract.ts` - Complete ERC20-like token implementation
- `THEORY.md` - Theory about token economics
- `README.md` - Customization and deployment guide

---

### Exercise 4: Voting System & Governance
**Objective**: Build governance and voting system on XPR Network

**Main Content**:
- Decentralized governance concepts
- Voting mechanisms and proposal lifecycle
- Sybil resistance patterns
- Quorum requirements
- Security patterns in governance

**Key Concepts**:
- Governance fundamentals
- Voting mechanisms
- Proposal lifecycle
- Sybil resistance
- Quorum requirements
- Security patterns

**Files**:
- `contract.ts` - Complete voting system implementation
- `THEORY.md` - Theory about governance
- `README.md` - Voting system usage guide

---

### Exercise 5: NFT Marketplace
**Objective**: Build complete NFT marketplace on XPR Network

**Main Content**:
- NFT fundamentals and marketplace mechanics
- Ownership transfer patterns
- Metadata management
- Marketplace listing and buying mechanisms
- IPFS integration
- Security patterns in NFT contracts

**Key Concepts**:
- Non-fungible tokens
- Marketplace mechanics
- Ownership transfer
- Metadata management
- IPFS integration
- Security patterns

**Files**:
- `contract.ts` - Complete NFT marketplace implementation
- `THEORY.md` - Theory about NFT and marketplace
- `README.md` - NFT lifecycle guide

---

### Exercise 6: DeFi Lending Protocol
**Objective**: Build DeFi lending protocol with liquidation mechanisms

**Main Content**:
- DeFi fundamentals and lending protocols
- Collateralized borrowing mechanisms
- Oracle integration and price feeds
- Liquidation mechanisms
- Risk management and health factor calculations
- Security patterns in DeFi

**Key Concepts**:
- DeFi fundamentals
- Collateralized lending
- Oracle integration
- Liquidation mechanisms
- Risk management
- Health factor calculations

**Files**:
- `contract.ts` - Complete DeFi lending protocol
- `THEORY.md` - Theory about DeFi and lending
- `README.md` - Protocol overview and usage

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
git clone <repository-url>
cd migrate-EVM-XPRConcepts
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

## Learning Path

### Beginner Path
1. **Proton CLI Setup** → **Hello World** → **Simple Storage** → **Token Contract**
2. Focus on basic concepts and patterns
3. Practice with simple implementations

### Intermediate Path
1. **Token Contract** → **Voting System** → **NFT Marketplace**
2. Focus on complex state management
3. Practice with real-world applications

### Advanced Path
1. **NFT Marketplace** → **DeFi Lending Protocol**
2. Focus on DeFi protocols and security
3. Practice with production-ready code

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
        // Transfer logic với TableStore
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

### 1. Testnet Deployment
```bash
# Build contract
npm run build

# Deploy to testnet
proton contract:set <account> ./target

# Verify deployment
proton action <account> <action> '[]' <account>@active
```

### 2. Mainnet Deployment
```bash
# Build contract
npm run build

# Deploy to mainnet
proton contract:set <account> ./target --mainnet

# Verify deployment
proton action <account> <action> '[]' <account>@active --mainnet
```

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

---

## Quick Start

### 0. Setup Proton CLI
```bash
cd 0-introduction
# Follow the setup guide in README.md
# Complete Proton CLI installation
```

### 1. Start with Hello World
```bash
cd exercises/01-hello-world
npm install
npm run build
npm test
```

### 2. Move to Simple Storage
```bash
cd ../02-simple-storage
npm install
npm run build
npm test
```

### 3. Continue with Token Contract
```bash
cd ../03-token-contract
npm install
npm run build
npm test
```

### 4. Explore Advanced Topics
```bash
cd ../04-voting-system
npm install
npm run build
npm test
```

### 5. Build Real Applications
```bash
cd ../05-nft-marketplace
npm install
npm run build
npm test
```

### 6. Master DeFi Protocols
```bash
cd ../06-defi-lending
npm install
npm run build
npm test
```

---

**Ready to migrate from EVM to XPR Network? Start with Proton CLI setup and work your way up to building complex DeFi protocols!**

**Happy coding!**