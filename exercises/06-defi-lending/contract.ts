import { Contract, Name, Table, TableStore, Asset, Symbol, check, print, requireAuth } from "proton-tsc";

// Protocol constants
const COLLATERAL_RATIO: u64 = 15000; // 150% = 15000 basis points
const LIQUIDATION_THRESHOLD: u64 = 12000; // 120% = 12000 basis points
const BASIS_POINTS: u64 = 10000; // 100% = 10000 basis points

/**
 * User deposit table
 * Tracks deposits that can be used as collateral for borrowing
 * 
 * @table deposits
 */
@table("deposits")
export class Deposit extends Table {
  /**
   * @param {Name} user - Account that made the deposit
   * @param {Asset} amount - Deposited amount with symbol
   * @param {u64} depositedAt - Timestamp of deposit
   */
  constructor(
    public user: Name = new Name(),
    public amount: Asset = new Asset(),
    public depositedAt: u64 = 0
  ) {
    super();
  }

  @primary
  get primary(): u64 {
    return this.user.N;
  }
}

/**
 * Loan table
 * Tracks active loans with collateral and borrowed amounts
 * 
 * @table loans
 */
@table("loans")
export class Loan extends Table {
  /**
   * @param {Name} borrower - Account that borrowed
   * @param {Asset} collateral - Deposited collateral amount
   * @param {Asset} borrowed - Borrowed amount
   * @param {u64} borrowedAt - Timestamp when loan was taken
   */
  constructor(
    public borrower: Name = new Name(),
    public collateral: Asset = new Asset(),
    public borrowed: Asset = new Asset(),
    public borrowedAt: u64 = 0
  ) {
    super();
  }

  @primary
  get primary(): u64 {
    return this.borrower.N;
  }
}

/**
 * Oracle price feed table
 * Stores current prices for assets used in the protocol
 * 
 * @table prices
 */
@table("prices")
export class OraclePrice extends Table {
  /**
   * @param {u64} symbolCode - Asset symbol code (e.g., XPR)
   * @param {u64} price - Price in basis points (e.g., 100 = $0.01)
   * @param {u64} updatedAt - Last update timestamp
   */
  constructor(
    public symbolCode: u64 = 0,
    public price: u64 = 0,
    public updatedAt: u64 = 0
  ) {
    super();
  }

  @primary
  get primary(): u64 {
    return this.symbolCode;
  }
}

/**
 * Protocol configuration table
 * Stores global protocol parameters
 * 
 * @table config
 */
@table("config")
export class Config extends Table {
  /**
   * @param {u64} key - Config key (0 = singleton)
   * @param {u64} collateralRatio - Required collateral ratio in basis points
   * @param {u64} liquidationThreshold - Liquidation threshold in basis points
   * @param {boolean} paused - Protocol pause status
   */
  constructor(
    public key: u64 = 0,
    public collateralRatio: u64 = COLLATERAL_RATIO,
    public liquidationThreshold: u64 = LIQUIDATION_THRESHOLD,
    public paused: boolean = false
  ) {
    super();
  }

  @primary
  get primary(): u64 {
    return this.key;
  }
}

/**
 * DeFi Lending Protocol Smart Contract
 * 
 * Implements a decentralized lending protocol with:
 * - Collateralized borrowing
 * - Oracle-based price feeds
 * - Liquidation mechanism for undercollateralized positions
 * - Health factor monitoring
 * 
 * Key Concepts:
 * - Collateral Ratio: 150% (users can borrow up to 66% of collateral value)
 * - Liquidation Threshold: 120% (positions liquidated below this)
 * - Health Factor: (Collateral Value / Borrowed Value)
 * 
 * Security Features:
 * - Collateral validation before borrowing
 * - Health factor checks
 * - Oracle price validation
 * - Position liquidation protection
 * 
 * @contract
 */
@contract
export class LendingProtocol extends Contract {
  /** Table store for user deposits */
  depositsTable: TableStore<Deposit> = new TableStore<Deposit>(this.receiver);
  
  /** Table store for active loans */
  loansTable: TableStore<Loan> = new TableStore<Loan>(this.receiver);
  
  /** Table store for oracle prices */
  pricesTable: TableStore<OraclePrice> = new TableStore<OraclePrice>(this.receiver);
  
  /** Table store for protocol configuration */
  configTable: TableStore<Config> = new TableStore<Config>(this.receiver);

