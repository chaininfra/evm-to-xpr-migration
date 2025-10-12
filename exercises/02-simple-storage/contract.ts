/**
 * @fileoverview Simple Storage Contract - Proton TSC Smart Contract
 * 
 * This is a simple smart contract implementing a bounded counter with features:
 * - History tracking for all changes
 * - Last updater tracking
 * - Overflow/underflow protection with bounds checking
 * 
 * @author Proton Developer
 * @version 1.0.0
 * @since 2024
 * 
 * @example
 * ```typescript
 * // Deploy contract and use
 * const counter = new Counter();
 * counter.set("alice", 100);  // Set value to 100
 * counter.increment("alice"); // Increment to 101
 * counter.get();              // Get current value
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
 * Minimum value for counter
 * @constant {u64} MIN_VALUE
 */
const MIN_VALUE: u64 = 0;

/**
 * Maximum value for counter (1 trillion)
 * Using conservative limit to avoid 64-bit literal issues in TypeScript
 * @constant {u64} MAX_VALUE
 */
const MAX_VALUE: u64 = 1_000_000_000_000;

// ===== Tables =====

/**
 * State Table - Store current counter state
 * Uses singleton pattern with primary key = 0
 * 
 * @table state
 * @extends Table
 */
@table("state")
export class State extends Table {
  /**
   * Constructor for State table
   * @param {u64} id - Primary key (always = 0 for singleton)
   * @param {u64} value - Current counter value
   * @param {Name} lastUpdater - Account name of last updater
   * @param {u64} lastHistoryId - ID of last history entry
   */
  constructor(
    public id: u64 = 0, // singleton-style row (always primary key = 0)
    public value: u64 = 0,
    public lastUpdater: Name = new Name(),
    public lastHistoryId: u64 = 0 // points to last entry written to History
  ) {
    super();
  }

  /**
   * Primary key getter
   * @returns {u64} Primary key of table row
   */
  @primary
  get primary(): u64 {
    return this.id;
  }
}

/**
 * History Table - Store history of all counter changes
 * Each change creates a new entry with auto-increment ID
 * 
 * @table history
 * @extends Table
 */
@table("history")
export class History extends Table {
  /**
   * Constructor for History table
   * @param {u64} id - Primary key (auto-increment)
   * @param {u64} oldValue - Value before change
   * @param {u64} newValue - Value after change
   * @param {Name} updater - Account name of who made the change
   */
  constructor(
    public id: u64 = 0,
    public oldValue: u64 = 0,
    public newValue: u64 = 0,
    public updater: Name = new Name()
  ) {
    super();
  }

  /**
   * Primary key getter
   * @returns {u64} Primary key of table row
   */
  @primary
  get primary(): u64 {
    return this.id;
  }
}

/**
 * Counter Contract - Main smart contract implementing counter functionality
 * 
 * This contract provides the following actions:
 * - set(actor, value): Set counter value with bounds checking
 * - get(): Get current value
 * - increment(actor): Increment counter by 1
 * - decrement(actor): Decrement counter by 1
 * - getHistory(): View change history
 * - getLastUpdater(): View last updater
 * 
 * @contract
 * @extends Contract
 */
@contract
export class Counter extends Contract {
  /** Table store for State table */
  private stateTable: TableStore<State> = new TableStore<State>(this.receiver);
  /** Table store for History table */
  private historyTable: TableStore<History> = new TableStore<History>(this.receiver);

  // ========== Helper Methods ==========

  /**
   * Get or initialize State record
   * Uses lazy initialization pattern - only create when needed
   * 
   * @returns {State} State record (always exists after calling this method)
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
   * Add new entry to History table
   * Uses simple auto-increment ID
   * 
   * @param {u64} oldValue - Old value
   * @param {u64} newValue - New value
   * @param {Name} updater - Account that made the change
   * @returns {u64} ID of the created history entry
   */
  private appendHistory(oldValue: u64, newValue: u64, updater: Name): u64 {
    // Use simple auto-increment ID
    const h = new History(0, oldValue, newValue, updater);
    this.historyTable.store(h, this.receiver);
    return 0; // Return ID of created entry
  }

  /**
   * Check if value is within allowed bounds
   * Throw error if exceeds MIN_VALUE or MAX_VALUE
   * 
   * @param {u64} next - Value to check
   * @throws {Error} If value exceeds bounds
   */
  private enforceBounds(next: u64): void {
    check(next >= MIN_VALUE, `Value underflows MIN (${MIN_VALUE.toString()})`);
    check(next <= MAX_VALUE, `Value overflows MAX (${MAX_VALUE.toString()})`);
  }

  // ========== Actions ==========

  /**
   * Set action - Set counter to a specific value
   * 
   * Process:
   * 1. Check authorization of actor
   * 2. Check if value is within bounds
   * 3. Write history entry before update
   * 4. Update state with new value and metadata
   * 
   * @param {Name} actor - Account performing action (must have permission)
   * @param {u64} value - New value for counter
   * 
   * @example
   * ```typescript
   * counter.set("alice", 100); // Set counter = 100
   * ```
   */
  @action("set")
  set(actor: Name, value: u64): void {
    print(`DEBUG: set action called with actor=${actor.toString()}, value=${value.toString()}`);
    requireAuth(actor);           // Check authorization

    this.enforceBounds(value);    // Check bounds

    const s = this.getOrInitState();
    const oldValue = s.value;
    print(`DEBUG: current state value=${oldValue.toString()}`);

    if (value == oldValue) {
      // No-op but still print message
      print(`no change (value remains ${value.toString()})`);
      return;
    }

    // Write history before updating state
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
   * Get action - Get current counter value
   * 
   * This action only reads data and prints to console.
   * Can be called by anyone (no authorization required).
   * 
   * @example
   * ```typescript
   * counter.get(); // Prints: value=100
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