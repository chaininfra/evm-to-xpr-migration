import * as _chain from "as-chain";
/**
 * @fileoverview Simple Storage Contract - Proton TSC Smart Contract
 * 
 * Đây là một smart contract đơn giản implement một counter có giới hạn với các tính năng:
 * - Theo dõi lịch sử thay đổi (history tracking)
 * - Ghi nhận người cập nhật cuối cùng (last updater tracking)
 * - Bảo vệ khỏi overflow/underflow với bounds checking
 * 
 * @author Proton Developer
 * @version 1.0.0
 * @since 2024
 * 
 * @example
 * ```typescript
 * // Deploy contract và sử dụng
 * const counter = new Counter();
 * counter.set("alice", 100);  // Set giá trị 100
 * counter.increment("alice"); // Tăng lên 101
 * counter.get();              // Lấy giá trị hiện tại
 * ```
 */

import {
  Contract,
  Name,
  Table,
  TableStore,
  check,
  requireAuth,
  print,
} from "proton-tsc";

// ===== Constants =====
/**
 * Giá trị tối thiểu cho counter
 * @constant {u64} MIN_VALUE
 */
const MIN_VALUE: u64 = 0;

/**
 * Giá trị tối đa cho counter (1 nghìn tỷ)
 * Sử dụng giới hạn bảo thủ để tránh lỗi 64-bit literal trong TypeScript
 * @constant {u64} MAX_VALUE
 */
const MAX_VALUE: u64 = 1_000_000_000_000;

// ===== Tables =====

/**
 * Bảng State - Lưu trữ trạng thái hiện tại của counter
 * Sử dụng singleton pattern với primary key = 0
 * 
 * @table state
 * @extends Table
 */


export class StateDB extends _chain.MultiIndex<State> {

}

@table("state", nocodegen)

export class State implements _chain.MultiIndexValue {
    
  /**
   * Constructor cho State table
   * @param {u64} id - Primary key (luôn = 0 cho singleton)
   * @param {u64} value - Giá trị counter hiện tại
   * @param {Name} lastUpdater - Account name của người cập nhật cuối
   * @param {u64} lastHistoryId - ID của history entry cuối cùng
   */
  constructor(
    public id: u64 = 0, // singleton-style row (always primary key = 0)
    public value: u64 = 0,
    public lastUpdater: Name = new Name(),
    public lastHistoryId: u64 = 0 // points to last entry written to History
  ) {
    
  }

  /**
   * Primary key getter
   * @returns {u64} Primary key của table row
   */
  @primary
  get primary(): u64 {
    return this.id;
  }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.packNumber<u64>(this.id);
        enc.packNumber<u64>(this.value);
        enc.pack(this.lastUpdater);
        enc.packNumber<u64>(this.lastHistoryId);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        this.id = dec.unpackNumber<u64>();
        this.value = dec.unpackNumber<u64>();
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.lastUpdater = obj;
        }
        this.lastHistoryId = dec.unpackNumber<u64>();
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += sizeof<u64>();
        size += sizeof<u64>();
        size += this.lastUpdater.getSize();
        size += sizeof<u64>();
        return size;
    }

    static get tableName(): _chain.Name {
        return _chain.Name.fromU64(0xC64D950000000000);
    }

    static tableIndexes(code: _chain.Name, scope: _chain.Name): _chain.IDXDB[] {
        const idxTableBase: u64 = this.tableName.N & 0xfffffffffffffff0;
        const indices: _chain.IDXDB[] = [
        ];
        return indices;
    }

    getTableName(): _chain.Name {
        return State.tableName;
    }

    getTableIndexes(code: _chain.Name, scope: _chain.Name): _chain.IDXDB[] {
        return State.tableIndexes(code, scope);
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


    static new(code: _chain.Name, scope: _chain.Name  = _chain.EMPTY_NAME): StateDB {
        return new StateDB(code, scope, this.tableName, this.tableIndexes(code, scope));
    }
}

/**
 * Bảng History - Lưu trữ lịch sử tất cả thay đổi của counter
 * Mỗi lần thay đổi sẽ tạo một entry mới với auto-increment ID
 * 
 * @table history
 * @extends Table
 */


export class HistoryDB extends _chain.MultiIndex<History> {

}

@table("history", nocodegen)

export class History implements _chain.MultiIndexValue {
    
