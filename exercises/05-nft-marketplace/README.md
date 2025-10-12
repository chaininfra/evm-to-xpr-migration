# NFT Marketplace

NFT Marketplace on XPR Network using AtomicAssets contract for NFT management. This marketplace contract provides listing and trading functionality for AtomicAssets NFTs.

## Contract Overview

This contract provides marketplace functionality for AtomicAssets NFTs:
- List NFTs for sale with XPR pricing
- Buy NFTs from marketplace
- Unlist NFTs
- Query listings

NFTs are minted and managed by the AtomicAssets contract. This marketplace only handles the buying and selling logic.

## Contract Structure

### Table: `listings`

| Field | Type | Description |
|-------|------|-------------|
| assetId | u64 | AtomicAssets asset ID (primary key) |
| seller | Name | Account selling the NFT |
| price | Asset | Sale price (e.g., "50.0000 XPR") |
| listedAt | u64 | Timestamp when listed |

### Actions

#### `listforsale`
List an NFT on the marketplace.

```bash
proton action CONTRACT listforsale '{
  "seller":"ACCOUNT",
  "assetId":"ASSET_ID",
  "price":"50.0000 XPR"
}' ACCOUNT
```

**Parameters:**
- `seller` (Name): NFT owner account
- `assetId` (u64): AtomicAssets asset ID
- `price` (Asset): Sale price

**Requirements:**
- Caller must be the seller
- NFT must not already be listed
- Price must be greater than 0

#### `buynft`
Purchase an NFT from the marketplace.

```bash
proton action CONTRACT buynft '{
  "buyer":"BUYER_ACCOUNT",
  "assetId":"ASSET_ID"
}' BUYER_ACCOUNT
```

**Parameters:**
- `buyer` (Name): Buyer account
- `assetId` (u64): AtomicAssets asset ID

**Requirements:**
- NFT must be listed
- Buyer cannot be the seller

**Note:** This demo simulates payment. Production requires token transfer and NFT ownership transfer implementation.

#### `unlistnft`
Remove an NFT from the marketplace.

```bash
proton action CONTRACT unlistnft '{
  "seller":"ACCOUNT",
  "assetId":"ASSET_ID"
}' ACCOUNT
```

**Parameters:**
- `seller` (Name): Original seller account
- `assetId` (u64): AtomicAssets asset ID

**Requirements:**
- NFT must be listed
- Caller must be the original seller

#### `getlisting`
Query listing information.

```bash
proton action CONTRACT getlisting '{
  "assetId":"ASSET_ID"
}' ACCOUNT
```

#### `clear`
Clear all listings (contract owner only).

```bash
proton action CONTRACT clear '{}' CONTRACT
```

## Setup & Deploy

### 1. Build Contract

```bash
npm install
npm run build
```

Output: `target/contract.wasm` and `target/contract.abi`

### 2. Deploy Contract

```bash
proton contract:set YOUR_ACCOUNT ./target
```

### 3. Create AtomicAssets Collection

Collection name must be exactly 12 characters:

```bash
proton action atomicassets createcol '{
  "author":"YOUR_ACCOUNT",
  "collection_name":"mynftmkt1234",
  "allow_notify":true,
  "authorized_accounts":["YOUR_ACCOUNT"],
  "notify_accounts":[],
  "market_fee":0.05,
  "data":[
    {"key":"name","value":["string","My NFT Collection"]},
    {"key":"img","value":["string","IPFS_HASH"]},
    {"key":"description","value":["string","Collection description"]}
  ]
}' YOUR_ACCOUNT
```

### 4. Create Schema

Define NFT attributes:

```bash
proton action atomicassets createschema '{
  "authorized_creator":"YOUR_ACCOUNT",
  "collection_name":"mynftmkt1234",
  "schema_name":"nfts",
  "schema_format":[
    {"name":"name","type":"string"},
    {"name":"img","type":"string"},
    {"name":"description","type":"string"},
    {"name":"rarity","type":"string"}
  ]
}' YOUR_ACCOUNT
```

