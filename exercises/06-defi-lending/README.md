# DeFi Lending Protocol - Developer Guide

## Project Overview

This is a complete **DeFi Lending Protocol** on **XPR Network** using **AssemblyScript**. This project provides a production-ready lending protocol with:

- **Collateralized Borrowing** with automated liquidations
- **Oracle Integration** for real-time price feeds
- **Risk Management** with health factor calculations
- **Liquidation Mechanisms** for undercollateralized positions
- **Production-ready** code with comprehensive security

## System Architecture

### Contract Features

Contract `DeFiLending` implements a **complete lending protocol** with advanced features:

```typescript
// Core Features
- Collateral Management    - Deposit/withdraw collateral
- Borrowing System        - Borrow against collateral
- Liquidation Engine      - Automated liquidations
- Oracle Integration      - Price feed management
- Risk Management         - Health factor monitoring
- Protocol Controls       - Emergency pause/unpause
```

### Data Structures

#### Deposit Table
```typescript
@table("deposits")
export class Deposit extends Table {
    constructor(
        public user: Name = new Name(),
        public amount: Asset = new Asset(),
        public depositedAt: u64 = 0
    ) { super(); }
    
    @primary
    get primary(): u64 {
        return this.user.N;
    }
}
```

#### Loan Table
```typescript
@table("loans")
export class Loan extends Table {
    constructor(
        public borrower: Name = new Name(),
        public collateral: Asset = new Asset(),
        public borrowed: Asset = new Asset(),
        public borrowedAt: u64 = 0
    ) { super(); }
    
    @primary
    get primary(): u64 {
        return this.borrower.N;
    }
}
```

#### Oracle Price Table
```typescript
@table("prices")
export class OraclePrice extends Table {
    constructor(
        public symbolCode: u64 = 0,
        public price: u64 = 0,
        public updatedAt: u64 = 0
    ) { super(); }
    
    @primary
    get primary(): u64 {
        return this.symbolCode;
    }
}
```

#### Configuration Table
```typescript
@table("config")
export class Config extends Table {
    constructor(
        public key: u64 = 0,
        public collateralRatio: u64 = 15000,
        public liquidationThreshold: u64 = 12000,
        public paused: boolean = false
    ) { super(); }
    
    @primary
    get primary(): u64 {
        return this.key;
    }
}
```

## Quick Start

### 1. Installation

```bash
# Install dependencies
npm install

# Build contract
npm run build

# Run tests
npm test
```

### 2. Deployment

```bash
# Set network to testnet
proton chain:set proton-test

# Deploy contract to your account
proton contract:set <your-account> ./target

# Initialize protocol configuration
proton action <your-account> initconfig '[]' <your-account>@active
```

### 3. Setup Oracle Prices

```bash
# Set XPR price (example: $0.01)
proton action <your-account> updateprice '[{"symbol":{"sym":"XPR","precision":4},"price":100}]' <your-account>@active

# Set USDT price (example: $1.00)
proton action <your-account> updateprice '[{"symbol":{"sym":"USDT","precision":4},"price":10000}]' <your-account>@active
```

## Usage Examples

### 1. Deposit Collateral

```bash
# Deposit 1000 XPR as collateral
proton action <your-account> deposit '["alice","1000.0000 XPR"]' alice@active
```

### 2. Borrow Against Collateral

```bash
# Borrow 500 USDT against XPR collateral
proton action <your-account> borrow '["alice","500.0000 USDT"]' alice@active
```

### 3. Check Health Factor

```bash
# Check borrower's health factor
proton action <your-account> checkhealth '["alice"]' <your-account>@active
```

### 4. Repay Loan

```bash
# Repay 200 USDT
proton action <your-account> repay '["alice","200.0000 USDT"]' alice@active
```

### 5. Withdraw Collateral

```bash
# Withdraw 300 XPR (if health factor allows)
proton action <your-account> withdraw '["alice","300.0000 XPR"]' alice@active
```

### 6. Liquidate Position

```bash
# Liquidate undercollateralized position
proton action <your-account> liquidate '["liquidator","alice"]' liquidator@active
```

## Key Concepts