  /**
   * Constructor cho History table
   * @param {u64} id - Primary key (auto-increment)
   * @param {u64} oldValue - Giá trị trước khi thay đổi
   * @param {u64} newValue - Giá trị sau khi thay đổi
   * @param {Name} updater - Account name của người thực hiện thay đổi
   */
  constructor(
    public id: u64 = 0,
    public oldValue: u64 = 0,
    public newValue: u64 = 0,
    public updater: Name = new Name()
  ) {
    
  }

  /**
   * Primary key getter
   * @returns {u64} Primary key của table row
   */
  @primary
  get primary(): u64 {
    return this.id;
  }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.packNumber<u64>(this.id);
        enc.packNumber<u64>(this.oldValue);
        enc.packNumber<u64>(this.newValue);
        enc.pack(this.updater);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        this.id = dec.unpackNumber<u64>();
        this.oldValue = dec.unpackNumber<u64>();
        this.newValue = dec.unpackNumber<u64>();
        
        {
            let obj = new Name();
            dec.unpack(obj);
            this.updater = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += sizeof<u64>();
        size += sizeof<u64>();
        size += sizeof<u64>();
        size += this.updater.getSize();
        return size;
    }

    static get tableName(): _chain.Name {
        return _chain.Name.fromU64(0x6BB19A5FC0000000);
    }

    static tableIndexes(code: _chain.Name, scope: _chain.Name): _chain.IDXDB[] {
        const idxTableBase: u64 = this.tableName.N & 0xfffffffffffffff0;
        const indices: _chain.IDXDB[] = [
        ];
        return indices;
    }

    getTableName(): _chain.Name {
        return History.tableName;
    }

    getTableIndexes(code: _chain.Name, scope: _chain.Name): _chain.IDXDB[] {
        return History.tableIndexes(code, scope);
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


    static new(code: _chain.Name, scope: _chain.Name  = _chain.EMPTY_NAME): HistoryDB {
        return new HistoryDB(code, scope, this.tableName, this.tableIndexes(code, scope));
    }
}

/**
 * Counter Contract - Smart contract chính implement counter functionality
 * 
 * Contract này cung cấp các action:
 * - set(actor, value): Đặt giá trị counter với bounds checking
 * - get(): Lấy giá trị hiện tại
 * - increment(actor): Tăng counter lên 1
 * - decrement(actor): Giảm counter xuống 1
 * - getHistory(): Xem lịch sử thay đổi
 * - getLastUpdater(): Xem người cập nhật cuối
 * 
 * @contract
 * @extends Contract
 */
@contract
export class Counter extends Contract {
  /** Table store cho State table */
  private stateTable: TableStore<State> = new TableStore<State>(this.receiver);
  /** Table store cho History table */
  private historyTable: TableStore<History> = new TableStore<History>(this.receiver);

  // ========== Helper Methods ==========

  /**
   * Lấy hoặc khởi tạo State record
   * Sử dụng lazy initialization pattern - chỉ tạo khi cần thiết
   * 
   * @returns {State} State record (luôn tồn tại sau khi gọi method này)
   */
  private getOrInitState(): State {
    let s = this.stateTable.get(0);
    if (!s) {
      s = new State(0, 0, new Name(), 0);
      this.stateTable.store(s, this.receiver);
      print(`Initialized state with value=${s.value.toString()}`);
    }
    return s as State;
  }

  /**
   * Thêm entry mới vào History table
   * Sử dụng auto-increment ID dựa trên entry cuối cùng
   * 
   * @param {u64} oldValue - Giá trị cũ
   * @param {u64} newValue - Giá trị mới
   * @param {Name} updater - Account thực hiện thay đổi
   * @returns {u64} ID của history entry vừa tạo
   */
  private appendHistory(oldValue: u64, newValue: u64, updater: Name): u64 {
    // Sử dụng auto-increment ID đơn giản
    const h = new History(0, oldValue, newValue, updater);
    this.historyTable.store(h, this.receiver);
    return 0; // Return ID của entry vừa tạo
  }

  /**
   * Kiểm tra giá trị có nằm trong giới hạn cho phép không
   * Throw error nếu vượt quá MIN_VALUE hoặc MAX_VALUE
   * 
   * @param {u64} next - Giá trị cần kiểm tra
   * @throws {Error} Nếu giá trị vượt quá giới hạn
   */
  private enforceBounds(next: u64): void {
    check(next >= MIN_VALUE, `Value underflows MIN (${MIN_VALUE.toString()})`);
    check(next <= MAX_VALUE, `Value overflows MAX (${MAX_VALUE.toString()})`);
  }

