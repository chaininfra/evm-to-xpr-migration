import * as _chain from "as-chain";
import {
    Contract,
    Name,
    Asset,
    Symbol,
    Table,
    TableStore,
    check,
    requireAuth,
    isAccount,
    requireRecipient,
    print,
    readActionData,
    unpackActionData,
    actionDataSize,
  } from "proton-tsc";

/**
 * ERC20-like Token Contract for Proton Blockchain
 * 
 * This contract implements a standard fungible token with the following features:
 * - Token minting and supply management
 * - Token transfers between accounts
 * - Approval system for delegated transfers
 * - Balance and allowance queries
 * - Proper RAM management and authorization
 * 
 * @author Your Name
 * @version 1.0.0
 * @since 2024
 */

// === TABLES ===

/**
 * Token statistics table storing global token information
 * 
 * This table contains:
 * - Token symbol and precision
 * - Total supply
 * - Issuer account (who can mint new tokens)
 * 
 * @table stat
 */


class StatDB extends _chain.MultiIndex<Stat> {

}

@table("stat", nocodegen)

class Stat implements _chain.MultiIndexValue {
    
    /**
     * Creates a new Stat record
     * 
     * @param symbol - Token symbol (e.g., "CINFRA") with precision
     * @param supply - Current total supply of tokens
     * @param issuer - Account that can mint new tokens
     */
    constructor(
        public symbol: Symbol = new Symbol("CINFRA", 4),
        public supply: Asset = new Asset(),
        public issuer: Name = new Name(),
    ) {  }

    /**
     * Primary key for the stat table
     * Uses the symbol code as the unique identifier
     * 
     * @returns The symbol code as u64
     */
    @primary get primary(): u64 { return this.symbol.code(); }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.symbol);
        enc.pack(this.supply);
        enc.pack(this.issuer);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new Symbol();
            dec.unpack(obj);
            this.symbol = obj;
        }
        
        {
            let obj = new Asset();
            dec.unpack(obj);
            this.supply = obj;
        }
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.issuer = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.symbol.getSize();
        size += this.supply.getSize();
        size += this.issuer.getSize();
        return size;
    }

    static get tableName(): _chain.Name {
        return _chain.Name.fromU64(0xC64D900000000000);
    }

    static tableIndexes(code: _chain.Name, scope: _chain.Name): _chain.IDXDB[] {
        const idxTableBase: u64 = this.tableName.N & 0xfffffffffffffff0;
        const indices: _chain.IDXDB[] = [
        ];
        return indices;
    }

    getTableName(): _chain.Name {
        return Stat.tableName;
    }

    getTableIndexes(code: _chain.Name, scope: _chain.Name): _chain.IDXDB[] {
        return Stat.tableIndexes(code, scope);
    }

    getPrimaryValue(): u64 {
        return this.primary
    }

    getSecondaryValue(i: i32): _chain.SecondaryValue {
        _chain.check(false, "no secondary value!");
        return new _chain.SecondaryValue(_chain.SecondaryType.U64, new Array<u64>(0));
    }
    
    setSecondaryValue(i: i32, value: _chain.SecondaryValue): void {
        _chain.check(false, "no secondary value!");
    }


    static new(code: _chain.Name, scope: _chain.Name  = _chain.EMPTY_NAME): StatDB {
        return new StatDB(code, scope, this.tableName, this.tableIndexes(code, scope));
    }
}

/**
 * Account balance table storing individual user balances
 * 
 * This table is scoped by account name and contains:
 * - Token balance for each account
 * 
 * @table accounts
 */


class AccountDB extends _chain.MultiIndex<Account> {

}

@table("accounts", nocodegen)

class Account implements _chain.MultiIndexValue {
    
    /**
     * Creates a new Account record
     * 
     * @param balance - Current token balance for the account
     */
    constructor(public balance: Asset = new Asset()) {  }
    
