# Theory: NFT Marketplace with AtomicAssets

## Learning Objectives
- Understand AtomicAssets standard integration
- Master marketplace listing and buying mechanics
- Understand NFT ownership and transfer patterns
- Practice security in NFT marketplace contracts
- Learn about IPFS and NFT metadata standards

## Prerequisites
- Completed Voting System contract
- Understanding of TableStore and storage
- Basic blockchain concepts
- Familiarity with XPR Network CLI

## 1. NFT Standards Overview

### 1.1 What is AtomicAssets?

AtomicAssets is the NFT standard widely used on XPR Network and other EOSIO-based blockchains.

**Key Features:**
- NFT ownership management
- On-chain metadata storage
- Transfer mechanisms
- Collection and schema system
- Compatible with all wallets and explorers

**Architecture:**
```
AtomicAssets Contract
├── Collections (grouping, ownership, fees)
├── Schemas (attribute definitions)
├── Templates (reusable NFT patterns)
└── Assets (individual NFT instances)
```

### 1.2 Marketplace Integration Pattern

The marketplace contract does NOT create or store NFTs. It only references NFTs from AtomicAssets:

```typescript
@table("listings")
export class Listing extends Table {
    constructor(
        public assetId: u64 = 0,        // References AtomicAssets NFT
        public seller: Name = new Name(),
        public price: Asset = new Asset(),
        public listedAt: u64 = 0
    ) { super(); }
    
    @primary
    get primary(): u64 {
        return this.assetId;
    }
}
```

**Separation of Concerns:**
- **NFT data:** Stored in AtomicAssets contract
- **Marketplace data:** Stored in marketplace contract

This separation ensures:
- NFTs visible in all wallets
- Marketplace can be upgraded independently
- NFTs can be traded on multiple marketplaces

## 2. AtomicAssets Operations

### 2.1 Creating a Collection

