# Theory: Hello World Smart Contract

## Learning Objectives
- Understand basic structure of smart contract on Proton blockchain
- Master decorators and Proton-TSC framework
- Practice validation and error handling
- Compare with EVM smart contracts

## Prerequisites
- Basic knowledge of blockchain
- Understanding of TypeScript/JavaScript
- Knowledge of smart contracts (optional)

## 1. XPR Network Smart Contract Overview

### 1.1 Contract SDK Components
The XPR Network Contract SDK provides essential building blocks for smart contract development:

- **Storage**: TableStore for persistent data storage
- **Execution Order**: Deterministic action execution
- **Inline Actions**: Cross-contract communication
- **Notifications**: Event emission and monitoring
- **Testing**: Comprehensive testing framework
- **Security**: Built-in security patterns

### 1.2 Basic Contract Structure
```typescript
import { Contract } from "proton-tsc";

@contract
export class HelloWorld extends Contract {
    // Contract implementation
}
```

## 2. Action Implementation

### 2.1 Basic Action Structure
```typescript
@action("sayhello")
sayHello(): string {
    return "Hello, Proton World!";
}
```

**Key Components:**
- `@action`: Decorator marking method as callable action
- Action name: "sayhello" - how it's called externally
- Return type: string for console output

### 2.2 Action Parameters and Validation
```typescript
@action("greet")
greet(name: string): string {
    // Input validation
    if (name.length === 0) {
        throw new Error("Name cannot be empty");
    }
    
    if (name.length > 50) {
        throw new Error("Name too long (max 50 characters)");
    }
    
    return "Hello, " + name + "! Welcome to Proton Network!";
}
```

**Key Points:**
- Input validation prevents invalid data
- Error handling with descriptive messages
- Parameter constraints ensure data integrity

## 3. XPR Network Contract SDK

### 3.1 Essential Imports
```typescript
import { Contract } from "proton-tsc";
```

### 3.2 Basic Types
```typescript
// Core types used in contracts
string        // Text strings
boolean       // True/false values
u64           // Unsigned 64-bit integer
i64           // Signed 64-bit integer
```

## 4. Contract Decorators

### 4.1 @contract Decorator
```typescript
@contract
export class HelloWorld extends Contract {
    // Contract implementation
}
```

**Purpose:**
- Marks class as deployable smart contract
- Enables blockchain integration

### 4.2 @action Decorator
```typescript
@action("sayhello")
sayHello(): string {
    return "Hello, Proton World!";
}
```

**Key Points:**
- Action name: "sayhello" - external identifier
- Method name: sayHello - internal implementation
- Return value: displayed in console output

## 5. Error Handling

### 5.1 Basic Error Handling
```typescript
@action("greet")
greet(name: string): string {
    if (name.length === 0) {
        throw new Error("Name cannot be empty");
    }
    
    if (name.length > 50) {
        throw new Error("Name too long (max 50 characters)");
    }
    
    return "Hello, " + name + "! Welcome to Proton Network!";
}
```

### 5.2 Error Message Guidelines
- Use descriptive error messages
- Validate input early in the function
- Provide clear guidance on what went wrong

## 6. Basic Security

### 6.1 Input Validation
```typescript
@action("greet")
greet(name: string): string {
    // Validate input length
    if (name.length === 0) {
        throw new Error("Name cannot be empty");
    }
    
    if (name.length > 50) {
        throw new Error("Name too long (max 50 characters)");
    }
    
    return "Hello, " + name + "! Welcome to Proton Network!";
}
```

### 6.2 Best Practices
- Always validate user input
- Use descriptive error messages
- Keep functions simple and focused

## 7. Development Workflow

### 7.1 Basic Setup
```bash
# Install dependencies
npm install

# Build contract
npm run build

# Test contract
npm test
```

### 7.2 Contract Structure
```
01-hello-world/
├── contract.ts          # Main contract file
├── package.json         # Dependencies
├── tsconfig.json        # TypeScript config
└── target/              # Build output
    ├── contract.wasm    # Compiled contract
    └── contract.abi     # Contract interface
```

## 8. Common Issues

### 8.1 Missing Action Decorator
```typescript
// Bad: Missing @action decorator
sayHello(): string {
    return "Hello, World!";
}

// Good: Proper decorator
@action("sayhello")
sayHello(): string {
    return "Hello, World!";
}
```

### 8.2 Missing Contract Decorator
```typescript
// Bad: Missing @contract decorator
export class HelloWorld extends Contract {
    // Contract implementation
}

// Good: Proper decorator
@contract
export class HelloWorld extends Contract {
    // Contract implementation
}
```

## 9. Next Steps

### 9.1 What You've Learned
- Basic contract structure
- Action decorators
- Input validation
- Error handling
- Basic security

### 9.2 What's Next
- State management (Simple Storage)
- Token economics (Token Contract)
- Governance (Voting System)
- NFT mechanics (NFT Marketplace)
- DeFi protocols (Lending Protocol)

## 10. Resources

### 10.1 Documentation
- [XPR Network Contract SDK - Storage](https://docs.xprnetwork.org/contract-sdk/storage.html)
- [XPR Network Contract SDK - Execution Order](https://docs.xprnetwork.org/contract-sdk/execution-order.html)
- [XPR Network Contract SDK - Notifications](https://docs.xprnetwork.org/contract-sdk/notifications.html)
- [XPR Network Contract SDK - Testing](https://docs.xprnetwork.org/contract-sdk/testing.html)
- [XPR Network Contract SDK - Security](https://docs.xprnetwork.org/contract-sdk/security.html)

### 10.2 Tools
- Proton CLI
- Proton Wallet
- Block Explorer
- Development Tools

---

**Remember**: This is just the beginning! Smart contract development requires continuous learning and practice. Each concept builds upon the previous ones, so make sure you understand each part before moving to the next exercise.