    /**
     * Primary key for the accounts table
     * Uses the symbol code as the unique identifier
     * 
     * @returns The symbol code as u64
     */
    @primary get primary(): u64 { return this.balance.symbol.code(); }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.balance);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new Asset();
            dec.unpack(obj);
            this.balance = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.balance.getSize();
        return size;
    }

    static get tableName(): _chain.Name {
        return _chain.Name.fromU64(0x32114D4F38000000);
    }

    static tableIndexes(code: _chain.Name, scope: _chain.Name): _chain.IDXDB[] {
        const idxTableBase: u64 = this.tableName.N & 0xfffffffffffffff0;
        const indices: _chain.IDXDB[] = [
        ];
        return indices;
    }

    getTableName(): _chain.Name {
        return Account.tableName;
    }

    getTableIndexes(code: _chain.Name, scope: _chain.Name): _chain.IDXDB[] {
        return Account.tableIndexes(code, scope);
    }

    getPrimaryValue(): u64 {
        return this.primary
    }

    getSecondaryValue(i: i32): _chain.SecondaryValue {
        _chain.check(false, "no secondary value!");
        return new _chain.SecondaryValue(_chain.SecondaryType.U64, new Array<u64>(0));
    }
    
    setSecondaryValue(i: i32, value: _chain.SecondaryValue): void {
        _chain.check(false, "no secondary value!");
    }


    static new(code: _chain.Name, scope: _chain.Name  = _chain.EMPTY_NAME): AccountDB {
        return new AccountDB(code, scope, this.tableName, this.tableIndexes(code, scope));
    }
}

/**
 * Allowance table storing delegated spending permissions
 * 
 * This table is scoped by owner account and contains:
 * - Spender account that has permission
 * - Amount that can be spent
 * 
 * @table allowances
 */


class AllowanceDB extends _chain.MultiIndex<Allowance> {

}

@table("allowances", nocodegen)

class Allowance implements _chain.MultiIndexValue {
    
    /**
     * Creates a new Allowance record
     * 
     * @param spender - Account that has spending permission
     * @param amount - Maximum amount that can be spent
     */
    constructor(public spender: Name = new Name(), public amount: Asset = new Asset()) {  }
    
    /**
     * Primary key for the allowances table
     * Uses the spender account name as the unique identifier
     * 
     * @returns The spender account name as u64
     */
    @primary get primary(): u64 { return this.spender.N; }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.spender);
        enc.pack(this.amount);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.spender = obj;
        }
        
        {
            let obj = new Asset();
            dec.unpack(obj);
            this.amount = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.spender.getSize();
        size += this.amount.getSize();
        return size;
    }

    static get tableName(): _chain.Name {
        return _chain.Name.fromU64(0x34634E1A68560000);
    }

    static tableIndexes(code: _chain.Name, scope: _chain.Name): _chain.IDXDB[] {
        const idxTableBase: u64 = this.tableName.N & 0xfffffffffffffff0;
        const indices: _chain.IDXDB[] = [
        ];
        return indices;
    }

    getTableName(): _chain.Name {
        return Allowance.tableName;
    }

    getTableIndexes(code: _chain.Name, scope: _chain.Name): _chain.IDXDB[] {
        return Allowance.tableIndexes(code, scope);
    }

    getPrimaryValue(): u64 {
        return this.primary
    }

    getSecondaryValue(i: i32): _chain.SecondaryValue {
        _chain.check(false, "no secondary value!");
        return new _chain.SecondaryValue(_chain.SecondaryType.U64, new Array<u64>(0));
    }
    
    setSecondaryValue(i: i32, value: _chain.SecondaryValue): void {
        _chain.check(false, "no secondary value!");
    }


    static new(code: _chain.Name, scope: _chain.Name  = _chain.EMPTY_NAME): AllowanceDB {
        return new AllowanceDB(code, scope, this.tableName, this.tableIndexes(code, scope));
    }
}

// === ACTION DATA STRUCTS ===

/**
 * Data structure for mint action parameters
 * Used to parse incoming mint action data
 */

@packer(nocodegen)
class MintData implements _chain.Packer {
    
  /**
   * Creates mint action data
   * 
   * @param to - Account to receive the minted tokens
   * @param quantity - Amount of tokens to mint
   */
  constructor(public to: Name = new Name(), public quantity: Asset = new Asset()) {}
    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.to);
        enc.pack(this.quantity);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.to = obj;
        }
        
        {
            let obj = new Asset();
            dec.unpack(obj);
            this.quantity = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.to.getSize();
        size += this.quantity.getSize();
        return size;
    }
}

/**
 * Data structure for transfer action parameters
 * Used to parse incoming transfer action data
 */

@packer(nocodegen)
class TransferData implements _chain.Packer {
    