### 5. Mint NFT

```bash
proton action atomicassets mintasset '{
  "authorized_minter":"YOUR_ACCOUNT",
  "collection_name":"mynftmkt1234",
  "schema_name":"nfts",
  "template_id":-1,
  "new_asset_owner":"YOUR_ACCOUNT",
  "immutable_data":[
    {"key":"name","value":["string","My NFT"]},
    {"key":"img","value":["string","IPFS_HASH"]},
    {"key":"description","value":["string","NFT description"]},
    {"key":"rarity","value":["string","Rare"]}
  ],
  "mutable_data":[],
  "tokens_to_back":[]
}' YOUR_ACCOUNT
```

Save the `asset_id` from the transaction output.

### 6. List NFT on Marketplace

```bash
proton action YOUR_ACCOUNT listforsale '{
  "seller":"YOUR_ACCOUNT",
  "assetId":"ASSET_ID",
  "price":"50.0000 XPR"
}' YOUR_ACCOUNT
```

## Query Data

### Check Your NFTs

```bash
proton table atomicassets assets YOUR_ACCOUNT
```

### Check Marketplace Listings

```bash
proton table YOUR_ACCOUNT listings YOUR_ACCOUNT
```

### Check Collection Info

```bash
proton table atomicassets collections atomicassets | grep COLLECTION_NAME
```

### Check Schema

```bash
proton table atomicassets schemas COLLECTION_NAME
```

## IPFS Images

For NFTs to display images in wallets and explorers, upload images to IPFS and use the real IPFS hash when minting.

### IPFS Upload Services:
- **Pinata:** https://pinata.cloud (free tier available)
- **NFT.Storage:** https://nft.storage (free for NFTs)

### Process:
1. Upload your image to IPFS service
2. Get the IPFS hash (CID), e.g., `QmPbxeGcXhYQQNgsC6a36dDyYUcHgMLnGKnF8pVFmGsvqi`
3. Use this hash in the `img` field when minting

**Important:** Fake or invalid IPFS hashes may prevent NFTs from displaying in wallets.

## Demo Deployment

Contract deployed and tested on testnet:

- **Account:** `chaininfradv`
- **Collection:** `chaininfmkt1`
- **Schema:** `nfts`
- **NFTs Minted:** 5

### Verify Demo

```bash
# Check NFTs
proton table atomicassets assets chaininfradv

# Check listings
proton table chaininfradv listings chaininfradv
```

### View on Explorer

**Account NFTs:**
```
https://testnet.nft.xprnetwork.org/chaininfradv
```

**Collection:**
```
https://testnet.nft.xprnetwork.org/collection/chaininfmkt1
```

## Complete Example Workflow

```bash
# 1. Build and deploy marketplace
npm run build
proton contract:set myaccount ./target

# 2. Create collection (must be 12 chars)
proton action atomicassets createcol '{
  "author":"myaccount",
  "collection_name":"mynftmkt1234",
  "allow_notify":true,
  "authorized_accounts":["myaccount"],
  "notify_accounts":[],
  "market_fee":0.05,
  "data":[
    {"key":"name","value":["string","My NFT Market"]},
    {"key":"img","value":["string","QmHash..."]},
    {"key":"description","value":["string","Description"]}
  ]
}' myaccount

# 3. Create schema
proton action atomicassets createschema '{
  "authorized_creator":"myaccount",
  "collection_name":"mynftmkt1234",
  "schema_name":"nfts",
  "schema_format":[
    {"name":"name","type":"string"},
    {"name":"img","type":"string"},
    {"name":"description","type":"string"}
  ]
}' myaccount

# 4. Upload image to IPFS → get hash: QmRealHash...

# 5. Mint NFT with real IPFS hash
proton action atomicassets mintasset '{
  "authorized_minter":"myaccount",
  "collection_name":"mynftmkt1234",
  "schema_name":"nfts",
  "template_id":-1,
  "new_asset_owner":"myaccount",
  "immutable_data":[
    {"key":"name","value":["string","Dragon Warrior"]},
    {"key":"img","value":["string","QmRealHash..."]},
    {"key":"description","value":["string","A legendary warrior"]}
  ],
  "mutable_data":[],
  "tokens_to_back":[]
}' myaccount
# Output: asset_id = 4398046587270

# 6. List NFT on marketplace
proton action myaccount listforsale '{
  "seller":"myaccount",
  "assetId":"4398046587270",
  "price":"50.0000 XPR"
}' myaccount

# 7. Verify listing
proton table myaccount listings myaccount

# 8. Check on NFT explorer
# https://testnet.nft.xprnetwork.org/myaccount

# 9. Buy NFT (from another account)
proton action myaccount buynft '{
  "buyer":"otheraccount",
  "assetId":"4398046587270"
}' otheraccount

# 10. Unlist NFT (alternative to buying)
proton action myaccount unlistnft '{
  "seller":"myaccount",
  "assetId":"4398046587270"
}' myaccount
```

