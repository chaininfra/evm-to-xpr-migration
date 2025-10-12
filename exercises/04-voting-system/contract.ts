import { Contract, Name, Table, TableStore, check, print, requireAuth } from "proton-tsc";

/**
 * Proposal table structure
 * Stores voting proposals with their current vote counts and status
 * 
 * @table proposals
 */
@table("proposals")
export class Proposal extends Table {
  /**
   * @param {u64} id - Unique proposal identifier (auto-increment)
   * @param {string} title - Proposal title (max 256 characters)
   * @param {string} description - Detailed description (max 1024 characters)
   * @param {Name} creator - Account that created the proposal
   * @param {u64} yesVotes - Number of affirmative votes
   * @param {u64} noVotes - Number of negative votes
   * @param {boolean} isActive - Proposal status (true = open, false = closed)
   */
  constructor(
    public id: u64 = 0,
    public title: string = "",
    public description: string = "",
    public creator: Name = new Name(),
    public yesVotes: u64 = 0,
    public noVotes: u64 = 0,
    public isActive: boolean = true
  ) {
    super();
  }

  @primary
  get primary(): u64 {
    return this.id;
  }
}

/**
 * Vote table structure
 * Records all votes cast by users on proposals
 * Prevents duplicate voting by same user on same proposal
 * 
 * @table votes
 */
@table("votes")
export class Vote extends Table {
  /**
   * @param {u64} id - Unique vote identifier (auto-increment)
   * @param {u64} proposalId - Reference to proposal being voted on
   * @param {Name} voter - Account that cast the vote
   * @param {boolean} voteChoice - Vote direction (true = yes, false = no)
   */
  constructor(
    public id: u64 = 0,
    public proposalId: u64 = 0,
    public voter: Name = new Name(),
    public voteChoice: boolean = false
  ) {
    super();
  }

  @primary
  get primary(): u64 {
    return this.id;
  }
}

/**
 * Voting System Smart Contract
 * 
 * Implements a simple on-chain voting system where users can:
 * - Create proposals with title and description
 * - Vote yes/no on active proposals (once per user per proposal)
 * - Close proposals to prevent further voting
 * - Delete proposals and associated votes
 * 
 * @contract
 */
@contract
export class VotingContract extends Contract {
  /** Table store for proposals */
  proposalsTable: TableStore<Proposal> = new TableStore<Proposal>(this.receiver);
  
  /** Table store for votes */
  votesTable: TableStore<Vote> = new TableStore<Vote>(this.receiver);

  /**
   * Create a new voting proposal
   * 
   * @action create
   * @param {Name} creator - Account creating the proposal (requires auth)
   * @param {string} title - Proposal title (1-256 characters)
   * @param {string} description - Proposal description (1-1024 characters)
   * @throws {Error} If title or description is empty or exceeds length limits
   * @returns {void}
   */
  @action("create")
  createProposal(
    creator: Name,
    title: string,
    description: string
  ): void {
    requireAuth(creator);

    check(title.length > 0, "Title cannot be empty");
    check(title.length <= 256, "Title too long (max 256 characters)");
    check(description.length > 0, "Description cannot be empty");
    check(description.length <= 1024, "Description too long (max 1024 characters)");

    const proposalId = this.proposalsTable.availablePrimaryKey;

    const proposal = new Proposal(
      proposalId,
      title,
      description,
      creator,
      0,
      0,
      true
    );

    this.proposalsTable.store(proposal, this.receiver);

    print(`Proposal ${proposalId} created by ${creator}`);
  }

  /**
   * Cast a vote on a proposal
   * 
   * Each user can vote only once per proposal.
   * Votes can only be cast on active (open) proposals.
   * 
   * @action vote
   * @param {Name} voter - Account casting the vote (requires auth)
   * @param {u64} proposalId - ID of proposal to vote on
   * @param {boolean} voteChoice - Vote direction (true = yes, false = no)
   * @throws {Error} If proposal doesn't exist, is closed, or user already voted
   * @returns {void}
   */
  @action("vote")
  castVote(
    voter: Name,
    proposalId: u64,
    voteChoice: boolean
  ): void {
    requireAuth(voter);

    const proposal = this.proposalsTable.get(proposalId);
    check(proposal != null, "Proposal does not exist");
    
    if (proposal) {
      check(proposal.isActive, "Proposal is closed");

      check(!this.hasUserVoted(voter, proposalId), "You have already voted on this proposal");

      if (voteChoice) {
        proposal.yesVotes += 1;
      } else {
        proposal.noVotes += 1;
      }
      this.proposalsTable.update(proposal, this.receiver);

      const voteId = this.votesTable.availablePrimaryKey;
      const voteRecord = new Vote(
        voteId,
        proposalId,
        voter,
        voteChoice
      );
      this.votesTable.store(voteRecord, this.receiver);

      print(`${voter} voted ${voteChoice ? "YES" : "NO"} on proposal ${proposalId}`);
    }
  }