  /**
   * Creates transfer action data
   * 
   * @param from - Account sending the tokens
   * @param to - Account receiving the tokens
   * @param quantity - Amount of tokens to transfer
   * @param memo - Optional memo for the transfer
   */
  constructor(
    public from: Name = new Name(), 
    public to: Name = new Name(), 
    public quantity: Asset = new Asset(), 
    public memo: string = ""
  ) {}
    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.from);
        enc.pack(this.to);
        enc.pack(this.quantity);
        enc.packString(this.memo);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.from = obj;
        }
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.to = obj;
        }
        
        {
            let obj = new Asset();
            dec.unpack(obj);
            this.quantity = obj;
        }
        this.memo = dec.unpackString();
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.from.getSize();
        size += this.to.getSize();
        size += this.quantity.getSize();
        size += _chain.Utils.calcPackedStringLength(this.memo);
        return size;
    }
}

/**
 * Data structure for approve action parameters
 * Used to parse incoming approve action data
 */

@packer(nocodegen)
class ApproveData implements _chain.Packer {
    
  /**
   * Creates approve action data
   * 
   * @param owner - Account that owns the tokens
   * @param spender - Account that gets spending permission
   * @param amount - Maximum amount that can be spent
   */
  constructor(public owner: Name = new Name(), public spender: Name = new Name(), public amount: Asset = new Asset()) {}
    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.owner);
        enc.pack(this.spender);
        enc.pack(this.amount);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.owner = obj;
        }
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.spender = obj;
        }
        
        {
            let obj = new Asset();
            dec.unpack(obj);
            this.amount = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.owner.getSize();
        size += this.spender.getSize();
        size += this.amount.getSize();
        return size;
    }
}

/**
 * Data structure for transferFrom action parameters
 * Used to parse incoming transferFrom action data
 */

@packer(nocodegen)
class TransferFromData implements _chain.Packer {
    
  /**
   * Creates transferFrom action data
   * 
   * @param spender - Account executing the transfer (must have allowance)
   * @param from - Account that owns the tokens
   * @param to - Account receiving the tokens
   * @param amount - Amount of tokens to transfer
   * @param memo - Optional memo for the transfer
   */
  constructor(
    public spender: Name = new Name(),
    public from: Name = new Name(), 
    public to: Name = new Name(), 
    public amount: Asset = new Asset(), 
    public memo: string = ""
  ) {}
    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.spender);
        enc.pack(this.from);
        enc.pack(this.to);
        enc.pack(this.amount);
        enc.packString(this.memo);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.spender = obj;
        }
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.from = obj;
        }
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.to = obj;
        }
        
        {
            let obj = new Asset();
            dec.unpack(obj);
            this.amount = obj;
        }
        this.memo = dec.unpackString();
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.spender.getSize();
        size += this.from.getSize();
        size += this.to.getSize();
        size += this.amount.getSize();
        size += _chain.Utils.calcPackedStringLength(this.memo);
        return size;
    }
}

/**
 * Data structure for balanceOf action parameters
 * Used to parse incoming balanceOf action data
 */

@packer(nocodegen)
class BalanceOfData implements _chain.Packer {
    
  /**
   * Creates balanceOf action data
   * 
   * @param account - Account to query balance for
   */
  constructor(public account: Name = new Name()) {}
    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.account);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.account = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.account.getSize();
        return size;
    }
}

/**
 * Data structure for allowance action parameters
 * Used to parse incoming allowance action data
 */

@packer(nocodegen)
class AllowanceData implements _chain.Packer {
    
  /**
   * Creates allowance action data
   * 
   * @param owner - Account that owns the tokens
   * @param spender - Account that has spending permission
   */
  constructor(public owner: Name = new Name(), public spender: Name = new Name()) {}
    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.owner);
        enc.pack(this.spender);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.owner = obj;
        }
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.spender = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.owner.getSize();
        size += this.spender.getSize();
        return size;
    }
}

// === EVENT LOG STRUCTS ===

/**
 * Event log structure for transfer events
 * Used for off-chain indexing and monitoring
 */

@packer(nocodegen)
class TransferLog implements _chain.Packer {
     