## Production TODOs

This contract is a demo version. For production deployment, implement:

### 1. Token Payment Integration

Transfer XPR from buyer to seller:

```typescript
import { sendTransferTokens } from "proton-tsc";

// In buynft action
sendTransferTokens(
  buyer,
  listing.seller,
  [listing.price],
  "NFT Purchase"
);
```

### 2. NFT Ownership Transfer

Automatically transfer NFT when purchased:

```typescript
import { InlineAction, PermissionLevel } from "proton-tsc";

// Call atomicassets::transfer
const transferAction = new InlineAction("transfer");
transferAction.act(
  Name.fromString("atomicassets"),
  new PermissionLevel(listing.seller)
);

transferAction.send({
  from: listing.seller,
  to: buyer,
  asset_ids: [assetId],
  memo: "Marketplace Sale"
});
```

### 3. Ownership Verification

Verify seller owns the NFT before listing:

```typescript
// Read from AtomicAssets assets table
const assetsTable = new TableStore<Asset>(
  Name.fromString("atomicassets"),
  seller
);

const asset = assetsTable.get(assetId);
check(asset != null, "Seller doesn't own this NFT");
```

### 4. Additional Features

- Marketplace fees
- Royalty payments to original creators
- Offer/bidding system
- Auction functionality
- Escrow mechanism

## Security

Contract implements the following security measures:

- **Authorization:** `requireAuth()` on all state-changing actions
- **Ownership checks:** Only seller can unlist their NFTs
- **Duplicate prevention:** Cannot list same NFT twice
- **Self-purchase prevention:** Buyers cannot purchase their own NFTs
- **Price validation:** Prices must be positive values

## Testing

### Manual Testing

```bash
# Deploy and setup
npm run build
proton contract:set testaccount ./target

# Create collection and schema
# (see Setup section)

# Mint test NFT
proton action atomicassets mintasset '{...}' testaccount

# Test list
proton action testaccount listforsale '{...}' testaccount

# Verify
proton table testaccount listings testaccount

# Test unlist
proton action testaccount unlistnft '{...}' testaccount

# Verify removed
proton table testaccount listings testaccount
```

## Resources

### Documentation
- [XPR Network Documentation](https://docs.xprnetwork.org/)
- [Contract SDK - Storage](https://docs.xprnetwork.org/contract-sdk/storage.html)
- [Contract SDK - Security](https://docs.xprnetwork.org/contract-sdk/security.html)

### Explorers & Tools
- [XPR NFT Marketplace](https://testnet.nft.xprnetwork.org/) - Testnet NFT explorer
- [XPR Blockchain Explorer](https://testnet.explorer.xprnetwork.org/) - Testnet blockchain explorer
- [Pinata](https://pinata.cloud/) - IPFS pinning service
- [NFT.Storage](https://nft.storage/) - Free NFT storage

### Standards
- [AtomicAssets GitHub](https://github.com/pinknetworkx/atomicassets-contract)
- [AtomicAssets API](https://github.com/pinknetworkx/eosio-contract-api-docs)

## License

MIT