### Collateral Ratio
**150%** - Users must maintain at least 150% collateralization
- Example: Deposit $150 worth of collateral to borrow $100
- Provides safety buffer against price volatility

### Liquidation Threshold  
**120%** - Positions below 120% health factor can be liquidated
- Provides 30% safety buffer before liquidation
- Protects protocol from bad debt

### Health Factor
```
Health Factor = (Collateral Value / Borrowed Value) * 100%
```

- **Health > 150%**: Can borrow more
- **Health 120-150%**: Cannot borrow more, but safe
- **Health < 120%**: Subject to liquidation

## Contract Actions

### Core Actions

#### `deposit` - Deposit Collateral
```typescript
@action("deposit")
depositCollateral(
    user: Name,
    amount: Asset
): void
```

#### `borrow` - Borrow Funds
```typescript
@action("borrow")
borrowFunds(
    borrower: Name,
    amount: Asset
): void
```

#### `repay` - Repay Loan
```typescript
@action("repay")
repayLoan(
    borrower: Name,
    amount: Asset
): void
```

#### `withdraw` - Withdraw Collateral
```typescript
@action("withdraw")
withdrawDeposit(
    user: Name,
    amount: Asset
): void
```

#### `liquidate` - Liquidate Position
```typescript
@action("liquidate")
liquidatePosition(
    liquidator: Name,
    borrower: Name
): void
```

### Oracle Actions

#### `updateprice` - Update Price Feed
```typescript
@action("updateprice")
updatePrice(
    symbol: Symbol,
    price: u64
): void
```

### Protocol Actions

#### `initconfig` - Initialize Configuration
```typescript
@action("initconfig")
initializeConfig(): void
```

#### `pause` - Pause/Unpause Protocol
```typescript
@action("pause")
pauseProtocol(paused: boolean): void
```

## Development Guide

### 1. Basic Understanding

Before diving into the code, understand these key concepts:

- **Collateralization**: Users must deposit more value than they borrow
- **Health Factor**: Ratio of collateral value to borrowed value
- **Liquidation**: Automatic selling of collateral when health factor drops
- **Oracle**: External price feed for asset valuation

### 2. Key Patterns

#### Singleton Pattern for Configuration
```typescript
// Configuration is stored as singleton (id = 0)
const config = this.configTable.get(0);
if (config == null) {
    const newConfig = new Config(0, COLLATERAL_RATIO, LIQUIDATION_THRESHOLD, false);
    this.configTable.store(newConfig, this.receiver);
}
```

#### Auto-increment Pattern for History
```typescript
// Use availablePrimaryKey for sequential IDs
const historyId = this.historyTable.availablePrimaryKey;
```

#### Bounds Checking Pattern
```typescript
// Always validate inputs
check(amount.amount > 0, "Amount must be positive");
check(healthFactor >= LIQUIDATION_THRESHOLD, "Position unhealthy");
```

### 3. Advanced Features

#### Health Factor Calculation
```typescript
private getHealthFactor(borrower: Name): u64 {
    const loan = this.loansTable.get(borrower.N);
    if (loan == null) return 0;
    
    const collateralPrice = this.getPrice(loan.collateral.symbol);
    const borrowPrice = this.getPrice(loan.borrowed.symbol);
    
    const collateralValue = this.calculateValue(loan.collateral.amount, collateralPrice);
    const borrowedValue = this.calculateValue(loan.borrowed.amount, borrowPrice);
    
    if (borrowedValue == 0) return 0;
    
    return (collateralValue * BASIS_POINTS) / borrowedValue;
}
```

#### Liquidation Logic
```typescript
@action("liquidate")
liquidatePosition(liquidator: Name, borrower: Name): void {
    requireAuth(liquidator);
    
    const loan = this.loansTable.get(borrower.N);
    check(loan != null, "No loan found");
    
    const healthFactor = this.getHealthFactor(borrower);
    check(healthFactor < LIQUIDATION_THRESHOLD, "Position is healthy");
    
    // Transfer collateral to liquidator
    // Remove loan and deposit records
    // Emit liquidation event
}
```

## Security Considerations

### 1. Input Validation
- Always validate user inputs
- Check for positive amounts
- Validate symbol consistency
- Prevent self-operations