  constructor(public from: Name = new Name(), public to: Name = new Name(), public quantity: Asset = new Asset(), public memo: string = "") { } 
    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.from);
        enc.pack(this.to);
        enc.pack(this.quantity);
        enc.packString(this.memo);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.from = obj;
        }
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.to = obj;
        }
        
        {
            let obj = new Asset();
            dec.unpack(obj);
            this.quantity = obj;
        }
        this.memo = dec.unpackString();
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.from.getSize();
        size += this.to.getSize();
        size += this.quantity.getSize();
        size += _chain.Utils.calcPackedStringLength(this.memo);
        return size;
    }
}

/**
 * Event log structure for approval events
 * Used for off-chain indexing and monitoring
 */

@packer(nocodegen)
class ApprovalLog implements _chain.Packer {
     
  constructor(public owner: Name = new Name(), public spender: Name = new Name(), public amount: Asset = new Asset()) { } 
    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.owner);
        enc.pack(this.spender);
        enc.pack(this.amount);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.owner = obj;
        }
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.spender = obj;
        }
        
        {
            let obj = new Asset();
            dec.unpack(obj);
            this.amount = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.owner.getSize();
        size += this.spender.getSize();
        size += this.amount.getSize();
        return size;
    }
}

/**
 * Event log structure for mint events
 * Used for off-chain indexing and monitoring
 */

@packer(nocodegen)
class MintLog implements _chain.Packer {
     
  constructor(public to: Name = new Name(), public quantity: Asset = new Asset()) { } 
    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.to);
        enc.pack(this.quantity);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.to = obj;
        }
        
        {
            let obj = new Asset();
            dec.unpack(obj);
            this.quantity = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.to.getSize();
        size += this.quantity.getSize();
        return size;
    }
}

// === CONTRACT ===

/**
 * Main ERC20-like token contract class
 * 
 * This contract implements a standard fungible token with the following actions:
 * - mint: Create new tokens (issuer only)
 * - transfer: Move tokens between accounts
 * - approve: Grant spending permission to another account
 * - transferFrom: Execute transfer on behalf of another account
 * - balanceOf: Query account balance
 * - allowance: Query spending allowance
 * 
 * @contract
 */
@contract
export class erc20like extends Contract {
    /** Table store for token statistics */
    private statTable: TableStore<Stat>;

    /**
     * Contract constructor
     * 
     * Required by proton-tsc framework. These parameters are provided by the blockchain
     * when an action is executed.
     * 
     * @param receiver - The account that receives the action (contract account)
     * @param firstReceiver - The first receiver in the action chain
     * @param action - The action name being executed
     */
    constructor(receiver: u64, firstReceiver: u64, action: u64) {
      super(Name.fromU64(receiver), Name.fromU64(firstReceiver), Name.fromU64(action));
      const self = this.receiver;
      this.statTable = new TableStore<Stat>(self, self);
    }


    /**
     * Reads the token statistics from the stat table
     * 
     * @throws Error if token is not initialized
     * @returns The token statistics record
     */
    private readStatRequired(): Stat {
        const stat = this.statTable.first();
        check(stat != null, "Token is not initialized. Call mint once with desired symbol to initialize.");
        return stat!;
    }
    
    /**
     * Gets the accounts table for a specific owner
     * 
     * @param owner - The account owner to get the table for
     * @returns TableStore instance for the owner's accounts
     */
    private getAccountsTable(owner: Name): TableStore<Account> { 
        return new TableStore<Account>(this.receiver, owner); 
    }
    
    /**
     * Gets the allowances table for a specific owner
     * 
     * @param owner - The account owner to get the allowances table for
     * @returns TableStore instance for the owner's allowances
     */
    private getAllowancesTable(owner: Name): TableStore<Allowance> { 
        return new TableStore<Allowance>(this.receiver, owner); 
    }
    
    /**
     * Validates that two assets have the same symbol and precision
     * 
     * @param a - First asset to compare
     * @param b - Second asset to compare
     * @throws Error if symbols don't match
     */
    private sameSymbol(a: Asset, b: Asset): void {
        check(a.symbol.code() == b.symbol.code() && a.symbol.precision == b.symbol.precision, "symbol mismatch");
    }

    // --- ACTIONS ---
    