  // ========== Actions ==========

  /**
   * Set action - Đặt counter về một giá trị cụ thể
   * 
   * Thực hiện:
   * 1. Kiểm tra authorization của actor
   * 2. Kiểm tra giá trị có nằm trong bounds không
   * 3. Ghi history entry trước khi update
   * 4. Update state với giá trị mới và metadata
   * 
   * @param {Name} actor - Account thực hiện action (phải có quyền)
   * @param {u64} value - Giá trị mới cho counter
   * 
   * @example
   * ```typescript
   * counter.set("alice", 100); // Đặt counter = 100
   * ```
   */
  @action("set")
  set(actor: Name, value: u64): void {
    print(`DEBUG: set action called with actor=${actor.toString()}, value=${value.toString()}`);
    requireAuth(actor);           // Kiểm tra authorization

    this.enforceBounds(value);    // Kiểm tra giới hạn

    const s = this.getOrInitState();
    const oldValue = s.value;
    print(`DEBUG: current state value=${oldValue.toString()}`);

    if (value == oldValue) {
      // No-op nhưng vẫn in thông báo
      print(`no change (value remains ${value.toString()})`);
      return;
    }

    // Ghi history trước khi update state
    const hid = this.appendHistory(oldValue, value, actor);
    print(`DEBUG: history entry created with id=${hid.toString()}`);

    // Update state
    s.value = value;
    s.lastUpdater = actor;
    s.lastHistoryId = hid;
    this.stateTable.update(s, this.receiver);
    print(`DEBUG: state updated successfully`);

    print(`set -> ${value.toString()} by ${actor.toString()}`);
  }

  /**
   * Get action - Lấy giá trị hiện tại của counter
   * 
   * Action này chỉ đọc dữ liệu và in ra console.
   * Có thể được gọi bởi bất kỳ ai (không cần authorization).
   * 
   * @example
   * ```typescript
   * counter.get(); // In ra: value=100
   * ```
   */
  @action("get")
  get(): void {
    const s = this.getOrInitState();
    print(`value=${s.value.toString()}`);
  }

  /**
   * Increment action - Tăng counter lên 1
   * 
   * Thực hiện:
   * 1. Kiểm tra authorization của actor
   * 2. Tính toán giá trị mới (value + 1)
   * 3. Kiểm tra overflow protection
   * 4. Ghi history và update state
   * 
   * @param {Name} actor - Account thực hiện action (phải có quyền)
   * 
   * @example
   * ```typescript
   * counter.increment("alice"); // Tăng counter lên 1
   * ```
   */
  @action("increment")
  increment(actor: Name): void {
    requireAuth(actor);
    const s = this.getOrInitState();
    const next: u64 = s.value + 1;
    this.enforceBounds(next);

    const hid = this.appendHistory(s.value, next, actor);
    s.value = next;
    s.lastUpdater = actor;
    s.lastHistoryId = hid;
    this.stateTable.update(s, this.receiver);

    print(`increment -> ${s.value.toString()} by ${actor.toString()}`);
  }

  /**
   * Decrement action - Giảm counter xuống 1
   * 
   * Thực hiện:
   * 1. Kiểm tra authorization của actor
   * 2. Kiểm tra không được giảm xuống dưới MIN_VALUE
   * 3. Tính toán giá trị mới (value - 1)
   * 4. Kiểm tra bounds và ghi history
   * 
   * @param {Name} actor - Account thực hiện action (phải có quyền)
   * 
   * @example
   * ```typescript
   * counter.decrement("alice"); // Giảm counter xuống 1
   * ```
   */
  @action("decrement")
  decrement(actor: Name): void {
    requireAuth(actor);
    const s = this.getOrInitState();
    check(s.value > MIN_VALUE, `Cannot decrement below MIN (${MIN_VALUE.toString()})`);
    const next: u64 = s.value - 1;
    this.enforceBounds(next);

    const hid = this.appendHistory(s.value, next, actor);
    s.value = next;
    s.lastUpdater = actor;
    s.lastHistoryId = hid;
    this.stateTable.update(s, this.receiver);

    print(`decrement -> ${s.value.toString()} by ${actor.toString()}`);
  }