### 2. Authorization
- Use `requireAuth()` for user actions
- Restrict admin actions to contract owner
- Validate ownership before operations

### 3. State Consistency
- Check health factor before operations
- Validate collateral ratios
- Ensure data integrity across tables

### 4. Oracle Security
- Validate price updates
- Check for stale prices
- Implement price bounds checking

## Testing

### 1. Unit Tests
```typescript
describe('DeFi Lending Protocol', () => {
    it('should allow borrowing against collateral', () => {
        contract.updatePrice(Symbol.fromString("XPR"), 100);
        contract.depositCollateral("alice", Asset.fromString("1000.0000 XPR"));
        
        contract.borrowFunds("alice", Asset.fromString("500.0000 USDT"));
        
        const loan = contract.getLoan("alice");
        expect(loan.borrowed.amount).toBe(500);
    });
});
```

### 2. Integration Tests
```typescript
describe('DeFi Protocol Integration', () => {
    it('should handle complete lending lifecycle', () => {
        // 1. Setup prices
        contract.updatePrice(Symbol.fromString("XPR"), 100);
        
        // 2. Deposit collateral
        contract.depositCollateral("alice", Asset.fromString("1000.0000 XPR"));
        
        // 3. Borrow funds
        contract.borrowFunds("alice", Asset.fromString("500.0000 USDT"));
        
        // 4. Check health factor
        const healthFactor = contract.getHealthFactor("alice");
        expect(healthFactor).toBeGreaterThan(15000);
        
        // 5. Repay loan
        contract.repayLoan("alice", Asset.fromString("500.0000 USDT"));
        
        // 6. Withdraw collateral
        contract.withdrawDeposit("alice", Asset.fromString("1000.0000 XPR"));
    });
});
```

## Performance Optimization

### 1. RAM Management
- Use efficient data structures
- Implement proper indexing
- Optimize storage patterns
- Monitor RAM usage

### 2. CPU Optimization
- Minimize complex calculations
- Use efficient algorithms
- Batch operations when possible
- Optimize loops and iterations

### 3. Network Optimization
- Minimize action calls
- Batch related operations
- Use efficient data serialization
- Optimize action parameters

## Troubleshooting

### Common Issues

#### 1. "Insufficient collateral" Error
- Check collateral ratio requirements
- Verify price feeds are updated
- Ensure sufficient collateral deposited

#### 2. "Position is healthy" Error (Liquidation)
- Check health factor calculation
- Verify liquidation threshold
- Ensure position is undercollateralized

#### 3. "Symbol mismatch" Error
- Check token symbols match
- Verify asset precision
- Ensure consistent symbol usage

#### 4. "Protocol is paused" Error
- Check protocol status
- Contact protocol admin
- Wait for protocol unpause

### Debug Tips

#### 1. Check Health Factor
```bash
proton action <contract> checkhealth '["user"]' <contract>@active
```

#### 2. Verify Prices
```bash
proton action <contract> getprice '["XPR"]' <contract>@active
```

#### 3. Check Protocol Status
```bash
proton action <contract> getconfig '[]' <contract>@active
```

## Resources

### Documentation
- [XPR Network Contract SDK - Storage](https://docs.xprnetwork.org/contract-sdk/storage.html)
- [XPR Network Contract SDK - Execution Order](https://docs.xprnetwork.org/contract-sdk/execution-order.html)
- [XPR Network Contract SDK - Notifications](https://docs.xprnetwork.org/contract-sdk/notifications.html)
- [XPR Network Contract SDK - Testing](https://docs.xprnetwork.org/contract-sdk/testing.html)
- [XPR Network Contract SDK - Security](https://docs.xprnetwork.org/contract-sdk/security.html)

### DeFi Protocols
- [Compound Protocol](https://compound.finance/docs)
- [Aave Protocol](https://docs.aave.com)
- [MakerDAO](https://docs.makerdao.com)

### Tools
- Proton CLI
- Proton Wallet
- Block Explorer
- Oracle Services
- Development Tools

---

**Remember**: DeFi lending protocols require careful attention to risk management, oracle security, and liquidation mechanisms. Understanding these patterns is crucial for building robust financial applications.