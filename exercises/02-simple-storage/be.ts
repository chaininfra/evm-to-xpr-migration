/**
 * @fileoverview Backend Service - Proton Blockchain Data Fetcher
 * 
 * This service uses @proton/js to interact with Proton blockchain
 * and fetch information from Simple Storage Contract:
 * - Get last updater information
 * - Get history of changes
 * - Get current counter value
 * 
 * @author Proton Developer
 * @version 1.0.0
 * @since 2024
 */

import { Api, JsonRpc } from '@proton/js';

// ===== Configuration =====
const CONTRACT_ACCOUNT = 'chaininfradv'; // Change to your contract account
const RPC_ENDPOINT = 'https://testnet-api.chaininfra.net'; // Proton testnet RPC
const HISTORY_LIMIT = 100; // Maximum number of history entries

// ===== Proton API Setup =====
const rpc = new JsonRpc(RPC_ENDPOINT);
const api = new Api({
  rpc,
  // No signatureProvider needed for read-only operations
});

// ===== Types =====
interface StateData {
  id: number;
  value: string;
  lastUpdater: string;
  lastHistoryId: number;
}

interface HistoryData {
  id: number;
  oldValue: string;
  newValue: string;
  updater: string;
}

interface ContractResponse {
  state: StateData | null;
  history: HistoryData[];
  currentValue: number;
  lastUpdater: string | null;
}

// ===== Helper Functions =====

/**
 * Convert Name from blockchain to readable string
 * @param {string} name - Name from blockchain
 * @returns {string} Readable account name
 */
function formatAccountName(name: string): string {
  // Proton names are usually encoded, decode if needed
  return name;
}

/**
 * Convert u64 string to number
 * @param {string} value - u64 value from blockchain
 * @returns {number} Number value
 */
function parseU64(value: string): number {
  return parseInt(value, 10);
}

// ===== Main Service Functions =====

/**
 * Get current State information from contract
 * @returns {Promise<StateData | null>} State data or null if not exists
 */
export async function getCurrentState(): Promise<StateData | null> {
  try {
    console.log(`Fetching state from contract: ${CONTRACT_ACCOUNT}`);
    
    const response = await rpc.get_table_rows({
      code: CONTRACT_ACCOUNT,
      table: 'state',
      scope: CONTRACT_ACCOUNT,
      limit: 1,
      reverse: false,
    });

    if (response.rows.length === 0) {
      console.log('No state data found');
      return null;
    }

    const state = response.rows[0];
    console.log('State data retrieved:', state);
    
    return {
      id: state.id,
      value: state.value,
      lastUpdater: formatAccountName(state.lastUpdater),
      lastHistoryId: state.lastHistoryId,
    };
  } catch (error) {
    console.error('Error fetching state:', error);
    const errorMessage = error instanceof Error ? error.message : 'Unknown error';
    throw new Error(`Failed to fetch state: ${errorMessage}`);
  }
}

/**
 * Get change history from contract
 * @param {number} limit - Maximum number of entries (default: HISTORY_LIMIT)
 * @returns {Promise<HistoryData[]>} Array of history entries
 */
export async function getHistory(limit: number = HISTORY_LIMIT): Promise<HistoryData[]> {
  try {
    console.log(`Fetching history from contract: ${CONTRACT_ACCOUNT} (limit: ${limit})`);
    
    const response = await rpc.get_table_rows({
      code: CONTRACT_ACCOUNT,
      table: 'history',
      scope: CONTRACT_ACCOUNT,
      limit: limit,
      reverse: true, // Get newest entries first
    });

    if (response.rows.length === 0) {
      console.log('No history data found');
      return [];
    }

    const history = response.rows.map((row: any) => ({
      id: row.id,
      oldValue: row.oldValue,
      newValue: row.newValue,
      updater: formatAccountName(row.updater),
    }));

    console.log(`History data retrieved: ${history.length} entries`);
    return history;
  } catch (error) {
    console.error('Error fetching history:', error);
    const errorMessage = error instanceof Error ? error.message : 'Unknown error';
    throw new Error(`Failed to fetch history: ${errorMessage}`);
  }
}

/**
 * Get last updater information
 * @returns {Promise<string | null>} Account name of last updater
 */
export async function getLastUpdater(): Promise<string | null> {
  try {
    const state = await getCurrentState();
    return state ? state.lastUpdater : null;
  } catch (error) {
    console.error('Error fetching last updater:', error);
    throw error;
  }
}

/**
 * Get current counter value
 * @returns {Promise<number>} Current value
 */
export async function getCurrentValue(): Promise<number> {
  try {
    const state = await getCurrentState();
    return state ? parseU64(state.value) : 0;
  } catch (error) {
    console.error('Error fetching current value:', error);
    throw error;
  }
}

/**
 * Get all contract information in one call
 * @returns {Promise<ContractResponse>} All contract information
 */
export async function getAllContractData(): Promise<ContractResponse> {
  try {
    console.log('Fetching all contract data...');
    
    // Fetch state and history in parallel for performance optimization
    const [state, history] = await Promise.all([
      getCurrentState(),
      getHistory(),
    ]);

    const result: ContractResponse = {
      state,
      history,
      currentValue: state ? parseU64(state.value) : 0,
      lastUpdater: state ? state.lastUpdater : null,
    };

    console.log('All contract data retrieved successfully');
    return result;
  } catch (error) {
    console.error('Error fetching all contract data:', error);
    throw error;
  }
}

// ===== Utility Functions =====

/**
 * Format history data for beautiful display
 * @param {HistoryData[]} history - History data
 * @returns {string} Formatted string
 */
export function formatHistory(history: HistoryData[]): string {
  if (history.length === 0) {
    return 'No history available';
  }

  return history.map((entry, index) => {
    const timestamp = new Date().toISOString(); // Blockchain doesn't have timestamp, use current time
    return `${index + 1}. ID: ${entry.id} | ${entry.oldValue} → ${entry.newValue} | By: ${entry.updater} | ${timestamp}`;
  }).join('\n');
}

/**
 * Format state data for beautiful display
 * @param {StateData} state - State data
 * @returns {string} Formatted string
 */
export function formatState(state: StateData): string {
  return `Current State:
   Value: ${state.value}
   Last Updater: ${state.lastUpdater}
   Last History ID: ${state.lastHistoryId}`;
}

// ===== Example Usage =====

/**
 * Example usage of service
 */
export async function exampleUsage(): Promise<void> {
  try {
    console.log('Example: Fetching contract data...\n');

    // Get all information
    const allData = await getAllContractData();
    
    console.log('Contract Summary:');
    console.log(`   Current Value: ${allData.currentValue}`);
    console.log(`   Last Updater: ${allData.lastUpdater || 'None'}`);
    console.log(`   History Entries: ${allData.history.length}\n`);

    // Display state
    if (allData.state) {
      console.log(formatState(allData.state));
      console.log('');
    }

    // Display history
    console.log('History:');
    console.log(formatHistory(allData.history));

  } catch (error) {
    console.error('Example failed:', error);
  }
}

// ===== Export Default =====
export default {
  getCurrentState,
  getHistory,
  getLastUpdater,
  getCurrentValue,
  getAllContractData,
  formatHistory,
  formatState,
  exampleUsage,
};

// ===== CLI Support =====
if (require.main === module) {
  // Run example if file is executed directly
  exampleUsage().catch(console.error);
}