  /**
   * Close a proposal to prevent further voting
   * 
   * Only the proposal creator or contract owner can close a proposal.
   * Once closed, no more votes can be cast on the proposal.
   * 
   * @action close
   * @param {u64} proposalId - ID of proposal to close
   * @param {Name} closer - Account closing the proposal (requires auth)
   * @throws {Error} If proposal doesn't exist, is already closed, or caller lacks permission
   * @returns {void}
   */
  @action("close")
  closeProposal(
    proposalId: u64,
    closer: Name
  ): void {
    requireAuth(closer);

    const proposal = this.proposalsTable.get(proposalId);
    check(proposal != null, "Proposal does not exist");
    
    if (proposal) {
      check(
        proposal.creator == closer || closer == this.receiver,
        "Only creator or contract owner can close the proposal"
      );

      check(proposal.isActive, "Proposal is already closed");

      proposal.isActive = false;
      this.proposalsTable.update(proposal, this.receiver);

      print(`Proposal ${proposalId} closed. Results: YES=${proposal.yesVotes}, NO=${proposal.noVotes}`);
    }
  }

  /**
   * Delete a proposal and all associated votes
   * 
   * Only the proposal creator or contract owner can delete a proposal.
   * All votes associated with the proposal are also deleted.
   * 
   * @action delete
   * @param {u64} proposalId - ID of proposal to delete
   * @param {Name} deleter - Account deleting the proposal (requires auth)
   * @throws {Error} If proposal doesn't exist or caller lacks permission
   * @returns {void}
   */
  @action("delete")
  deleteProposal(
    proposalId: u64,
    deleter: Name
  ): void {
    requireAuth(deleter);

    const proposal = this.proposalsTable.get(proposalId);
    check(proposal != null, "Proposal does not exist");
    
    if (proposal) {
      check(
        proposal.creator == deleter || deleter == this.receiver,
        "Only creator or contract owner can delete the proposal"
      );

      this.deleteVotesByProposal(proposalId);
      this.proposalsTable.remove(proposal);

      print(`Proposal ${proposalId} deleted`);
    }
  }

  /**
   * Clear all data from the contract
   * 
   * Removes all proposals and votes from the contract storage.
   * Only the contract owner can execute this action.
   * Use with caution - this operation cannot be undone.
   * 
   * @action clear
   * @throws {Error} If caller is not the contract owner
   * @returns {void}
   */
  @action("clear")
  clearAll(): void {
    requireAuth(this.receiver);

    // Xóa tất cả votes
    let vote = this.votesTable.first();
    while (vote != null) {
      const nextVote = this.votesTable.next(vote);
      this.votesTable.remove(vote);
      vote = nextVote;
    }

    // Xóa tất cả proposals
    let proposal = this.proposalsTable.first();
    while (proposal != null) {
      const nextProposal = this.proposalsTable.next(proposal);
      this.proposalsTable.remove(proposal);
      proposal = nextProposal;
    }

    print("All data cleared");
  }

  /**
   * Check if a user has already voted on a proposal
   * 
   * Iterates through all votes to find matching voter and proposalId.
   * 
   * @private
   * @param {Name} voter - Account to check
   * @param {u64} proposalId - Proposal ID to check against
   * @returns {boolean} True if user has voted, false otherwise
   */
  private hasUserVoted(voter: Name, proposalId: u64): boolean {
    let currentVote = this.votesTable.first();
    
    while (currentVote != null) {
      if (currentVote.voter == voter && currentVote.proposalId == proposalId) {
        return true;
      }
      currentVote = this.votesTable.next(currentVote);
    }
    
    return false;
  }

  /**
   * Delete all votes associated with a proposal
   * 
   * Iterates through all votes and removes those matching the proposalId.
   * Called internally when deleting a proposal.
   * 
   * @private
   * @param {u64} proposalId - Proposal ID whose votes should be deleted
   * @returns {void}
   */
  private deleteVotesByProposal(proposalId: u64): void {
    let currentVote = this.votesTable.first();
    
    while (currentVote != null) {
      const nextVote = this.votesTable.next(currentVote);
      
      if (currentVote.proposalId == proposalId) {
        this.votesTable.remove(currentVote);
      }
      
      currentVote = nextVote;
    }
  }
}
