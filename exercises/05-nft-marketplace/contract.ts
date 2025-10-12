import { Contract, Name, Table, TableStore, Asset, check, print, requireAuth, EMPTY_NAME } from "proton-tsc";

/**
 * Marketplace Listing Table
 * 
 * Stores AtomicAssets NFTs that are currently listed for sale on the marketplace.
 * Each listing references an NFT by its AtomicAssets asset ID.
 * 
 * @table listings
 * @description Table structure for marketplace listings
 */
@table("listings")
export class Listing extends Table {
  /**
   * Creates a new marketplace listing
   * 
   * @param {u64} assetId - AtomicAssets asset ID (primary key)
   * @param {Name} seller - Account name of the seller
   * @param {Asset} price - Sale price (e.g., "50.0000 XPR")
   * @param {u64} listedAt - Unix timestamp when listing was created
   */
  constructor(
    public assetId: u64 = 0,
    public seller: Name = new Name(),
    public price: Asset = new Asset(),
    public listedAt: u64 = 0
  ) {
    super();
  }

  /**
   * Primary key getter
   * 
   * @returns {u64} The asset ID used as primary key
   */
  @primary
  get primary(): u64 {
    return this.assetId;
  }
}

/**
 * NFT Marketplace Smart Contract
 * 
 * A decentralized NFT marketplace that integrates with the AtomicAssets standard
 * on XPR Network. This contract provides functionality for listing, buying, and
 * unlisting NFTs.
 * 
 * ## Key Features:
 * - List AtomicAssets NFTs for sale with XPR pricing
 * - Buy NFTs from marketplace (with simulated payment in demo)
 * - Unlist NFTs from marketplace
 * - Query marketplace listings
 * - Track all active listings
 * 
 * ## Integration:
 * This contract does NOT manage NFT ownership directly. All NFTs are managed by
 * the AtomicAssets contract, ensuring compatibility with:
 * - WebAuth wallet
 * - AtomicHub explorer
 * - All XPR Network NFT-compatible applications
 * 
 * ## Architecture:
 * ```
 * AtomicAssets Contract (NFT ownership & metadata)
 *          ↕ Query & Reference
 * Marketplace Contract (listing & trading logic)
 * ```
 * 
 * @contract
 * @author XPR Network
 * @version 1.0.0
 */
@contract
export class NFTMarketplace extends Contract {
  /**
   * Table store for marketplace listings
   * 
   * @type {TableStore<Listing>}
   * @description Stores all active NFT listings on the marketplace
   */
  listingsTable: TableStore<Listing> = new TableStore<Listing>(this.receiver);

  /**
   * List NFT for Sale
   * 
   * Lists an AtomicAssets NFT on the marketplace at a specified price.
   * The seller must own the NFT in AtomicAssets contract.
   * 
   * ## Requirements:
   * - Caller must be the seller (authorization required)
   * - NFT must not already be listed
   * - Price must be greater than 0
   * 
   * ## Security:
   * - Requires seller authorization via `requireAuth()`
   * - Validates price is positive
   * - Prevents duplicate listings
   * 
   * ## Production TODO:
   * - Verify seller owns the NFT by reading AtomicAssets tables:
   *   ```typescript
   *   const assetsTable = new TableStore<Asset>(atomicassets, seller);
   *   const asset = assetsTable.get(assetId);
   *   check(asset != null, "Seller doesn't own this NFT");
   *   ```
   * 
   * ## Example Usage:
   * ```bash
   * proton action marketplace listforsale '{
   *   "seller":"alice",
   *   "assetId":"4398046587270",
   *   "price":"50.0000 XPR"
   * }' alice@active
   * ```
   * 
   * @action listforsale
   * @param {Name} seller - Account name of the NFT owner
   * @param {u64} assetId - AtomicAssets asset ID to list
   * @param {Asset} price - Sale price (must be positive, e.g., "10.0000 XPR")
   * @throws {Error} "Price must be greater than 0" if price is invalid
   * @throws {Error} "NFT is already listed for sale" if duplicate listing
   * @returns {void}
   */
  @action("listforsale")
  listForSale(
    seller: Name,
    assetId: u64,
    price: Asset
  ): void {
    // Require authorization from seller
    requireAuth(seller);

    // Validate price is positive
    check(price.amount > 0, "Price must be greater than 0");

    // Prevent duplicate listings
    check(!this.listingsTable.exists(assetId), "NFT is already listed for sale");

    // TODO: In production, verify seller owns the asset by reading:
    // atomicassets::assets table with scope = seller
    // For this demo, we trust the authorization

    // Create new listing
    const listing = new Listing(
      assetId,
      seller,
      price,
      0 // TODO: Add current_time_point() when available
    );

    // Store listing (contract pays RAM)
    this.listingsTable.store(listing, this.receiver);

    // Log listing creation
    print(`NFT ${assetId} listed for sale by ${seller} at ${price}`);
  }