A collection is a container for related NFTs:

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
    {"key":"description","value":["string","Description"]}
  ]
}' YOUR_ACCOUNT
```

**Parameters Explained:**
- `author`: Collection creator (cannot be changed)
- `collection_name`: Exactly 12 characters (a-z, 1-5)
- `authorized_accounts`: Accounts allowed to mint NFTs
- `market_fee`: Marketplace fee percentage (0.05 = 5%)
- `data`: Collection metadata (name, img, description)

### 2.2 Creating a Schema

A schema defines what attributes NFTs can have:

```bash
proton action atomicassets createschema '{
  "authorized_creator":"YOUR_ACCOUNT",
  "collection_name":"mynftmkt1234",
  "schema_name":"nfts",
  "schema_format":[
    {"name":"name","type":"string"},
    {"name":"img","type":"string"},
    {"name":"description","type":"string"},
    {"name":"power","type":"uint32"},
    {"name":"rarity","type":"string"}
  ]
}' YOUR_ACCOUNT
```

**Common Attribute Types:**
- `string`: Text data
- `uint32`, `uint64`: Unsigned integers
- `int32`, `int64`: Signed integers
- `float`, `double`: Decimal numbers
- `ipfs`: IPFS hash type

### 2.3 Minting NFTs

Mint an NFT through AtomicAssets:

```bash
proton action atomicassets mintasset '{
  "authorized_minter":"YOUR_ACCOUNT",
  "collection_name":"mynftmkt1234",
  "schema_name":"nfts",
  "template_id":-1,
  "new_asset_owner":"OWNER_ACCOUNT",
  "immutable_data":[
    {"key":"name","value":["string","Dragon Warrior"]},
    {"key":"img","value":["string","QmIPFSHash..."]},
    {"key":"description","value":["string","A legendary warrior"]},
    {"key":"power","value":["uint32",9500]},
    {"key":"rarity","value":["string","Legendary"]}
  ],
  "mutable_data":[],
  "tokens_to_back":[]
}' YOUR_ACCOUNT
```

**Data Types:**
- `immutable_data`: Cannot be changed after minting
- `mutable_data`: Can be updated by authorized accounts
- `tokens_to_back`: XPR tokens to back the NFT (optional)
- `template_id`: -1 for no template, or specific template ID

## 3. Marketplace Operations

### 3.1 Listing NFTs

```typescript
@action("listforsale")
listForSale(seller: Name, assetId: u64, price: Asset): void {
    requireAuth(seller);
    
    // Validate
    check(price.amount > 0, "Price must be greater than 0");
    check(!this.listingsTable.exists(assetId), "Already listed");
    
    // Create listing
    const listing = new Listing(assetId, seller, price, 0);
    this.listingsTable.store(listing, this.receiver);
    
    print(`NFT ${assetId} listed at ${price}`);
}
```

**Security Checks:**
- Seller authorization required
- Price validation
- Duplicate prevention
- Contract pays RAM for listing storage

### 3.2 Buying NFTs

```typescript
@action("buynft")
buyNFT(buyer: Name, assetId: u64): void {
    requireAuth(buyer);
    
    const listing = this.listingsTable.get(assetId);
    check(listing != null, "Not listed");
    
    if (listing) {
        check(listing.seller != buyer, "Cannot buy own NFT");
        
        // Remove listing
        this.listingsTable.remove(listing);
        
        print(`Sold to ${buyer} for ${listing.price}`);
    }
}
```

**Production Requirements:**
1. Transfer XPR tokens: buyer → seller
2. Transfer NFT ownership: seller → buyer (via AtomicAssets)
3. Calculate and transfer marketplace fees
4. Verify seller still owns the NFT

### 3.3 Unlisting NFTs

```typescript
@action("unlistnft")
unlistNFT(seller: Name, assetId: u64): void {
    requireAuth(seller);
    
    const listing = this.listingsTable.get(assetId);
    check(listing != null, "Not listed");
    
    if (listing) {
        check(listing.seller == seller, "Only seller can unlist");
        
        this.listingsTable.remove(listing);
        
        print(`NFT ${assetId} unlisted`);
    }
}
```

## 4. IPFS Integration

### 4.1 Why IPFS for NFTs?

IPFS (InterPlanetary File System) provides:
- **Decentralized storage:** No single point of failure
- **Content addressing:** Files identified by hash, not location
- **Immutability:** Content hash changes if file changes
- **Cost-effective:** Cheaper than on-chain storage for images

### 4.2 IPFS Upload Workflow

```
1. Prepare image file (PNG, JPG, GIF, etc.)
   ↓
2. Upload to IPFS service
   - Pinata.cloud
   - NFT.Storage
   - IPFS node
   ↓
3. Receive IPFS hash (CID)
   Example: QmPbxeGcXhYQQNgsC6a36dDyYUcHgMLnGKnF8pVFmGsvqi
   ↓
4. Use hash in NFT metadata
   {"key":"img","value":["string","QmPbxeGcXh..."]}
   ↓
5. Image accessible via IPFS gateways
   https://ipfs.io/ipfs/QmPbxeGcXh...
```

### 4.3 IPFS Best Practices

**✅ Correct:**
```typescript
// Real IPFS hash from upload
{"key":"img","value":["string","QmPbxeGcXhYQQNgsC6a36dDyYUcHgMLnGKnF8pVFmGsvqi"]}
```

**❌ Incorrect:**
```typescript
// Fake/placeholder hash - NFT won't display properly
{"key":"img","value":["string","QmFakeHash123..."]}
```

**Impact:**
- ✅ Real IPFS: NFT displays in wallets and explorers
- ❌ Fake IPFS: NFT may be hidden or show broken image

## 5. Security Patterns

### 5.1 Authorization Checks

```typescript
// Always require authorization for state changes
@action("myaction")
myAction(account: Name): void {
    requireAuth(account);  // Verify caller has permission
    
    // ... action logic
}
```

### 5.2 State Validation

```typescript
// Validate all state before operations
@action("buynft")
buyNFT(buyer: Name, assetId: u64): void {
    requireAuth(buyer);
    
    // Check existence
    const listing = this.listingsTable.get(assetId);
    check(listing != null, "NFT is not listed for sale");
    
    // Check business logic
    check(listing.seller != buyer, "Cannot buy your own NFT");
    
    // ... proceed with purchase
}
```

### 5.3 Preventing Duplicate Operations

```typescript
// Check before storing
check(!this.listingsTable.exists(assetId), "NFT is already listed for sale");
```

### 5.4 Ownership Verification (Production Pattern)

```typescript
// Read AtomicAssets table to verify ownership
import { TableStore } from "proton-tsc";

