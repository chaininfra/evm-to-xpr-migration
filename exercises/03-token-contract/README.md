# Proton Token Contract - Developer Guide

## Overview

This is a production-ready ERC20-like token contract for the Proton blockchain, implemented in AssemblyScript using the proton-tsc framework. This contract provides a complete token implementation that you can deploy, customize, and extend for your own projects.

**What you get:**
- Complete token contract with all standard ERC20 functions
- Proper RAM management and authorization
- Production-ready code with comprehensive error handling
- Full test suite and deployment instructions
- Detailed documentation for customization

## Quick Start

### For Developers Who Want to Use This Contract

1. **Clone and Deploy**:
   ```bash
   git clone <repository>
   cd token-contract
   npm install
   npm run build
   proton contract:set your_account target/contract.wasm target/contract.abi
   ```

2. **Customize for Your Token**:
   - Change token symbol in `contract.ts`
   - Update issuer account
   - Modify token name and precision
   - Deploy to your account

3. **Start Using**:
   ```bash
   # Mint your first tokens
   proton action your_account mint '{"to":"recipient","quantity":"1000.0000 YOURTOKEN"}' your_account@active
   
   # Transfer tokens
   proton action your_account transfer '{"from":"sender","to":"recipient","quantity":"100.0000 YOURTOKEN","memo":"payment"}' sender@active
   ```

### For Developers Learning Smart Contract Development

This contract demonstrates:
- Smart contract architecture on Proton blockchain
- RAM management and resource allocation
- Authorization and permission systems
- Token economics and supply management
- Action dispatch and data parsing
- Table storage and data persistence
- Event logging and off-chain integration

## Contract Architecture

### Core Components

**Contract Class**: `erc20like`
- Inherits from `Contract` base class
- Manages token state and operations
- Handles authorization and validation

**Data Structures**:
- `Stat`: Token statistics (symbol, supply, issuer)
- `Account`: User balance information
- `Allowance`: Delegated spending permissions

**Table Storage**:
- `statTable`: Global token statistics
- `acctsTable`: User account balances
- `allowancesTable`: Spending allowances

### Action Implementation

**Mint Action**:
- Creates new tokens
- Requires issuer authorization
- Manages total supply
- Handles RAM allocation for new accounts

**Transfer Action**:
- Moves tokens between accounts
- Validates sufficient balance
- Creates new accounts when needed
- Manages RAM costs

**Approve Action**:
- Grants spending permissions
- Enables delegated transfers
- Updates allowance table
- Requires owner authorization

**TransferFrom Action**:
- Executes delegated transfers
- Validates allowance permissions
- Reduces allowance after transfer
- Requires spender authorization

**BalanceOf Action**:
- Queries account balance
- Returns current token amount
- Read-only operation

**Allowance Action**:
- Queries spending permission
- Returns approved amount
- Read-only operation

## Technical Implementation

### Action Dispatch

The contract uses manual action dispatch in the global `apply` function:

```typescript
export function apply(receiver: u64, firstReceiver: u64, action: u64): void {
    const contract = new erc20like(receiver, firstReceiver, action);
    
    const actionName = Name.fromU64(action);
    const actionStr = actionName.toString();
    
    if (actionStr == "mint") {
        const data = unpackActionData<MintData>();
        contract.mint(data.to, data.quantity);
    }
    // ... other actions
}
```

### Data Parsing

Action parameters are parsed using structured data types:

```typescript
@packer
class MintData {
    to: Name = new Name();
    quantity: Asset = new Asset();
}
```

### RAM Management

The contract implements proper RAM management:

- **Mint**: Issuer pays RAM for new accounts
- **Transfer**: Sender pays RAM for recipient accounts
- **TransferFrom**: Owner pays RAM for recipient accounts

This approach ensures:
- Fair resource allocation
- Prevents RAM exhaustion
- Maintains economic incentives

### Authorization Model

The contract enforces proper authorization:

- **Mint**: Only issuer can create new tokens
- **Transfer**: Only account owner can transfer
- **Approve**: Only account owner can grant permissions
- **TransferFrom**: Only approved spender can execute

## Customization Guide

### Changing Token Properties

**1. Token Symbol and Precision**:
```typescript
// In contract.ts, modify the mint action
const quantity = Asset.fromString("1000.0000 YOURTOKEN"); // Change CINFRA to your token
```

**2. Issuer Account**:
```typescript
// In contract.ts, modify the mint action
const issuer = Name.fromString("your_account"); // Change chaininfradv to your account
```

**3. Token Name**:
```typescript
// Update all references to "CINFRA" with your token name
// Search and replace throughout the contract
```

### Deployment Steps

**1. Prerequisites**:
- Node.js (v16 or higher)
- Proton CLI tools
- Proton account with sufficient RAM

**2. Build**:
```bash
npm install
npm run build
```

**3. Deploy**:
```bash
proton contract:set your_account target/contract.wasm target/contract.abi
```

**4. Verify**:
```bash
proton action your_account balanceof '{"account":"your_account"}' your_account@active
```

## API Reference

### Actions

**mint(to: Name, quantity: Asset)**
- Creates new tokens
- Requires issuer authorization
- Updates total supply

**transfer(from: Name, to: Name, quantity: Asset, memo: string)**
- Transfers tokens between accounts
- Requires sender authorization
- Creates recipient account if needed

**approve(owner: Name, spender: Name, amount: Asset)**
- Grants spending permission
- Requires owner authorization
- Updates allowance table

**transferFrom(spender: Name, from: Name, to: Name, amount: Asset, memo: string)**
- Executes delegated transfer
- Requires spender authorization
- Validates allowance

**balanceOf(account: Name)**
- Returns account balance
- Read-only operation
- No authorization required

**allowance(owner: Name, spender: Name)**
- Returns spending allowance
- Read-only operation
- No authorization required

### Usage Examples

**1. Create Your Token**:
```bash
proton action your_account mint '{"to":"recipient","quantity":"1000.0000 YOURTOKEN"}' your_account@active
```

**2. Transfer Tokens**:
```bash
proton action your_account transfer '{"from":"sender","to":"recipient","quantity":"100.0000 YOURTOKEN","memo":"payment"}' sender@active
```

**3. Delegate Spending**:
```bash
# Approve spender
proton action your_account approve '{"owner":"owner","spender":"spender","amount":"50.0000 YOURTOKEN"}' owner@active

# Execute delegated transfer
proton action your_account transferfrom '{"spender":"spender","from":"owner","to":"recipient","amount":"25.0000 YOURTOKEN","memo":"delegated"}' spender@active
```

**4. Query Information**:
```bash
# Check balance
proton action your_account balanceof '{"account":"user"}' your_account@active

# Check allowance
proton action your_account allowance '{"owner":"owner","spender":"spender"}' your_account@active
```

### Expected Results

Each action should:
- Execute successfully with proper authorization
- Update relevant tables
- Log appropriate console messages
- Handle RAM allocation correctly

## Key Learning Points

### RAM Management

Understanding RAM costs is crucial for Proton development:

- New account creation requires RAM
- RAM is paid by the account creator
- RAM costs vary based on data size
- Proper RAM management prevents failures

### Authorization Patterns

The contract demonstrates several authorization patterns:

- **Owner-based**: Account owner controls their tokens
- **Issuer-based**: Token issuer controls supply
- **Delegated**: Approved spender can transfer on behalf

### Error Handling

The contract includes comprehensive error handling:

- Balance validation
- Authorization checks
- Allowance verification
- Account existence checks

### Event Logging

Console output provides off-chain integration:

- Action execution logs
- Balance changes
- Allowance updates
- Error messages

## Production Considerations

### Security

- Validate all inputs
- Check authorization properly
- Handle edge cases
- Prevent integer overflow

### Performance

- Optimize table operations
- Minimize RAM usage
- Efficient data structures
- Proper indexing