  /**
   * Buy NFT from Marketplace
   * 
   * Purchases a listed NFT from the marketplace. In this demo version,
   * the payment and NFT transfer are simulated and must be implemented
   * for production use.
   * 
   * ## Requirements:
   * - Caller must be the buyer (authorization required)
   * - NFT must be listed for sale
   * - Buyer cannot be the seller (prevent self-purchase)
   * 
   * ## Security:
   * - Requires buyer authorization via `requireAuth()`
   * - Verifies listing exists
   * - Prevents self-purchase
   * 
   * ## Production TODO:
   * Implement actual payment and NFT transfer:
   * 
   * ### 1. Transfer XPR Payment (buyer → seller):
   * ```typescript
   * import { sendTransferTokens } from "proton-tsc";
   * 
   * sendTransferTokens(
   *   buyer,              // from
   *   listing.seller,     // to
   *   [listing.price],    // amounts
   *   "NFT Purchase"      // memo
   * );
   * ```
   * 
   * ### 2. Transfer NFT Ownership (seller → buyer):
   * ```typescript
   * const transferAction = new InlineAction("transfer");
   * transferAction.act(
   *   Name.fromString("atomicassets"),
   *   new PermissionLevel(listing.seller)
   * );
   * 
   * transferAction.send({
   *   from: listing.seller,
   *   to: buyer,
   *   asset_ids: [assetId],
   *   memo: "Marketplace Sale"
   * });
   * ```
   * 
   * ## Example Usage:
   * ```bash
   * proton action marketplace buynft '{
   *   "buyer":"bob",
   *   "assetId":"4398046587270"
   * }' bob@active
   * ```
   * 
   * @action buynft
   * @param {Name} buyer - Account name of the buyer
   * @param {u64} assetId - AtomicAssets asset ID to purchase
   * @throws {Error} "NFT is not listed for sale" if listing doesn't exist
   * @throws {Error} "Cannot buy your own NFT" if buyer is seller
   * @returns {void}
   */
  @action("buynft")
  buyNFT(
    buyer: Name,
    assetId: u64
  ): void {
    // Require authorization from buyer
    requireAuth(buyer);

    // Get listing from table
    const listing = this.listingsTable.get(assetId);
    check(listing != null, "NFT is not listed for sale");

    if (listing) {
      // Prevent self-purchase
      check(listing.seller != buyer, "Cannot buy your own NFT");

      // TODO: In production, integrate with:
      // 1. XPR Token contract to transfer payment
      //    sendTransferTokens(buyer, listing.seller, [listing.price], "NFT Purchase");
      // 
      // 2. AtomicAssets contract to transfer NFT
      //    Action: atomicassets::transfer
      //    Parameters: {from: seller, to: buyer, asset_ids: [assetId], memo: "Marketplace Sale"}

      // Remove listing from marketplace
      this.listingsTable.remove(listing);

      // Log successful purchase
      print(`NFT ${assetId} sold to ${buyer} for ${listing.price}. Payment and transfer would happen here.`);
    }
  }