// In listforsale action
const atomicassets = Name.fromString("atomicassets");
const assetsTable = new TableStore<Asset>(atomicassets, seller);

const asset = assetsTable.get(assetId);
check(asset != null, "NFT doesn't exist");
check(asset.owner == seller, "Seller doesn't own this NFT");
```

## 6. Querying Data

### 6.1 Query NFTs from AtomicAssets

```bash
# All NFTs owned by account
proton table atomicassets assets ACCOUNT_NAME

# Count NFTs
proton table atomicassets assets ACCOUNT_NAME | grep asset_id | wc -l

# Specific collection only
proton table atomicassets assets ACCOUNT_NAME | grep COLLECTION_NAME
```

### 6.2 Query Marketplace Listings

```bash
# All listings
proton table MARKETPLACE_CONTRACT listings MARKETPLACE_CONTRACT

# Via action (prints to console)
proton action MARKETPLACE_CONTRACT getlisting '{"assetId":"ASSET_ID"}' ACCOUNT
```

### 6.3 Query Collections and Schemas

```bash
# All collections
proton table atomicassets collections atomicassets

# Specific collection
proton table atomicassets collections atomicassets | grep -A 5 "COLLECTION_NAME"

# Schemas in collection
proton table atomicassets schemas COLLECTION_NAME
```

### 6.4 AtomicAssets API Queries

```bash
# Get NFTs by owner
curl "https://test.proton.api.atomicassets.io/atomicassets/v1/assets?owner=ACCOUNT"

# Get specific NFT
curl "https://test.proton.api.atomicassets.io/atomicassets/v1/assets/ASSET_ID"

# Get collection info
curl "https://test.proton.api.atomicassets.io/atomicassets/v1/collections/COLLECTION_NAME"
```

## 7. Common Patterns

### 7.1 Marketplace Fee Calculation

```typescript
/**
 * Calculate and distribute marketplace fees
 */
@action("buynft")
buyNFT(buyer: Name, assetId: u64): void {
    const listing = this.listingsTable.get(assetId);
    
    // Calculate fee (e.g., 2.5%)
    const feePercent = 25; // 2.5% = 25/1000
    const feeAmount = listing.price.amount * feePercent / 1000;
    const sellerAmount = listing.price.amount - feeAmount;
    
    // Create fee asset
    const sellerPrice = new Asset(sellerAmount, listing.price.symbol);
    const marketplaceFee = new Asset(feeAmount, listing.price.symbol);
    
    // Transfer to seller
    sendTransferTokens(buyer, listing.seller, [sellerPrice], "NFT Sale");
    
    // Transfer fee to marketplace
    sendTransferTokens(buyer, this.receiver, [marketplaceFee], "Marketplace Fee");
}
```

### 7.2 Batch Operations

```typescript
/**
 * List multiple NFTs at once
 */
@action("batchlist")
batchList(
    seller: Name,
    assetIds: u64[],
    prices: Asset[]
): void {
    requireAuth(seller);
    
    // Validate arrays match
    check(assetIds.length == prices.length, "Arrays must have same length");
    check(assetIds.length > 0, "Must list at least one NFT");
    
    // List each NFT
    for (let i = 0; i < assetIds.length; i++) {
        this.listForSale(seller, assetIds[i], prices[i]);
    }
    
    print(`Batch listed ${assetIds.length} NFTs`);
}
```

### 7.3 Price Update

```typescript
/**
 * Update price of listed NFT
 */