  /**
   * Deposit collateral to the protocol
   * 
   * Users deposit assets that can later be used as collateral for borrowing.
   * Deposits are tracked per user and can be withdrawn if not used as collateral.
   * 
   * @action deposit
   * @param {Name} user - Account making the deposit (requires auth)
   * @param {Asset} amount - Amount to deposit (must be positive)
   * @throws {Error} If protocol is paused or amount is invalid
   * @returns {void}
   */
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

  /**
   * Borrow against collateral
   * 
   * Users can borrow assets up to 66% of their collateral value (150% collateral ratio).
   * The protocol checks that the user has sufficient collateral before allowing the borrow.
   * 
   * @action borrow
   * @param {Name} borrower - Account borrowing (requires auth)
   * @param {Asset} amount - Amount to borrow
   * @throws {Error} If insufficient collateral, protocol paused, or invalid amount
   * @returns {void}
   */
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

  /**
   * Repay borrowed funds
   * 
   * Users repay their borrowed amount to reduce or close their loan position.
   * Partial repayments are allowed.
   * 
   * @action repay
   * @param {Name} borrower - Account repaying (requires auth)
   * @param {Asset} amount - Amount to repay
   * @throws {Error} If no loan exists or amount invalid
   * @returns {void}
   */
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

  /**
   * Withdraw deposited collateral
   * 
   * Users can withdraw their deposits if they are not being used as collateral
   * for active loans, or partially withdraw if sufficient collateral remains.
   * 
   * @action withdraw
   * @param {Name} user - Account withdrawing (requires auth)
   * @param {Asset} amount - Amount to withdraw
   * @throws {Error} If insufficient available balance or would undercollateralize loan
   * @returns {void}
   */
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

  /**
   * Liquidate undercollateralized position
   * 
   * Anyone can liquidate a position if its health factor falls below the
   * liquidation threshold (120%). Liquidator receives the collateral at a discount.
   * 
   * @action liquidate
   * @param {Name} liquidator - Account performing liquidation (requires auth)
   * @param {Name} borrower - Account being liquidated
   * @throws {Error} If position is healthy or doesn't exist
   * @returns {void}
   */
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

  /**
   * Update oracle price (admin only)
   * 
   * Updates the price feed for an asset. Only contract owner can update prices.
   * In production, this would integrate with external oracle services.
   * 
   * @action updateprice
   * @param {Symbol} symbol - Asset symbol to update
   * @param {u64} price - New price in basis points
   * @throws {Error} If caller is not contract owner or price is invalid
   * @returns {void}
   */
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

  /**
   * Initialize protocol configuration
   * 
   * Sets up initial protocol parameters. Only callable once.
   * 
   * @action initconfig
   * @throws {Error} If already initialized or caller is not owner
   * @returns {void}
   */
  @action("initconfig")
  initializeConfig(): void {
    requireAuth(this.receiver);

    const existingConfig = this.configTable.get(0);
    check(existingConfig == null, "Config already initialized");

    const config = new Config(0, COLLATERAL_RATIO, LIQUIDATION_THRESHOLD, false);
    this.configTable.store(config, this.receiver);

    print("Protocol config initialized");
  }

  /**
   * Pause/unpause protocol
   * 
   * Emergency pause mechanism. When paused, deposits, borrows, and liquidations are disabled.
   * 
   * @action pause
   * @param {boolean} paused - True to pause, false to unpause
   * @throws {Error} If caller is not contract owner
   * @returns {void}
   */
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

  // ========== Helper Methods ==========

  /**
   * Get price from oracle
   * 
   * @private
   * @param {Symbol} symbol - Asset symbol
   * @returns {u64} Price in basis points
   * @throws {Error} If price not found
   */
  private getPrice(symbol: Symbol): u64 {
    const symbolCode = symbol.code();
    const priceEntry = this.pricesTable.get(symbolCode);
    check(priceEntry != null, "Price not found for asset");
    return priceEntry ? priceEntry.price : 0;
  }

  /**
   * Calculate value of an amount given price
   * 
   * @private
   * @param {i64} amount - Token amount
   * @param {u64} price - Price in basis points
   * @returns {u64} Total value
   */
  private calculateValue(amount: i64, price: u64): u64 {
    return <u64>amount * price;
  }

  /**
   * Get health factor for a borrower
   * 
   * @private
   * @param {Name} borrower - Borrower account
   * @returns {u64} Health factor in basis points (10000 = 100%)
   */
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

  /**
   * Check if protocol is not paused
   * 
   * @private
   * @throws {Error} If protocol is paused
   */
  private checkNotPaused(): void {
    const config = this.configTable.get(0);
    if (config != null) {
      check(!config.paused, "Protocol is paused");
    }
  }
}