    /**
     * Mints new tokens to a specified account
     * 
     * This action creates new tokens and adds them to the specified account.
     * Only the token issuer can call this action.
     * 
     * On first mint, the token is initialized with the specified symbol and issuer.
     * The issuer is set to the account calling the action.
     * 
     * RAM Management: The issuer pays RAM for new account creation.
     * 
     * @param to - Account to receive the minted tokens
     * @param quantity - Amount of tokens to mint (must be positive)
     * 
     * @throws Error if:
     * - Target account doesn't exist
     * - Quantity is invalid or not positive
     * - Caller is not the token issuer
     * - Symbol mismatch with existing token
     * 
     * @example
     * ```typescript
     * // Mint 1000 tokens to alice
     * contract.mint(Name.fromU64(0x345C850000000000), Asset.fromString("1000.0000 CINFRA"));
     * ```
     */
    @action("mint")
    mint(to: Name, quantity: Asset): void {
        check(isAccount(to), "to account does not exist");
        check(quantity.isValid(), "invalid quantity");
        check(quantity.amount > 0, "must mint positive quantity");

        let stat = this.statTable.first();
        if (stat == null) {
            // Lần đầu mint: issuer = người gọi action
            const issuer = Name.fromU64(0x434CE9BA6BB993B0); // hoặc dùng this.receiver
            stat = new Stat(quantity.symbol, new Asset(0, quantity.symbol), issuer);
            this.statTable.store(stat, this.receiver);
        }

        requireAuth(stat.issuer);
        this.sameSymbol(quantity, stat.supply);

        stat.supply = Asset.add(stat.supply, quantity);
        this.statTable.set(stat, this.receiver);

        const accts = this.getAccountsTable(to);
        let row = accts.get(stat.symbol.code());
        if (row == null) { row = new Account(new Asset(0, stat.symbol)); accts.store(row, stat.issuer); }
        row.balance = Asset.add(row.balance, quantity);
        accts.set(row, stat.issuer);

        requireRecipient(to);
        print(`[Mint] ${quantity.toString()} -> ${to.toString()}`);
    }

    /**
     * Transfers tokens from one account to another
     * 
     * This action moves tokens from the sender's account to the recipient's account.
     * The sender must have sufficient balance and proper authorization.
     * 
     * RAM Management: The sender pays RAM for new recipient account creation.
     * 
     * @param from - Account sending the tokens (must authorize this action)
     * @param to - Account receiving the tokens
     * @param quantity - Amount of tokens to transfer (must be positive)
     * @param memo - Optional memo for the transfer
     * 
     * @throws Error if:
     * - Recipient account doesn't exist
     * - Sender and recipient are the same
     * - Quantity is invalid or not positive
     * - Sender doesn't authorize the action
     * - Sender has insufficient balance
     * - Symbol mismatch with token
     * 
     * @example
     * ```typescript
     * // Transfer 100 tokens from alice to bob
     * contract.transfer(
     *   Name.fromU64(0x345C850000000000), 
     *   Name.fromU64(0x3D0E000000000000), 
     *   Asset.fromString("100.0000 CINFRA"), 
     *   "payment"
     * );
     * ```
     */
    @action("transfer")
    transfer(from: Name, to: Name, quantity: Asset, memo: string = ""): void {
        check(isAccount(to), "to account does not exist");
        check(from != to, "cannot transfer to self");
        check(quantity.isValid(), "invalid quantity");
        check(quantity.amount > 0, "must transfer positive quantity");
        requireAuth(from);

        const stat = this.readStatRequired();
        this.sameSymbol(quantity, stat.supply);

        const fromTable = this.getAccountsTable(from);
        const toTable = this.getAccountsTable(to);

        let fromRow = fromTable.get(stat.symbol.code());
        check(fromRow != null, "no balance object found");
        check(Asset.gte(fromRow!.balance, quantity), "overdrawn balance");

        fromRow!.balance = Asset.sub(fromRow!.balance, quantity);
        fromTable.set(fromRow!, from);

        let toRow = toTable.get(stat.symbol.code());
        if (toRow == null) { toRow = new Account(new Asset(0, stat.symbol)); toTable.store(toRow, from); }
        toRow.balance = Asset.add(toRow.balance, quantity);
        toTable.set(toRow, from);

        requireRecipient(from);
        requireRecipient(to);
        print(`[Transfer] ${from.toString()} -> ${to.toString()} : ${quantity.toString()} | memo="${memo}"`);
    }