  /**
   * Unlist NFT from Marketplace
   * 
   * Removes a listing from the marketplace without selling the NFT.
   * Only the original seller can unlist their NFT.
   * 
   * ## Requirements:
   * - Caller must be the seller (authorization required)
   * - NFT must be listed
   * - Only the original seller can unlist
   * 
   * ## Security:
   * - Requires seller authorization via `requireAuth()`
   * - Verifies listing exists
   * - Ensures only original seller can unlist
   * 
   * ## Example Usage:
   * ```bash
   * proton action marketplace unlistnft '{
   *   "seller":"alice",
   *   "assetId":"4398046587270"
   * }' alice@active
   * ```
   * 
   * @action unlistnft
   * @param {Name} seller - Account name of the seller who listed the NFT
   * @param {u64} assetId - AtomicAssets asset ID to unlist
   * @throws {Error} "NFT is not listed for sale" if listing doesn't exist
   * @throws {Error} "Only seller can unlist NFT" if caller is not the original seller
   * @returns {void}
   */
  @action("unlistnft")
  unlistNFT(
    seller: Name,
    assetId: u64
  ): void {
    // Require authorization from seller
    requireAuth(seller);

    // Get listing from table
    const listing = this.listingsTable.get(assetId);
    check(listing != null, "NFT is not listed for sale");

    if (listing) {
      // Verify caller is the original seller
      check(listing.seller == seller, "Only seller can unlist NFT");

      // Remove listing from marketplace
      this.listingsTable.remove(listing);

      // Log successful unlisting
      print(`NFT ${assetId} unlisted by ${seller}`);
    }
  }

  /**
   * Get Listing Details
   * 
   * Retrieves and displays information about a specific marketplace listing.
   * This is a read-only action that doesn't modify contract state.
   * 
   * ## Output:
   * Prints listing details to console:
   * - Asset ID
   * - Seller account
   * - Price
   * - Listed timestamp
   * 
   * ## Example Usage:
   * ```bash
   * proton action marketplace getlisting '{
   *   "assetId":"4398046587270"
   * }' alice@active
   * ```
   * 
   * ## Alternative Query Method:
   * You can also query listings directly via table:
   * ```bash
   * proton table marketplace listings marketplace
   * ```
   * 
   * @action getlisting
   * @param {u64} assetId - AtomicAssets asset ID to query
   * @returns {void} Prints listing details or "No listing found" message
   */
  @action("getlisting")
  getListing(assetId: u64): void {
    // Get listing from table
    const listing = this.listingsTable.get(assetId);
    
    if (listing) {
      // Print listing details
      print(`Asset ID: ${listing.assetId}`);
      print(`Seller: ${listing.seller}`);
      print(`Price: ${listing.price}`);
      print(`Listed At: ${listing.listedAt}`);
    } else {
      // Listing not found
      print(`No listing found for asset ${assetId}`);
    }
  }

  /**
   * Clear All Listings
   * 
   * Removes all listings from the marketplace. This is an administrative
   * action that can only be executed by the contract owner.
   * 
   * ## Warning:
   * This operation cannot be undone. Use with caution.
   * 
   * ## Requirements:
   * - Caller must be contract owner (authorization required)
   * 
   * ## Security:
   * - Requires contract owner authorization
   * - Iterates through all listings safely
   * 
   * ## Use Cases:
   * - Contract maintenance
   * - Testing/debugging
   * - Emergency situations
   * 
   * ## Example Usage:
   * ```bash
   * proton action marketplace clear '{}' marketplace@active
   * ```
   * 
   * @action clear
   * @throws {Error} If caller is not the contract owner
   * @returns {void}
   */
  @action("clear")
  clearAll(): void {
    // Require contract owner authorization
    requireAuth(this.receiver);

    // Iterate through all listings and remove them
    let listing = this.listingsTable.first();
    while (listing != null) {
      const nextListing = this.listingsTable.next(listing);
      this.listingsTable.remove(listing);
      listing = nextListing;
    }

    // Log successful clear operation
    print("All listings cleared");
  }
}
