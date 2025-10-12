# Theory: DeFi Lending Protocol

## Learning Objectives
- Understand DeFi (Decentralized Finance) and lending protocols
- Master collateralized borrowing and liquidation mechanisms
- Practice oracle integration and price feeds
- Understand risk management and health factor calculations
- Learn security patterns in DeFi protocols

## Prerequisites
- Completed NFT Marketplace contract
- Understanding of state management and TableStore
- Basic knowledge of DeFi and lending

## 1. DeFi Lending Basics

### 1.1 Core Data Structures
Using XPR Network Contract SDK storage:

```typescript
import { TableStore, Table, Asset, Symbol, Name } from "proton-tsc";

// User deposit table
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

// Loan table
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

### 1.2 Oracle Price Feed
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

## 2. Core Lending Operations

### 2.1 Deposit Collateral
```typescript
@action("deposit")
depositCollateral(
    user: Name,
    amount: Asset
): void {
    requireAuth(user);
    
    this.checkNotPaused();
    check(amount.amount > 0, "Deposit amount must be positive");
    
    let deposit = this.depositsTable.get(user.N);
    
    if (deposit == null) {
        // First deposit
        deposit = new Deposit(user, amount, 0);
        this.depositsTable.store(deposit, this.receiver);
    } else {
        // Add to existing deposit
        check(deposit.amount.symbol == amount.symbol, "Symbol mismatch");
        deposit.amount.amount += amount.amount;
        this.depositsTable.update(deposit, this.receiver);
    }
    
    print(`${user} deposited ${amount}`);
}
```

### 2.2 Borrow Against Collateral
```typescript
@action("borrow")
borrowFunds(
    borrower: Name,
    amount: Asset
): void {
    requireAuth(borrower);
    
    this.checkNotPaused();
    check(amount.amount > 0, "Borrow amount must be positive");
    
    // Check user has deposit
    const deposit = this.depositsTable.get(borrower.N);
    check(deposit != null, "No deposit found. Deposit collateral first");
    
    if (deposit) {
        // Get prices
        const collateralPrice = this.getPrice(deposit.amount.symbol);
        const borrowPrice = this.getPrice(amount.symbol);
        
        // Calculate collateral value and max borrow
        const collateralValue = this.calculateValue(deposit.amount.amount, collateralPrice);
        const maxBorrow = (collateralValue * BASIS_POINTS) / COLLATERAL_RATIO;
        const borrowValue = this.calculateValue(amount.amount, borrowPrice);
        
        check(borrowValue <= maxBorrow, "Insufficient collateral. Need 150% collateralization");
        
        // Check if user already has a loan
        let loan = this.loansTable.get(borrower.N);
        
        if (loan == null) {
            // Create new loan
            loan = new Loan(borrower, deposit.amount, amount, 0);
            this.loansTable.store(loan, this.receiver);
        } else {
            // Add to existing loan
            check(loan.borrowed.symbol == amount.symbol, "Symbol mismatch");
            
            const totalBorrowValue = this.calculateValue(
                loan.borrowed.amount + amount.amount,
                borrowPrice
            );
            
            check(totalBorrowValue <= maxBorrow, "Would exceed collateral ratio");
            
            loan.borrowed.amount += amount.amount;
            this.loansTable.update(loan, this.receiver);
        }
        
        print(`${borrower} borrowed ${amount}. Health factor: ${this.getHealthFactor(borrower)}`);
    }
}
```

## 3. Health Factor & Risk Management

### 3.1 Health Factor Calculation
```typescript
// Protocol constants
const COLLATERAL_RATIO: u64 = 15000; // 150% = 15000 basis points
const LIQUIDATION_THRESHOLD: u64 = 12000; // 120% = 12000 basis points
const BASIS_POINTS: u64 = 10000; // 100% = 10000 basis points

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

### 3.2 Liquidation Mechanism
```typescript
@action("liquidate")
liquidatePosition(
    liquidator: Name,
    borrower: Name
): void {
    requireAuth(liquidator);
    
    this.checkNotPaused();
    check(liquidator != borrower, "Cannot liquidate your own position");
    
    const loan = this.loansTable.get(borrower.N);
    check(loan != null, "No loan found for this borrower");
    
    if (loan) {
        // Calculate health factor
        const collateralPrice = this.getPrice(loan.collateral.symbol);
        const borrowPrice = this.getPrice(loan.borrowed.symbol);
        
        const collateralValue = this.calculateValue(loan.collateral.amount, collateralPrice);
        const borrowedValue = this.calculateValue(loan.borrowed.amount, borrowPrice);
        
        // Health factor in basis points
        const healthFactor = (collateralValue * BASIS_POINTS) / borrowedValue;
        
        check(healthFactor < LIQUIDATION_THRESHOLD, "Position is healthy, cannot liquidate");
        
        // Transfer collateral to liquidator (simplified - in production would use inline actions)
        const deposit = this.depositsTable.get(borrower.N);
        if (deposit) {
            this.depositsTable.remove(deposit);
        }
        
        // Remove loan
        this.loansTable.remove(loan);
        
        print(`${liquidator} liquidated ${borrower}. Health factor was ${healthFactor / 100}%`);
    }
}
```