    /**
     * Approves another account to spend tokens on behalf of the owner
     * 
     * This action grants spending permission to a spender account.
     * The spender can then use transferFrom to move tokens from the owner's account.
     * 
     * RAM Management: The owner pays RAM for new allowance record creation.
     * 
     * @param owner - Account that owns the tokens (must authorize this action)
     * @param spender - Account that gets spending permission
     * @param amount - Maximum amount that can be spent (must be non-negative)
     * 
     * @throws Error if:
     * - Spender account doesn't exist
     * - Owner and spender are the same
     * - Amount is invalid or negative
     * - Owner doesn't authorize the action
     * - Symbol mismatch with token
     * 
     * @example
     * ```typescript
     * // Approve alice to spend up to 500 tokens from bob's account
     * contract.approve(
     *   Name.fromU64(0x3D0E000000000000), 
     *   Name.fromU64(0x345C850000000000), 
     *   Asset.fromString("500.0000 CINFRA")
     * );
     * ```
     */
    @action("approve")
    approve(owner: Name, spender: Name, amount: Asset): void {
        check(isAccount(spender), "spender account does not exist");
        check(owner != spender, "cannot approve self");
        check(amount.isValid(), "invalid asset");
        check(amount.amount >= 0, "amount must be non-negative");
        requireAuth(owner);

        const stat = this.readStatRequired();
        this.sameSymbol(amount, stat.supply);

        const allowances = this.getAllowancesTable(owner);
        let row = allowances.get(spender.N);
        if (row == null) { row = new Allowance(spender, new Asset(0, stat.symbol)); allowances.store(row, owner); }
        row.amount = amount;
        allowances.set(row, owner);

        requireRecipient(owner);
        requireRecipient(spender);
        print(`[Approval] ${owner.toString()} -> ${spender.toString()} : ${amount.toString()}`);
    }

    /**
     * Transfers tokens from one account to another on behalf of the owner
     * 
     * This action allows a spender to transfer tokens from the owner's account
     * to another account, provided the spender has sufficient allowance.
     * 
     * The allowance is automatically reduced by the transferred amount.
     * 
     * RAM Management: The owner pays RAM for new recipient account creation.
     * 
     * @param spender - Account executing the transfer (must authorize this action)
     * @param from - Account that owns the tokens
     * @param to - Account receiving the tokens
     * @param amount - Amount of tokens to transfer (must be positive)
     * @param memo - Optional memo for the transfer
     * 
     * @throws Error if:
     * - Recipient account doesn't exist
     * - Owner and recipient are the same
     * - Amount is invalid or not positive
     * - Spender doesn't authorize the action
     * - Spender has no allowance or insufficient allowance
     * - Owner has insufficient balance
     * - Symbol mismatch with token
     * 
     * @example
     * ```typescript
     * // Alice transfers 100 tokens from Bob's account to Charlie
     * contract.transferFrom(
     *   Name.fromU64(0x345C850000000000),    // spender
     *   Name.fromU64(0x3D0E000000000000),      // from (owner)
     *   Name.fromU64(0x434D78B940000000),  // to
     *   Asset.fromString("100.0000 CINFRA"), 
     *   "delegated payment"
     * );
     * ```
     */
    @action("transferfrom")
    transferFrom(spender: Name, from: Name, to: Name, amount: Asset, memo: string = ""): void {
        check(isAccount(to), "to account does not exist");
        check(from != to, "cannot transfer to self");
        check(amount.isValid(), "invalid asset");
        check(amount.amount > 0, "must transfer positive amount");
        requireAuth(spender);

        const stat = this.readStatRequired();
        this.sameSymbol(amount, stat.supply);

        const allowances = this.getAllowancesTable(from);
        let allow = allowances.get(spender.N);
        check(allow != null, "no allowance for spender");
        check(Asset.gte(allow!.amount, amount), "insufficient allowance");

        allow!.amount = Asset.sub(allow!.amount, amount);
        allowances.set(allow!, from);

        const fromTable = this.getAccountsTable(from);
        const toTable = this.getAccountsTable(to);

        let fromRow = fromTable.get(stat.symbol.code());
        check(fromRow != null, "no balance object found");
        check(Asset.gte(fromRow!.balance, amount), "overdrawn balance");

        fromRow!.balance = Asset.sub(fromRow!.balance, amount);
        fromTable.set(fromRow!, from);

        let toRow = toTable.get(stat.symbol.code());
        if (toRow == null) { toRow = new Account(new Asset(0, stat.symbol)); toTable.store(toRow, from); }
        toRow.balance = Asset.add(toRow.balance, amount);
        toTable.set(toRow, from);

        requireRecipient(from);
        requireRecipient(to);
        requireRecipient(spender);
        print(`[TransferFrom] ${spender.toString()} : ${from.toString()} -> ${to.toString()} : ${amount.toString()} | memo="${memo}"`);
    }

