# Introduction: Proton CLI Setup

## Overview

This section provides a comprehensive guide for setting up Proton CLI, which is essential for developing and deploying smart contracts on the XPR Network. Since Proton CLI is not available through npm, it needs to be built and installed locally.

## Prerequisites

Before proceeding, ensure you have the following installed:
- **Node.js v18+** - JavaScript runtime
- **Git** - Version control system
- **npm** - Node package manager

## Installation Steps

### 1. Clone Proton CLI Repository

```bash
# Clone the Proton CLI repository
git clone https://github.com/ProtonProtocol/proton-cli.git

# Navigate to the cloned directory
cd proton-cli
```

### 2. Install Dependencies

```bash
# Install all required dependencies
npm install
```

### 3. Build Proton CLI

```bash
# Build the Proton CLI from source
npm run build
```

### 4. Link Proton CLI Globally

```bash
# Create a global symlink for proton command
npm link
```

### 5. Verify Installation

```bash
# Check if proton CLI is properly installed
proton --version

# View available commands
proton --help
```

## Key Management

### 1. Generate Key Pair

```bash
# Generate new key pair using Proton CLI
proton key:generate

# Or use external tools
cleos create key --to-console

# Or use online key generator
# Visit: https://nadejde.github.io/eos-token-sale/
```

### 2. Manage Keys

```bash
# List all keys
proton key:list

# Add existing key
proton key:add <key-name> <private-key>

# Lock keys with password
proton key:lock

# Unlock keys
proton key:unlock
```

### 3. Create Account

```bash
# Create account (interactive mode)
proton account:create <account-name>

# Account creation will prompt for key selection
```

## Configuration

### 1. Set Network

```bash
# Set to testnet (recommended for development)
proton chain:set proton-test

# Set to mainnet (for production)
proton chain:set proton
```

### 2. Account Information

```bash
# Get account information
proton account <account-name>

# Get account with token balances
proton account <account-name> --tokens

# Get raw account data
proton account <account-name> --raw
```

## Common Commands

### Contract Operations

```bash
# Deploy contract (WASM + ABI)
proton contract:set <account> <path>

# Deploy only ABI
proton contract:set <account> <path> --abiOnly

# Deploy only WASM
proton contract:set <account> <path> --wasmOnly

# Clear contract
proton contract:clear <account>

# Get contract ABI
proton contract:abi <account>

# Enable inline actions
proton contract:enableinline <account>
```

### Action Execution

```bash
# Execute action
proton action <contract> <action> '<params>' <authorization>

# Example: Call sayhello action
proton action hello sayhello '[]' myaccount@active
```

### Account Operations

```bash
# Get account information
proton account <account>

# Get account with token balances
proton account <account> --tokens

# Get raw account data
proton account <account> --raw
```

### Network Operations

```bash
# Get current chain
proton chain:get

# Get chain info
proton chain:info

# List all networks
proton chain:list

# Set chain
proton chain:set <chain-name>
```

### Table Operations

```bash
# Get table data
proton table <contract> <table> <scope>

# Get table with limit
proton table <contract> <table> <scope> --limit 10

# Get table with bounds
proton table <contract> <table> <scope> --lowerBound 1 --upperBound 100
```

## Troubleshooting

### Common Issues

#### 1. Build Errors
```bash
# Clear npm cache and reinstall
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
npm run build
```

#### 2. Permission Errors
```bash
# Fix npm permissions (Linux/Mac)
sudo chown -R $(whoami) ~/.npm
sudo chown -R $(whoami) /usr/local/lib/node_modules
```

#### 3. Link Issues
```bash
# Unlink and relink
npm unlink -g proton-cli
npm link
```

### Verification Steps

1. **Check Node.js Version**
   ```bash
   node --version
   # Should be v18 or higher
   ```

2. **Check npm Version**
   ```bash
   npm --version
   # Should be v8 or higher
   ```

3. **Verify Proton CLI**
   ```bash
   proton --version
   # Should display version information
   ```

4. **Test Network Connection**
   ```bash
   proton chain:get
   # Should return network information
   ```

## Development Workflow

### 1. Setup Development Environment

```bash
# Set to testnet
proton chain:set proton-test

# Create development account (interactive)
proton account:create dev-account

# Note: Account creation requires XPR tokens for RAM allocation
```

### 2. Deploy and Test Contract

```bash
# Build your contract
npm run build

# Deploy to testnet
proton contract:set dev-account ./target

# Test contract action
proton action dev-account sayhello '[]' dev-account@active
```

### 3. Monitor and Debug

```bash
# Get contract logs
proton logs:get <account>

# Get account actions
proton actions:get <account>

# Get table data
proton table:get <account> <table-name>
```

## Best Practices

### 1. Key Management
- Use `proton key:generate` to create new key pairs
- Use `proton key:lock` to secure keys with password
- Store private keys securely, never commit to version control
- Use hardware wallets for production keys

### 2. Account Management
- Use descriptive account names
- Keep track of account permissions
- Monitor account balances
- Set appropriate RAM and CPU limits

### 3. Development
- Always test on testnet first
- Use meaningful action names
- Implement proper error handling
- Monitor contract performance

### 4. Security
- Validate all inputs
- Use proper authorization
- Implement rate limiting
- Regular security audits

## Next Steps

After completing the Proton CLI setup:

1. **Proceed to Exercise 1**: Hello World Contract
2. **Learn Basic Commands**: Practice with simple contract operations
3. **Explore Advanced Features**: Use CLI for complex deployments
4. **Join Community**: Connect with other developers

---

**Ready to start building? Move on to Exercise 1: Hello World Contract!**
