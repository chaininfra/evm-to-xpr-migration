# Voting System Contract

A simple on-chain voting system built with proton-tsc for XPR Network. Users can create proposals, vote yes/no, and manage proposal lifecycle.

## Contract Overview

**Deployed on XPR Testnet**: `chaininfradv`

This contract implements basic voting functionality:
- Create proposals with title and description
- Cast yes/no votes on proposals
- One vote per user per proposal
- Close proposals to prevent further voting
- Delete proposals with their votes

## Data Structures

### Tables

#### `proposals`
| Field | Type | Description |
|-------|------|-------------|
| id | u64 | Auto-incrementing proposal ID |
| title | string | Proposal title (max 256 chars) |
| description | string | Detailed description (max 1024 chars) |
| creator | Name | Account that created the proposal |
| yesVotes | u64 | Number of affirmative votes |
| noVotes | u64 | Number of negative votes |
| isActive | boolean | Voting status (true = open, false = closed) |

#### `votes`
| Field | Type | Description |
|-------|------|-------------|
| id | u64 | Auto-incrementing vote ID |
| proposalId | u64 | Reference to proposal |
| voter | Name | Account that voted |
| voteChoice | boolean | Vote direction (true = yes, false = no) |

## Actions

### create
Create a new proposal.

```bash
proton action <contract> create '["<creator>", "<title>", "<description>"]' <creator>@active
```

**Parameters:**
- `creator` (Name): Account creating the proposal
- `title` (string): Proposal title (1-256 characters)
- `description` (string): Proposal description (1-1024 characters)

**Requirements:**
- Caller must have authority of `creator`
- Title and description must be within length limits

### vote
Cast a vote on an active proposal.

```bash
proton action <contract> vote '["<voter>", <proposalId>, <true|false>]' <voter>@active
```

**Parameters:**
- `voter` (Name): Account casting the vote
- `proposalId` (u64): ID of the proposal
- `voteChoice` (boolean): true for yes, false for no

**Requirements:**
- Caller must have authority of `voter`
- Proposal must exist and be active
- Voter must not have already voted on this proposal

### close
Close a proposal to prevent further voting.

```bash
proton action <contract> close '[<proposalId>, "<closer>"]' <closer>@active
```

**Parameters:**
- `proposalId` (u64): ID of the proposal
- `closer` (Name): Account closing the proposal

**Requirements:**
- Caller must be proposal creator or contract owner
- Proposal must exist and be active

### delete
Delete a proposal and all its votes.

```bash
proton action <contract> delete '[<proposalId>, "<deleter>"]' <deleter>@active
```

**Parameters:**
- `proposalId` (u64): ID of the proposal
- `deleter` (Name): Account deleting the proposal

**Requirements:**
- Caller must be proposal creator or contract owner
- Proposal must exist

### clear
Remove all proposals and votes from storage.

```bash
proton action <contract> clear '[]' <contract>@active
```

**Requirements:**
- Caller must be contract owner
- Use with caution - operation cannot be undone

## Querying Data

### Read proposals
```bash
curl -X POST https://testnet.protonchain.com/v1/chain/get_table_rows \
  -d '{
    "code": "<contract>",
    "scope": "<contract>",
    "table": "proposals",
    "json": true
  }'
```

### Read votes
```bash
curl -X POST https://testnet.protonchain.com/v1/chain/get_table_rows \
  -d '{
    "code": "<contract>",
    "scope": "<contract>",
    "table": "votes",
    "json": true
  }'
```

## Development

### Prerequisites
- Node.js >= 18
- proton-tsc
- XPR Network account with testnet tokens

### Build
```bash
npm install
npm run build
```

Output: `target/contract.wasm` and `target/contract.abi`

### Deploy
```bash
proton contract:set <account> target
```

### Clean
```bash
npm run clean
```

## Implementation Notes

### Auto-incrementing IDs
Uses `TableStore.availablePrimaryKey` to generate sequential IDs for proposals and votes.

### Duplicate Vote Prevention
The `hasUserVoted()` method iterates through all votes to check if a user has already voted on a proposal. For production systems with high vote volume, consider implementing a secondary index or separate lookup table for better performance.

### String Storage
XPR Network natively supports string types in table storage. No manual encoding to bytes is required.

### RAM Costs
Each row stored in a table consumes RAM from the payer account. The contract pays RAM costs for all stored data.

## Testing

The contract has been tested with the following scenarios:
- Creating multiple proposals
- Voting yes and no on proposals
- Preventing duplicate votes
- Closing proposals and blocking further votes
- Deleting proposals with cascading vote removal
- Reading data via API

Test results confirm data integrity and proper access control enforcement.

## Resources

- [XPR Network Docs](https://docs.xprnetwork.org/)
- [Contract SDK Storage](https://docs.xprnetwork.org/contract-sdk/storage.html)
- [Testnet Explorer](https://testnet.explorer.xprnetwork.org/)

## License

MIT