    /**
     * Queries the token balance of a specific account
     * 
     * This is a read-only action that returns the current token balance
     * for the specified account. If the account has no balance record,
     * it returns zero.
     * 
     * No authorization is required for this action.
     * 
     * @param account - Account to query balance for
     * 
     * @example
     * ```typescript
     * // Query alice's balance
     * contract.balanceOf(Name.fromU64(0x345C850000000000));
     * // Console output: [BalanceOf] alice = 1000.0000 CINFRA
     * ```
     */
    @action("balanceof")
    balanceOf(account: Name): void {
        const stat = this.readStatRequired();
        const accts = this.getAccountsTable(account);
        const row = accts.get(stat.symbol.code());
        const bal = row ? row.balance : new Asset(0, stat.symbol);
        print(`[BalanceOf] ${account.toString()} = ${bal.toString()}`);
    }

    /**
     * Queries the spending allowance between two accounts
     * 
     * This is a read-only action that returns the current allowance
     * that the owner has granted to the spender. If no allowance exists,
     * it returns zero.
     * 
     * No authorization is required for this action.
     * 
     * @param owner - Account that owns the tokens
     * @param spender - Account that has spending permission
     * 
     * @example
     * ```typescript
     * // Query how much alice can spend from bob's account
     * contract.allowance(Name.fromU64(0x3D0E000000000000), Name.fromU64(0x345C850000000000));
     * // Console output: [Allowance] owner=bob spender=alice amount=500.0000 CINFRA
     * ```
     */
    @action("allowance")
    allowance(owner: Name, spender: Name): void {
        const stat = this.readStatRequired();
        const allowances = this.getAllowancesTable(owner);
        const row = allowances.get(spender.N);
        const amt = row ? row.amount : new Asset(0, stat.symbol);
        print(`[Allowance] owner=${owner.toString()} spender=${spender.toString()} amount=${amt.toString()}`);
    }
}

// === EOSIO ENTRYPOINT ===

/**
 * EOSIO entrypoint function for action dispatch
 * 
 * This is the main entry point called by the EOSIO blockchain when an action
 * is executed on this contract. It creates a contract instance and dispatches
 * the action to the appropriate method based on the action name.
 * 
 * The function uses manual dispatch to parse action data and call the
 * corresponding contract methods. This approach provides better control
 * over data parsing and error handling.
 * 
 * @param receiver - The account that receives the action (contract account)
 * @param firstReceiver - The first receiver in the action chain
 * @param action - The action name being executed (as u64)
 * 
 * Supported actions:
 * - mint: Create new tokens
 * - transfer: Move tokens between accounts
 * - approve: Grant spending permission
 * - transferfrom: Execute delegated transfer
 * - balanceof: Query account balance
 * - allowance: Query spending allowance
 * 
 * @example
 * ```typescript
 * // When "mint" action is called with data {"to": "alice", "quantity": "1000.0000 CINFRA"}
 * // This function will:
 * // 1. Create erc20like contract instance
 * // 2. Parse action data into MintData
 * // 3. Call contract.mint(data.to, data.quantity)
 * ```
 */
export function apply(receiver: u64, firstReceiver: u64, action: u64): void {
    const contract = new erc20like(receiver, firstReceiver, action);
    
    // Manual dispatch based on action name
    const actionName = Name.fromU64(action);
    const actionStr = actionName.toString();
    
    if (actionStr == "mint") {
        const data = unpackActionData<MintData>();
        contract.mint(data.to, data.quantity);
    } else if (actionStr == "transfer") {
        const data = unpackActionData<TransferData>();
        contract.transfer(data.from, data.to, data.quantity, data.memo);
    } else if (actionStr == "approve") {
        const data = unpackActionData<ApproveData>();
        contract.approve(data.owner, data.spender, data.amount);
    } else if (actionStr == "transferfrom") {
        const data = unpackActionData<TransferFromData>();
        contract.transferFrom(data.spender, data.from, data.to, data.amount, data.memo);
    } else if (actionStr == "balanceof") {
        const data = unpackActionData<BalanceOfData>();
        contract.balanceOf(data.account);
    } else if (actionStr == "allowance") {
        const data = unpackActionData<AllowanceData>();
        contract.allowance(data.owner, data.spender);
    }
}


