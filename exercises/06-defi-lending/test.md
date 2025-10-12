# Test Cases: DeFi Lending Protocol

## 🧪 Unit Tests

### Test deposit() - Positive Cases
```typescript
test('deposit valid amount', () => {
    contract.deposit(UInt64.from(1000));
    
    const deposit = contract.getDeposit(Name.from("alice"));
    expect(deposit?.amount.toString()).toBe("1000");
});
```

### Test borrow() - Positive Cases
```typescript
test('borrow with sufficient collateral', () => {
    contract.deposit(UInt64.from(2000)); // 200% collateral
    contract.borrow(UInt64.from(1000));
    
    const loan = contract.getLoan(Name.from("alice"));
    expect(loan?.amount.toString()).toBe("1000");
    expect(loan?.isActive).toBe(true);
});
```

### Test borrow() - Negative Cases
```typescript
test('borrow without deposit should fail', () => {
    expect(() => contract.borrow(UInt64.from(1000)))
        .toThrow("No deposit found");
});

test('borrow with insufficient collateral should fail', () => {
    contract.deposit(UInt64.from(1000)); // 100% collateral
    expect(() => contract.borrow(UInt64.from(1000)))
        .toThrow("Insufficient collateral");
});
```

### Test repay() - Positive Cases
```typescript
test('repay loan', () => {
    contract.deposit(UInt64.from(2000));
    contract.borrow(UInt64.from(1000));
    contract.repay(UInt64.from(500));
    
    const loan = contract.getLoan(Name.from("alice"));
    expect(loan?.amount.toString()).toBe("500");
});
```

### Test liquidate() - Positive Cases
```typescript
test('liquidate undercollateralized position', () => {
    contract.deposit(UInt64.from(1000));
    contract.borrow(UInt64.from(1000));
    
    // Simulate price drop (reduce collateral)
    contract.deposit(UInt64.from(0)); // Remove collateral
    
    contract.liquidate(Name.from("alice"));
    
    const loan = contract.getLoan(Name.from("alice"));
    expect(loan?.isActive).toBe(false);
});
```

## 🔧 Integration Tests

### Deploy Contract
```bash
proton contract:deploy myaccount
```

### Test deposit Action
```bash
# Deposit tokens
proton push action myaccount deposit '["1000"]' -p user@active
# Expected: Success, Deposited event emitted
```

### Test borrow Action
```bash
# Borrow tokens
proton push action myaccount borrow '["500"]' -p user@active
# Expected: Success, Borrowed event emitted
```

### Test repay Action
```bash
# Repay loan
proton push action myaccount repay '["100"]' -p user@active
# Expected: Success, Repaid event emitted
```

### Test liquidate Action
```bash
# Liquidate position
proton push action myaccount liquidate '["borrower"]' -p liquidator@active
# Expected: Success, Liquidated event emitted
```

## Expected Results

| Test Case | Input | Expected Output |
|-----------|-------|----------------|
| deposit valid | 1000 | Success, deposit = 1000 |
| borrow valid | 500 | Success, loan = 500 |
| borrow no deposit | 1000 | Error: "No deposit found" |
| repay valid | 100 | Success, loan reduced |
| liquidate valid | borrower | Success, loan closed |

## Run Tests
```bash
# Unit tests
npm run test:unit

# Integration tests
npm run test:integration

# All tests
npm run test:all
```