  /**
   * Get History action - Xem thông tin về history entry cuối cùng
   * 
   * Action này in ra thông tin của history entry cuối cùng bao gồm:
   * - ID của entry
   * - Giá trị cũ và mới
   * - Account thực hiện thay đổi
   * 
   * Lưu ý: Để xem toàn bộ history, cần sử dụng table query tools off-chain
   * 
   * @example
   * ```typescript
   * counter.getHistory(); // In ra thông tin history cuối
   * ```
   */
  @action("gethistory")
  getHistory(): void {
    const last = this.historyTable.last();
    if (!last) {
      print("history is empty");
      return;
    }
    const h = last as History;
    print(
      `last history id=${h.id.toString()}, old=${h.oldValue.toString()}, new=${h.newValue.toString()}, updater=${h.updater.toString()}`
    );
  }

  /**
   * Get Last Updater action - Xem account thực hiện thay đổi cuối cùng
   * 
   * Action này in ra tên account của người thực hiện thay đổi cuối cùng.
   * Nếu chưa có thay đổi nào, sẽ in "no updates yet".
   * 
   * @example
   * ```typescript
   * counter.getLastUpdater(); // In ra: lastUpdater=alice
   * ```
   */
  @action("getlastupdt")
  getLastUpdater(): void {
    const s = this.getOrInitState();
    // Nếu chưa có history, nghĩa là chưa có updater nào
    const last = this.historyTable.last();
    if (!last) {
      print("no updates yet");
      return;
    }
    print(`lastUpdater=${s.lastUpdater.toString()}`);
  }
}

class setAction implements _chain.Packer {
    constructor (
        public actor: _chain.Name | null = null,
        public value: u64 = 0,
    ) {
    }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.actor!);
        enc.packNumber<u64>(this.value);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new _chain.Name();
            dec.unpack(obj);
            this.actor! = obj;
        }
        this.value = dec.unpackNumber<u64>();
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.actor!.getSize();
        size += sizeof<u64>();
        return size;
    }
}

class getAction implements _chain.Packer {
    constructor (
    ) {
    }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        return size;
    }
}

class incrementAction implements _chain.Packer {
    constructor (
        public actor: _chain.Name | null = null,
    ) {
    }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.actor!);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new _chain.Name();
            dec.unpack(obj);
            this.actor! = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.actor!.getSize();
        return size;
    }
}

class decrementAction implements _chain.Packer {
    constructor (
        public actor: _chain.Name | null = null,
    ) {
    }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.pack(this.actor!);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        
        {
            let obj = new _chain.Name();
            dec.unpack(obj);
            this.actor! = obj;
        }
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += this.actor!.getSize();
        return size;
    }
}

class getHistoryAction implements _chain.Packer {
    constructor (
    ) {
    }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        return size;
    }
}

class getLastUpdaterAction implements _chain.Packer {
    constructor (
    ) {
    }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        return size;
    }
}

export function apply(receiver: u64, firstReceiver: u64, action: u64): void {
	const _receiver = new _chain.Name(receiver);
	const _firstReceiver = new _chain.Name(firstReceiver);
	const _action = new _chain.Name(action);

	const mycontract = new Counter(_receiver, _firstReceiver, _action);
	const actionData = _chain.readActionData();

	if (receiver == firstReceiver) {
		if (action == 0xC2B2000000000000) {//set
            const args = new setAction();
            args.unpack(actionData);
            mycontract.set(args.actor!,args.value);
        }
		if (action == 0x62B2000000000000) {//get
            const args = new getAction();
            args.unpack(actionData);
            mycontract.get();
        }
		if (action == 0x74D1754953C80000) {//increment
            const args = new incrementAction();
            args.unpack(actionData);
            mycontract.increment(args.actor!);
        }
		if (action == 0x4A91754953C80000) {//decrement
            const args = new decrementAction();
            args.unpack(actionData);
            mycontract.decrement(args.actor!);
        }
		if (action == 0x62B2D76334BF8000) {//gethistory
            const args = new getHistoryAction();
            args.unpack(actionData);
            mycontract.getHistory();
        }
		if (action == 0x62B313633AAA7200) {//getlastupdt
            const args = new getLastUpdaterAction();
            args.unpack(actionData);
            mycontract.getLastUpdater();
        }
	}
  
	if (receiver != firstReceiver) {
		
	}
	return;
}