class mintAction implements _chain.Packer {
    constructor (
        public to: _chain.Name | null = null,
        public quantity: _chain.Asset | null = null,
    ) {
    }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.to!);
        enc.pack(this.quantity!);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new _chain.Name();
            dec.unpack(obj);
            this.to! = obj;
        }
        
        {
            let obj = new _chain.Asset();
            dec.unpack(obj);
            this.quantity! = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.to!.getSize();
        size += this.quantity!.getSize();
        return size;
    }
}

class transferAction implements _chain.Packer {
    constructor (
        public from: _chain.Name | null = null,
        public to: _chain.Name | null = null,
        public quantity: _chain.Asset | null = null,
        public memo: string = "",
    ) {
    }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.from!);
        enc.pack(this.to!);
        enc.pack(this.quantity!);
        enc.packString(this.memo);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new _chain.Name();
            dec.unpack(obj);
            this.from! = obj;
        }
        
        {
            let obj = new _chain.Name();
            dec.unpack(obj);
            this.to! = obj;
        }
        
        {
            let obj = new _chain.Asset();
            dec.unpack(obj);
            this.quantity! = obj;
        }
        this.memo = dec.unpackString();
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.from!.getSize();
        size += this.to!.getSize();
        size += this.quantity!.getSize();
        size += _chain.Utils.calcPackedStringLength(this.memo);
        return size;
    }
}

class approveAction implements _chain.Packer {
    constructor (
        public owner: _chain.Name | null = null,
        public spender: _chain.Name | null = null,
        public amount: _chain.Asset | null = null,
    ) {
    }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.owner!);
        enc.pack(this.spender!);
        enc.pack(this.amount!);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new _chain.Name();
            dec.unpack(obj);
            this.owner! = obj;
        }
        
        {
            let obj = new _chain.Name();
            dec.unpack(obj);
            this.spender! = obj;
        }
        
        {
            let obj = new _chain.Asset();
            dec.unpack(obj);
            this.amount! = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.owner!.getSize();
        size += this.spender!.getSize();
        size += this.amount!.getSize();
        return size;
    }
}

class transferFromAction implements _chain.Packer {
    constructor (
        public spender: _chain.Name | null = null,
        public from: _chain.Name | null = null,
        public to: _chain.Name | null = null,
        public amount: _chain.Asset | null = null,
        public memo: string = "",
    ) {
    }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.spender!);
        enc.pack(this.from!);
        enc.pack(this.to!);
        enc.pack(this.amount!);
        enc.packString(this.memo);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new _chain.Name();
            dec.unpack(obj);
            this.spender! = obj;
        }
        
        {
            let obj = new _chain.Name();
            dec.unpack(obj);
            this.from! = obj;
        }
        
        {
            let obj = new _chain.Name();
            dec.unpack(obj);
            this.to! = obj;
        }
        
        {
            let obj = new _chain.Asset();
            dec.unpack(obj);
            this.amount! = obj;
        }
        this.memo = dec.unpackString();
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.spender!.getSize();
        size += this.from!.getSize();
        size += this.to!.getSize();
        size += this.amount!.getSize();
        size += _chain.Utils.calcPackedStringLength(this.memo);
        return size;
    }
}

class balanceOfAction implements _chain.Packer {
    constructor (
        public account: _chain.Name | null = null,
    ) {
    }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.account!);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new _chain.Name();
            dec.unpack(obj);
            this.account! = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.account!.getSize();
        return size;
    }
}

class allowanceAction implements _chain.Packer {
    constructor (
        public owner: _chain.Name | null = null,
        public spender: _chain.Name | null = null,
    ) {
    }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.owner!);
        enc.pack(this.spender!);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new _chain.Name();
            dec.unpack(obj);
            this.owner! = obj;
        }
        
        {
            let obj = new _chain.Name();
            dec.unpack(obj);
            this.spender! = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.owner!.getSize();
        size += this.spender!.getSize();
        return size;
    }
}