@action("updateprice")
updatePrice(
    seller: Name,
    assetId: u64,
    newPrice: Asset
): void {
    requireAuth(seller);
    
    const listing = this.listingsTable.get(assetId);
    check(listing != null, "NFT is not listed");
    
    if (listing) {
        check(listing.seller == seller, "Only seller can update price");
        check(newPrice.amount > 0, "Price must be positive");
        
        // Update price
        listing.price = newPrice;
        this.listingsTable.update(listing, this.receiver);
        
        print(`Price updated to ${newPrice} for NFT ${assetId}`);
    }
}
```

### 7.4 Query Helper

```typescript
/**
 * Get listing details (read-only)
 */
@action("getlisting")
getListing(assetId: u64): void {
    const listing = this.listingsTable.get(assetId);
    
    if (listing) {
        print(`Asset ID: ${listing.assetId}`);
        print(`Seller: ${listing.seller}`);
        print(`Price: ${listing.price}`);
        print(`Listed At: ${listing.listedAt}`);
    } else {
        print(`No listing found for asset ${assetId}`);
    }
}
```

## 8. Production Enhancements

### 8.1 Token Transfer Integration

```typescript
import { sendTransferTokens } from "proton-tsc";

@action("buynft")
buyNFT(buyer: Name, assetId: u64): void {
    // ... validation logic
    
    // Transfer XPR from buyer to seller
    sendTransferTokens(
        buyer,              // from
        listing.seller,     // to
        [listing.price],    // amounts array
        "NFT Purchase"      // memo
    );
    
    // ... continue with transfer and cleanup
}
```

### 8.2 NFT Transfer Integration

```typescript
import { InlineAction, PermissionLevel } from "proton-tsc";

@action("buynft")
buyNFT(buyer: Name, assetId: u64): void {
    // ... payment logic
    
    // Transfer NFT via AtomicAssets
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
    
    // ... cleanup
}
```

### 8.3 Ownership Verification

```typescript
@action("listforsale")
listForSale(seller: Name, assetId: u64, price: Asset): void {
    requireAuth(seller);
    
    // Read AtomicAssets table to verify ownership
    const atomicassets = Name.fromString("atomicassets");
    const assetsTable = new TableStore<Asset>(atomicassets, seller);
    
    const asset = assetsTable.get(assetId);
    check(asset != null, "Asset doesn't exist");
    check(asset.owner == seller, "Seller doesn't own this NFT");
    
    // ... proceed with listing
}
```

### 8.4 Escrow Pattern (Advanced)

```typescript
/**
 * Lock NFT in escrow when listed
 */
@action("listforsale")
listForSale(seller: Name, assetId: u64, price: Asset): void {
    requireAuth(seller);
    
    // Transfer NFT to marketplace for escrow
    const transferAction = new InlineAction("transfer");
    transferAction.act(
        Name.fromString("atomicassets"),
        new PermissionLevel(seller)
    );
    
    transferAction.send({
        from: seller,
        to: this.receiver,  // Marketplace holds NFT
        asset_ids: [assetId],
        memo: "Marketplace Escrow"
    });
    
    // Create listing
    // ...
}

/**
 * Release from escrow when purchased or unlisted
 */
@action("buynft")
buyNFT(buyer: Name, assetId: u64): void {
    // ... payment logic
    
    // Transfer from escrow to buyer
    const transferAction = new InlineAction("transfer");
    transferAction.act(
        Name.fromString("atomicassets"),
        new PermissionLevel(this.receiver)
    );
    
    transferAction.send({
        from: this.receiver,  // From escrow
        to: buyer,
        asset_ids: [assetId],
        memo: "Purchase Complete"
    });
}
```

## 9. Testing Strategies

### 9.1 Manual Testing Workflow

```bash
# 1. Setup
npm run build
proton contract:set testaccount ./target

# 2. Create infrastructure
proton action atomicassets createcol '{...}' testaccount
proton action atomicassets createschema '{...}' testaccount

# 3. Upload image to IPFS
# Get hash: QmRealIPFSHash...

# 4. Mint test NFT
proton action atomicassets mintasset '{
  "immutable_data":[
    {"key":"img","value":["string","QmRealIPFSHash..."]}
  ]
}' testaccount
# Output: asset_id = 4398046587270

# 5. Test list
proton action testaccount listforsale '{
  "seller":"testaccount",
  "assetId":"4398046587270",
  "price":"50.0000 XPR"
}' testaccount