## 4. Oracle Integration

### 4.1 Price Feed Management
```typescript
@action("updateprice")
updatePrice(
    symbol: Symbol,
    price: u64
): void {
    requireAuth(this.receiver);
    
    check(price > 0, "Price must be positive");
    
    const symbolCode = symbol.code();
    let priceEntry = this.pricesTable.get(symbolCode);
    
    if (priceEntry == null) {
        priceEntry = new OraclePrice(symbolCode, price, 0);
        this.pricesTable.store(priceEntry, this.receiver);
    } else {
        priceEntry.price = price;
        this.pricesTable.update(priceEntry, this.receiver);
    }
    
    print(`Price updated: ${price}`);
}
```

### 4.2 Price Validation
```typescript
private getPrice(symbol: Symbol): u64 {
    const symbolCode = symbol.code();
    const priceEntry = this.pricesTable.get(symbolCode);
    check(priceEntry != null, "Price not found for asset");
    return priceEntry ? priceEntry.price : 0;
}

private calculateValue(amount: i64, price: u64): u64 {
    return <u64>amount * price;
}
```

## 5. Repayment & Withdrawal

### 5.1 Loan Repayment
```typescript
@action("repay")
repayLoan(
    borrower: Name,
    amount: Asset
): void {
    requireAuth(borrower);
    
    check(amount.amount > 0, "Repay amount must be positive");
    
    const loan = this.loansTable.get(borrower.N);
    check(loan != null, "No loan found");
    
    if (loan) {
        check(loan.borrowed.symbol == amount.symbol, "Symbol mismatch");
        check(amount.amount <= loan.borrowed.amount, "Repay amount exceeds borrowed amount");
        
        loan.borrowed.amount -= amount.amount;
        
        if (loan.borrowed.amount == 0) {
            // Loan fully repaid, remove it
            this.loansTable.remove(loan);
            print(`${borrower} fully repaid loan`);
        } else {
            this.loansTable.update(loan, this.receiver);
            print(`${borrower} repaid ${amount}. Remaining: ${loan.borrowed.amount}`);
        }
    }
}
```

### 5.2 Collateral Withdrawal
```typescript
@action("withdraw")
withdrawDeposit(
    user: Name,
    amount: Asset
): void {
    requireAuth(user);
    
    check(amount.amount > 0, "Withdraw amount must be positive");
    
    const deposit = this.depositsTable.get(user.N);
    check(deposit != null, "No deposit found");
    
    if (deposit) {
        check(deposit.amount.symbol == amount.symbol, "Symbol mismatch");
        check(amount.amount <= deposit.amount.amount, "Insufficient deposit balance");
        
        // Check if user has active loan
        const loan = this.loansTable.get(user.N);
        
        if (loan != null) {
            // Calculate if withdrawal would maintain collateral ratio
            const remainingCollateral = deposit.amount.amount - amount.amount;
            const collateralPrice = this.getPrice(deposit.amount.symbol);
            const borrowPrice = this.getPrice(loan.borrowed.symbol);
            
            const remainingValue = this.calculateValue(remainingCollateral, collateralPrice);
            const borrowedValue = this.calculateValue(loan.borrowed.amount, borrowPrice);
            const requiredValue = (borrowedValue * COLLATERAL_RATIO) / BASIS_POINTS;
            
            check(remainingValue >= requiredValue, "Withdrawal would undercollateralize loan");
        }
        
        deposit.amount.amount -= amount.amount;
        
        if (deposit.amount.amount == 0) {
            this.depositsTable.remove(deposit);
            print(`${user} withdrew all deposits`);
        } else {
            this.depositsTable.update(deposit, this.receiver);
            print(`${user} withdrew ${amount}`);
        }
    }
}
```

## 6. Protocol Configuration