### Economics

- Fair RAM allocation
- Reasonable fees
- Supply management
- Token distribution

## Common Pitfalls

### RAM Issues

- **Problem**: "unprivileged contract cannot increase RAM usage"
- **Solution**: Ensure proper RAM payer for new accounts

### Authorization Errors

- **Problem**: "missing authority"
- **Solution**: Verify account permissions and keys

### Data Parsing

- **Problem**: Action data not parsed correctly
- **Solution**: Ensure proper data structure definitions

## Advanced Topics

### Custom Token Standards

This contract implements ERC20-like functionality:
- Fungible tokens
- Transfer mechanisms
- Approval system
- Supply management

### Integration Patterns

The contract supports:
- Off-chain applications
- Multi-signature wallets
- Automated trading
- DeFi protocols

### Scaling Considerations

For production deployment:
- Optimize contract size
- Minimize RAM usage
- Efficient table operations
- Proper error handling

## Resources

### Documentation

- [Proton Documentation](https://docs.protonchain.com)
- [AssemblyScript Guide](https://www.assemblyscript.org)
- [EOSIO Smart Contracts](https://developers.eos.io)

### Tools

- Proton CLI
- Proton Wallet
- Block Explorer
- Development Tools

### Community

- Proton Discord
- Developer Forums
- GitHub Repositories
- Technical Support

## Integration Examples

### Frontend Integration

**JavaScript/TypeScript**:
```javascript
// Using @proton/web-sdk
import { ProtonWebSDK } from '@proton/web-sdk';

const proton = new ProtonWebSDK({
  appName: 'Your Token App',
  chains: [{
    chainId: '71ee83bcf52142d61019d95f9cc5427ba6a0d7ff8accd9e2088ae2abeaf3d3dd',
    endpoints: ['https://testnet-api.chaininfra.net']
  }]
});

// Transfer tokens
await proton.sendTransaction({
  actions: [{
    account: 'your_account',
    name: 'transfer',
    authorization: [{ actor: 'user', permission: 'active' }],
    data: {
      from: 'user',
      to: 'recipient',
      quantity: '100.0000 YOURTOKEN',
      memo: 'payment'
    }
  }]
});
```

### Backend Integration

**Node.js**:
```javascript
// Using @proton/js
import { Api, JsonRpc, RpcError } from '@proton/js';

const rpc = new JsonRpc('https://testnet-api.chaininfra.net');
const api = new Api({ rpc, signatureProvider });

// Query balance
const balance = await rpc.get_table_rows({
  code: 'your_account',
  table: 'accounts',
  scope: 'user',
  json: true
});
```

## Production Deployment

### Security Checklist

- [ ] Change default token symbol and name
- [ ] Update issuer account to your account
- [ ] Review and test all authorization logic
- [ ] Implement proper error handling
- [ ] Add rate limiting if needed
- [ ] Set up monitoring and alerts

### Performance Optimization

- [ ] Optimize table operations
- [ ] Minimize RAM usage
- [ ] Use efficient data structures
- [ ] Implement proper indexing

### Monitoring

- [ ] Set up transaction monitoring
- [ ] Monitor RAM usage
- [ ] Track token supply and distribution
- [ ] Implement alerting for anomalies

## Support and Contributing

### Getting Help

- Check the [Proton Documentation](https://docs.protonchain.com)
- Join the [Proton Discord](https://discord.gg/proton)
- Review [EOSIO Smart Contract Guide](https://developers.eos.io)

### Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

### License

This project is licensed under the MIT License - see the LICENSE file for details.

## Conclusion

This contract provides a production-ready foundation for token development on Proton blockchain. You can use it as-is for your token project or customize it for your specific needs.

The implementation demonstrates best practices for:
- RAM management and resource allocation
- Authorization and security
- Token economics and supply management
- Error handling and validation
- Production deployment considerations

Start with the Quick Start guide, customize the token properties, and deploy to create your own token on Proton blockchain.