# 6. Verify listing exists
proton table testaccount listings testaccount

# 7. Test unlist
proton action testaccount unlistnft '{
  "seller":"testaccount",
  "assetId":"4398046587270"
}' testaccount

# 8. Verify listing removed
proton table testaccount listings testaccount

# 9. Re-list for buy test
proton action testaccount listforsale '{...}' testaccount

# 10. Test buy (from different account)
proton action testaccount buynft '{
  "buyer":"anotheraccount",
  "assetId":"4398046587270"
}' anotheraccount

# 11. Verify listing removed
proton table testaccount listings testaccount

# 12. Verify NFT in explorer
# https://testnet.nft.xprnetwork.org/asset/4398046587270
```

### 9.2 Verification Checklist

- [ ] Collection created successfully
- [ ] Schema created with correct attributes
- [ ] NFT minted with valid IPFS hash
- [ ] NFT visible in blockchain query
- [ ] NFT visible on NFT explorer
- [ ] Listing created successfully
- [ ] Only seller can unlist
- [ ] Buyer cannot be seller
- [ ] Cannot list same NFT twice
- [ ] Listing removed after unlist/buy
- [ ] NFT displays in wallet (with real IPFS image)

## 10. Best Practices

### 10.1 ✅ DO

- **Use AtomicAssets** for NFT management (standard compatibility)
- **Upload to IPFS** before minting (real images)
- **Verify IPFS accessibility** (test image loads)
- **Test on testnet** before mainnet deployment
- **Implement authorization** on all actions
- **Validate all inputs** (price, asset existence, etc.)
- **Handle edge cases** (self-purchase, duplicate listings)
- **Document your code** (clear JSDoc comments)
- **Use blockchain query** to verify (not just UI)

### 10.2 ❌ DON'T

- **Don't use fake IPFS hashes** in production
- **Don't skip ownership verification** in production
- **Don't allow self-purchase** (security risk)
- **Don't forget marketplace fees** (revenue model)
- **Don't deploy without testing** (test thoroughly first)
- **Don't ignore security checks** (authorization, validation)
- **Don't rely only on UI** for verification (use blockchain query)

## 11. Common Issues & Solutions

### Issue: NFT not showing in wallet

**Solution:**
1. Verify NFT exists on blockchain:
   ```bash
   proton table atomicassets assets YOUR_ACCOUNT
   ```
2. Check IPFS image is real and accessible
3. View on NFT explorer (usually instant)
4. Wait 5-30 minutes for wallet indexing on testnet

### Issue: "Collection name must be 12 characters"

**Solution:** Use exactly 12 characters: `mynftmkt1234` ✅

### Issue: "Missing authority"

**Solution:** Ensure you use the correct account permission in commands.

### Issue: "NFT is already listed"

**Solution:** Check listings table and unlist first:
```bash
proton table CONTRACT listings CONTRACT
```

## 12. Resources

### Documentation
- [XPR Network Docs](https://docs.xprnetwork.org/)
- [Contract SDK - Storage](https://docs.xprnetwork.org/contract-sdk/storage.html)
- [Contract SDK - Inline Actions](https://docs.xprnetwork.org/contract-sdk/inline-actions.html)
- [Contract SDK - Security](https://docs.xprnetwork.org/contract-sdk/security.html)

### Tools & Services
- [Pinata](https://pinata.cloud/) - IPFS pinning service
- [NFT.Storage](https://nft.storage/) - Free NFT storage
- [XPR NFT Explorer](https://nft.xprnetwork.org/) - NFT marketplace and explorer

### Standards & References
- [AtomicAssets GitHub](https://github.com/pinknetworkx/atomicassets-contract)
- [AtomicAssets API Docs](https://github.com/pinknetworkx/eosio-contract-api-docs)
- [IPFS Documentation](https://docs.ipfs.io/)

---

**Key Takeaway**: NFT marketplaces on XPR Network integrate with the AtomicAssets standard to ensure ecosystem compatibility. The marketplace contract focuses on trading logic, while NFT management is handled by AtomicAssets.