### 6.1 Configuration Management
```typescript
@table("config")
export class Config extends Table {
    constructor(
        public key: u64 = 0,
        public collateralRatio: u64 = COLLATERAL_RATIO,
        public liquidationThreshold: u64 = LIQUIDATION_THRESHOLD,
        public paused: boolean = false
    ) { super(); }
    
    @primary
    get primary(): u64 {
        return this.key;
    }
}

@action("initconfig")
initializeConfig(): void {
    requireAuth(this.receiver);
    
    const existingConfig = this.configTable.get(0);
    check(existingConfig == null, "Config already initialized");
    
    const config = new Config(0, COLLATERAL_RATIO, LIQUIDATION_THRESHOLD, false);
    this.configTable.store(config, this.receiver);
    
    print("Protocol config initialized");
}
```

### 6.2 Emergency Controls
```typescript
@action("pause")
pauseProtocol(paused: boolean): void {
    requireAuth(this.receiver);
    
    const config = this.configTable.get(0);
    check(config != null, "Config not initialized");
    
    if (config) {
        config.paused = paused;
        this.configTable.update(config, this.receiver);
        print(`Protocol ${paused ? "paused" : "unpaused"}`);
    }
}

private checkNotPaused(): void {
    const config = this.configTable.get(0);
    if (config != null) {
        check(!config.paused, "Protocol is paused");
    }
}
```

## 7. Security Patterns

### 7.1 Authorization Checks
```typescript
// Pattern 1: User-specific operations
@action("user_action")
userAction(user: Name): void {
    requireAuth(user);
    // ... action logic
}

// Pattern 2: Admin-only operations
@action("admin_action")
adminAction(): void {
    requireAuth(this.receiver);
    // ... action logic
}
```

### 7.2 State Validation
```typescript
@action("validated_action")
validatedAction(): void {
    // Check protocol state
    this.checkNotPaused();
    
    // Validate inputs
    check(amount.amount > 0, "Amount must be positive");
    
    // Check business logic constraints
    check(healthFactor >= LIQUIDATION_THRESHOLD, "Position unhealthy");
    
    // ... action logic
}
```

## 8. Common Patterns

### 8.1 Health Factor Monitoring
```typescript
@action("check_health")
checkHealth(borrower: Name): void {
    const healthFactor = this.getHealthFactor(borrower);
    
    if (healthFactor == 0) {
        print(`${borrower} has no active loan`);
    } else if (healthFactor < LIQUIDATION_THRESHOLD) {
        print(`${borrower} position is unhealthy: ${healthFactor / 100}%`);
    } else if (healthFactor < COLLATERAL_RATIO) {
        print(`${borrower} position is safe but cannot borrow more: ${healthFactor / 100}%`);
    } else {
        print(`${borrower} position is healthy: ${healthFactor / 100}%`);
    }
}
```

### 8.2 Batch Operations
```typescript
@action("batch_liquidate")
batchLiquidate(liquidator: Name, borrowers: Name[]): void {
    requireAuth(liquidator);
    
    for (let i = 0; i < borrowers.length; i++) {
        const borrower = borrowers[i];
        const loan = this.loansTable.get(borrower.N);
        
        if (loan != null) {
            const healthFactor = this.getHealthFactor(borrower);
            if (healthFactor < LIQUIDATION_THRESHOLD) {
                this.liquidatePosition(liquidator, borrower);
            }
        }
    }
}
```

## 9. Testing Strategies

### 9.1 Unit Testing
```typescript
describe('DeFi Lending Protocol', () => {
    it('should allow borrowing against collateral', () => {
        // Setup
        contract.updatePrice(Symbol.fromString("XPR"), 100);
        contract.depositCollateral("alice", Asset.fromString("1000.0000 XPR"));
        
        // Borrow
        contract.borrowFunds("alice", Asset.fromString("500.0000 USDT"));
        
        // Verify
        const loan = contract.getLoan("alice");
        expect(loan.borrowed.amount).toBe(500);
        expect(loan.collateral.amount).toBe(1000);
    });
    
    it('should prevent over-borrowing', () => {
        contract.updatePrice(Symbol.fromString("XPR"), 100);
        contract.depositCollateral("alice", Asset.fromString("1000.0000 XPR"));
        
        expect(() => {
            contract.borrowFunds("alice", Asset.fromString("800.0000 USDT"));
        }).toThrow("Insufficient collateral");
    });
});
```

### 9.2 Integration Testing
```typescript
describe('DeFi Protocol Integration', () => {
    it('should handle complete lending lifecycle', () => {
        // 1. Setup prices
        contract.updatePrice(Symbol.fromString("XPR"), 100);
        contract.updatePrice(Symbol.fromString("USDT"), 100);
        
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
- Oracle Services
- Development Tools

---

**Remember**: DeFi lending protocols require careful attention to risk management, oracle security, and liquidation mechanisms. Understanding these patterns is crucial for building robust financial applications.
