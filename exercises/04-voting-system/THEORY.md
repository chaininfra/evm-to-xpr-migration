# Theory: Voting System & Governance

## Learning Objectives
- Understand decentralized governance and DAO concepts
- Master voting mechanisms and proposal lifecycle
- Practice Sybil resistance and vote manipulation prevention
- Understand quorum requirements and decision-making processes
- Learn security patterns in governance systems

## Prerequisites
- Completed Token Contract
- Understanding of state management and TableStore
- Basic knowledge of governance and voting

## 1. Voting System Basics

### 1.1 Proposal Data Structure
Using XPR Network Contract SDK storage:

```typescript
import { TableStore, Table, Name } from "proton-tsc";

@table("proposals")
export class Proposal extends Table {
    constructor(
        public id: u64 = 0,
        public title: string = "",
        public description: string = "",
        public creator: Name = new Name(),
        public yesVotes: u64 = 0,
        public noVotes: u64 = 0,
        public isActive: boolean = true
    ) { super(); }
    
    @primary
    get primary(): u64 {
        return this.id;
    }
}
```

### 1.2 Vote Data Structure
```typescript
@table("votes")
export class Vote extends Table {
    constructor(
        public id: u64 = 0,
        public proposalId: u64 = 0,
        public voter: Name = new Name(),
        public voteChoice: boolean = false
    ) { super(); }
    
    @primary
    get primary(): u64 {
        return this.id;
    }
}
```

## 2. Voting Mechanisms

### 2.1 Voting Types
```typescript
// Voting types
enum VotingType {
    SIMPLE_MAJORITY,    // 50% + 1
    SUPER_MAJORITY,     // 66.7% + 1
    CONSENSUS,          // 100%
    QUORUM_BASED,       // Minimum participation
    WEIGHTED,           // Token-weighted voting
    DELEGATED           // Delegated voting
}

// Implementation
@action("vote")
castVote(voter: Name, proposalId: u64, voteChoice: boolean): void {
    // Simple majority voting
    if (voteChoice) {
        proposal.yesVotes += 1;
    } else {
        proposal.noVotes += 1;
    }
    
    // Check if proposal passes
    const totalVotes = proposal.yesVotes + proposal.noVotes;
    const yesPercentage = (proposal.yesVotes * 100) / totalVotes;
    
    if (yesPercentage > 50) {
        proposal.status = "PASSED";
    } else {
        proposal.status = "FAILED";
    }
}
```

### 2.2 Voting Patterns
```typescript
// Pattern 1: Binary voting (Yes/No)
@action("binary_vote")
binaryVote(voter: Name, proposalId: u64, support: boolean): void {
    const proposal = this.proposalsTable.get(proposalId);
    check(proposal != null, "Proposal does not exist");
    check(proposal.isActive, "Proposal is closed");
    
    if (support) {
        proposal.yesVotes += 1;
    } else {
        proposal.noVotes += 1;
    }
    
    this.proposalsTable.update(proposal, this.receiver);
}

// Pattern 2: Multiple choice voting
@table("choices")
class Choice extends Table {
    constructor(
        public id: u64 = 0,
        public proposalId: u64 = 0,
        public choice: string = "",
        public votes: u64 = 0
    ) { super(); }
    
    @primary get primary(): u64 { return this.id; }
}

@action("multiple_choice_vote")
multipleChoiceVote(voter: Name, proposalId: u64, choiceId: u64): void {
    const choice = this.choicesTable.get(choiceId);
    check(choice != null, "Choice does not exist");
    check(choice.proposalId == proposalId, "Invalid choice for proposal");
    
    choice.votes += 1;
    this.choicesTable.update(choice, this.receiver);
}

// Pattern 3: Ranked choice voting
@table("ranked_votes")
class RankedVote extends Table {
    constructor(
        public id: u64 = 0,
        public voter: Name = new Name(),
        public proposalId: u64 = 0,
        public rankings: string = "" // JSON string of rankings
    ) { super(); }
    
    @primary get primary(): u64 { return this.id; }
}

@action("ranked_vote")
rankedVote(voter: Name, proposalId: u64, rankings: string): void {
    const rankedVote = new RankedVote(0, voter, proposalId, rankings);
    this.rankedVotesTable.store(rankedVote, this.receiver);
}
```

## 3. Proposal Lifecycle

### 3.1 Proposal States
```typescript
// Proposal lifecycle states
enum ProposalState {
    DRAFT,          // Being created
    ACTIVE,         // Open for voting
    CLOSED,         // Voting ended
    EXECUTED,       // Successfully executed
    FAILED,         // Did not pass
    CANCELLED       // Cancelled by creator
}

// Implementation
@table("proposals")
export class Proposal extends Table {
    constructor(
        public id: u64 = 0,
        public title: string = "",
        public description: string = "",
        public creator: Name = new Name(),
        public yesVotes: u64 = 0,
        public noVotes: u64 = 0,
        public isActive: boolean = true,
        public state: string = "ACTIVE",
        public createdAt: u64 = 0,
        public votingEndsAt: u64 = 0
    ) { super(); }
    
    @primary get primary(): u64 { return this.id; }
}
```

### 3.2 Proposal Management
```typescript
// Create proposal
@action("create")
createProposal(creator: Name, title: string, description: string): void {
    requireAuth(creator);
    
    check(title.length > 0, "Title cannot be empty");
    check(title.length <= 256, "Title too long (max 256 characters)");
    check(description.length > 0, "Description cannot be empty");
    check(description.length <= 1024, "Description too long (max 1024 characters)");
    
    const proposalId = this.proposalsTable.availablePrimaryKey;
    const votingDuration = 7 * 24 * 60 * 60 * 1000; // 7 days
    
    const proposal = new Proposal(
        proposalId,
        title,
        description,
        creator,
        0,
        0,
        true,
        "ACTIVE",
        Date.now(),
        Date.now() + votingDuration
    );
    
    this.proposalsTable.store(proposal, this.receiver);
    print(`Proposal ${proposalId} created by ${creator}`);
}

// Close proposal
@action("close")
closeProposal(proposalId: u64, closer: Name): void {
    requireAuth(closer);
    
    const proposal = this.proposalsTable.get(proposalId);
    check(proposal != null, "Proposal does not exist");
    check(proposal.isActive, "Proposal is already closed");
    check(
        proposal.creator == closer || closer == this.receiver,
        "Only creator or contract owner can close the proposal"
    );
    
    proposal.isActive = false;
    proposal.state = "CLOSED";
    this.proposalsTable.update(proposal, this.receiver);
    
    print(`Proposal ${proposalId} closed. Results: YES=${proposal.yesVotes}, NO=${proposal.noVotes}`);
}
```

## 4. Sybil Resistance

### 4.1 What is Sybil Attack?
```
Sybil Attack:
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Attacker      │    │   Fake Account  │    │   Fake Account  │
│                 │    │   #1            │    │   #2            │
│ • Creates many  │───▶│ • Votes Yes     │───▶│ • Votes Yes     │
│   fake accounts │    │ • Same person   │    │ • Same person   │
│ • Controls      │    │ • Multiple      │    │ • Multiple      │
│   voting        │    │   votes         │    │   votes         │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### 4.2 Sybil Resistance Mechanisms
```typescript
// Mechanism 1: Token-weighted voting
@action("token_weighted_vote")
tokenWeightedVote(voter: Name, proposalId: u64, voteChoice: boolean): void {
    const voterBalance = this.getTokenBalance(voter);
    check(voterBalance.amount > 0, "No voting power");
    
    const proposal = this.proposalsTable.get(proposalId);
    check(proposal != null, "Proposal does not exist");
    check(proposal.isActive, "Proposal is closed");
    
    if (voteChoice) {
        proposal.yesVotes += voterBalance.amount;
    } else {
        proposal.noVotes += voterBalance.amount;
    }
    
    this.proposalsTable.update(proposal, this.receiver);
}

// Mechanism 2: Reputation-based voting
@table("reputation")
class Reputation extends Table {
    constructor(
        public user: Name = new Name(),
        public score: u64 = 0,
        public lastUpdated: u64 = 0
    ) { super(); }
    
    @primary get primary(): u64 { return this.user.N; }
}

@action("reputation_vote")
reputationVote(voter: Name, proposalId: u64, voteChoice: boolean): void {
    const reputation = this.reputationTable.get(voter.N);
    check(reputation != null, "No reputation found");
    check(reputation.score > 0, "Insufficient reputation");
    
    const proposal = this.proposalsTable.get(proposalId);
    check(proposal != null, "Proposal does not exist");
    check(proposal.isActive, "Proposal is closed");
    
    if (voteChoice) {
        proposal.yesVotes += reputation.score;
    } else {
        proposal.noVotes += reputation.score;
    }
    
    this.proposalsTable.update(proposal, this.receiver);
}

// Mechanism 3: Time-locked voting power
@table("voting_power")
class VotingPower extends Table {
    constructor(
        public user: Name = new Name(),
        public power: u64 = 0,
        public lockedUntil: u64 = 0
    ) { super(); }
    
    @primary get primary(): u64 { return this.user.N; }
}

@action("time_locked_vote")
timeLockedVote(voter: Name, proposalId: u64, voteChoice: boolean): void {
    const votingPower = this.votingPowerTable.get(voter.N);
    check(votingPower != null, "No voting power found");
    check(votingPower.power > 0, "Insufficient voting power");
    check(Date.now() >= votingPower.lockedUntil, "Voting power still locked");
    
    const proposal = this.proposalsTable.get(proposalId);
    check(proposal != null, "Proposal does not exist");
    check(proposal.isActive, "Proposal is closed");
    
    if (voteChoice) {
        proposal.yesVotes += votingPower.power;
    } else {
        proposal.noVotes += votingPower.power;
    }
    
    this.proposalsTable.update(proposal, this.receiver);
}
```

## 5. Quorum Requirements

### 5.1 What is Quorum?
```typescript
// Quorum: Minimum participation required
interface QuorumRequirements {
    minimumVotes: u64;        // Minimum number of votes
    minimumPercentage: u64;    // Minimum percentage of eligible voters
    minimumTokens: u64;        // Minimum token amount voted
    timeLimit: u64;           // Time limit for voting
}

// Implementation
@action("check_quorum")
checkQuorum(proposalId: u64): boolean {
    const proposal = this.proposalsTable.get(proposalId);
    check(proposal != null, "Proposal does not exist");
    
    const totalVotes = proposal.yesVotes + proposal.noVotes;
    const totalEligibleVoters = this.getTotalEligibleVoters();
    const participationPercentage = (totalVotes * 100) / totalEligibleVoters;
    
    // Check quorum requirements
    const minVotes = 100; // Minimum 100 votes
    const minPercentage = 10; // Minimum 10% participation
    
    if (totalVotes < minVotes) {
        print(`Quorum not met: ${totalVotes} votes (minimum ${minVotes})`);
        return false;
    }
    
    if (participationPercentage < minPercentage) {
        print(`Quorum not met: ${participationPercentage}% participation (minimum ${minPercentage}%)`);
        return false;
    }
    
    print(`Quorum met: ${totalVotes} votes, ${participationPercentage}% participation`);
    return true;
}
```

### 5.2 Dynamic Quorum
```typescript
// Dynamic quorum based on proposal importance
@action("dynamic_quorum_vote")
dynamicQuorumVote(voter: Name, proposalId: u64, voteChoice: boolean): void {
    const proposal = this.proposalsTable.get(proposalId);
    check(proposal != null, "Proposal does not exist");
    check(proposal.isActive, "Proposal is closed");
    
    // Calculate dynamic quorum based on proposal type
    let requiredQuorum: u64;
    if (proposal.title.includes("CRITICAL")) {
        requiredQuorum = 50; // 50% for critical proposals
    } else if (proposal.title.includes("IMPORTANT")) {
        requiredQuorum = 25; // 25% for important proposals
    } else {
        requiredQuorum = 10; // 10% for regular proposals
    }
    
    // Cast vote
    if (voteChoice) {
        proposal.yesVotes += 1;
    } else {
        proposal.noVotes += 1;
    }
    
    // Check if quorum is met
    const totalVotes = proposal.yesVotes + proposal.noVotes;
    const totalEligibleVoters = this.getTotalEligibleVoters();
    const participationPercentage = (totalVotes * 100) / totalEligibleVoters;
    
    if (participationPercentage >= requiredQuorum) {
        proposal.quorumMet = true;
        print(`Quorum met: ${participationPercentage}% >= ${requiredQuorum}%`);
    }
    
    this.proposalsTable.update(proposal, this.receiver);
}
```

## 6. Security Patterns

### 6.1 Vote Manipulation Prevention
```typescript
// Pattern 1: One vote per user per proposal
@action("vote")
castVote(voter: Name, proposalId: u64, voteChoice: boolean): void {
    requireAuth(voter);
    
    const proposal = this.proposalsTable.get(proposalId);
    check(proposal != null, "Proposal does not exist");
    check(proposal.isActive, "Proposal is closed");
    
    // Check if user already voted
    check(!this.hasUserVoted(voter, proposalId), "You have already voted on this proposal");
    
    // Record vote
    const voteId = this.votesTable.availablePrimaryKey;
    const voteRecord = new Vote(voteId, proposalId, voter, voteChoice);
    this.votesTable.store(voteRecord, this.receiver);
    
    // Update proposal
    if (voteChoice) {
        proposal.yesVotes += 1;
    } else {
        proposal.noVotes += 1;
    }
    this.proposalsTable.update(proposal, this.receiver);
    
    print(`${voter} voted ${voteChoice ? "YES" : "NO"} on proposal ${proposalId}`);
}

// Pattern 2: Time-locked voting
@action("time_locked_vote")
timeLockedVote(voter: Name, proposalId: u64, voteChoice: boolean): void {
    const proposal = this.proposalsTable.get(proposalId);
    check(proposal != null, "Proposal does not exist");
    check(proposal.isActive, "Proposal is closed");
    
    // Check voting time window
    const now = Date.now();
    check(now >= proposal.votingStartsAt, "Voting has not started");
    check(now <= proposal.votingEndsAt, "Voting has ended");
    
    // ... vote logic
}

// Pattern 3: Delegated voting with cooldown
@table("delegations")
class Delegation extends Table {
    constructor(
        public delegator: Name = new Name(),
        public delegate: Name = new Name(),
        public power: u64 = 0,
        public cooldownUntil: u64 = 0
    ) { super(); }
    
    @primary get primary(): u64 { return this.delegator.N; }
}

@action("delegated_vote")
delegatedVote(delegate: Name, proposalId: u64, voteChoice: boolean): void {
    requireAuth(delegate);
    
    // Check cooldown period
    const delegation = this.delegationsTable.get(delegate.N);
    check(delegation != null, "No delegation found");
    check(Date.now() >= delegation.cooldownUntil, "Delegation in cooldown");
    
    // ... vote logic
}
```

### 6.2 Proposal Security
```typescript
// Pattern 1: Proposal validation
@action("create")
createProposal(creator: Name, title: string, description: string): void {
    requireAuth(creator);
    
    // Validate proposal content
    check(title.length > 0, "Title cannot be empty");
    check(title.length <= 256, "Title too long");
    check(description.length > 0, "Description cannot be empty");
    check(description.length <= 1024, "Description too long");
    
    // Check for spam
    const recentProposals = this.getRecentProposals(creator, 24 * 60 * 60 * 1000); // 24 hours
    check(recentProposals.length < 3, "Too many proposals created recently");
    
    // ... create proposal logic
}

// Pattern 2: Proposal execution security
@action("execute")
executeProposal(proposalId: u64, executor: Name): void {
    requireAuth(executor);
    
    const proposal = this.proposalsTable.get(proposalId);
    check(proposal != null, "Proposal does not exist");
    check(proposal.state == "PASSED", "Proposal did not pass");
    check(!proposal.executed, "Proposal already executed");
    
    // Check execution delay
    const executionDelay = 24 * 60 * 60 * 1000; // 24 hours
    check(Date.now() >= proposal.votingEndsAt + executionDelay, "Execution delay not met");
    
    // Execute proposal
    proposal.executed = true;
    proposal.executedBy = executor;
    proposal.executedAt = Date.now();
    this.proposalsTable.update(proposal, this.receiver);
    
    print(`Proposal ${proposalId} executed by ${executor}`);
}
```

## 7. Event Logging & Monitoring

### 7.1 Governance Events
```typescript
// Pattern 1: Comprehensive event logging
@action("vote")
castVote(voter: Name, proposalId: u64, voteChoice: boolean): void {
    // ... vote logic
    
    // Log events for monitoring
    print(`[Vote] ${voter.toString()} voted ${voteChoice ? "YES" : "NO"} on proposal ${proposalId}`);
    print(`[Vote] Timestamp: ${Date.now()}`);
    print(`[Vote] Proposal: ${proposal.title}`);
    print(`[Vote] Current results: YES=${proposal.yesVotes}, NO=${proposal.noVotes}`);
}

// Pattern 2: Analytics tracking
@table("governance_analytics")
class GovernanceAnalytics extends Table {
    constructor(
        public metric: string = "",
        public value: u64 = 0,
        public timestamp: u64 = 0
    ) { super(); }
    
    @primary get primary(): u64 { return this.timestamp; }
}

@action("track_governance_metric")
trackGovernanceMetric(metric: string, value: u64): void {
    const analytics = new GovernanceAnalytics(metric, value, Date.now());
    this.governanceAnalyticsTable.store(analytics, this.receiver);
}

// Usage in vote action
@action("vote")
castVote(voter: Name, proposalId: u64, voteChoice: boolean): void {
    // ... vote logic
    
    // Track metrics
    this.trackGovernanceMetric("total_votes", 1);
    this.trackGovernanceMetric(`proposal_${proposalId}_votes`, 1);
    this.trackGovernanceMetric(`user_${voter.toString()}_votes`, 1);
}
```

## 8. Testing Strategies

### 8.1 Unit Testing
```typescript
describe('Voting System', () => {
    it('should create proposal correctly', () => {
        const proposalId = contract.createProposal("alice", "Test Proposal", "Test Description");
        const proposal = contract.getProposal(proposalId);
        
        expect(proposal.title).toBe("Test Proposal");
        expect(proposal.description).toBe("Test Description");
        expect(proposal.creator.toString()).toBe("alice");
        expect(proposal.isActive).toBe(true);
    });
    
    it('should prevent duplicate voting', () => {
        contract.createProposal("alice", "Test Proposal", "Test Description");
        contract.castVote("bob", 0, true);
        
        expect(() => {
            contract.castVote("bob", 0, false);
        }).toThrow("You have already voted on this proposal");
    });
    
    it('should calculate quorum correctly', () => {
        contract.createProposal("alice", "Test Proposal", "Test Description");
        
        // Cast 100 votes
        for (let i = 0; i < 100; i++) {
            contract.castVote(`user${i}`, 0, true);
        }
        
        const quorumMet = contract.checkQuorum(0);
        expect(quorumMet).toBe(true);
    });
});
```

### 8.2 Integration Testing
```typescript
describe('Voting Integration', () => {
    it('should handle complete proposal lifecycle', () => {
        // 1. Create proposal
        const proposalId = contract.createProposal("alice", "Test Proposal", "Test Description");
        
        // 2. Vote on proposal
        contract.castVote("bob", proposalId, true);
        contract.castVote("charlie", proposalId, false);
        contract.castVote("david", proposalId, true);
        
        // 3. Close proposal
        contract.closeProposal(proposalId, "alice");
        
        // 4. Check results
        const proposal = contract.getProposal(proposalId);
        expect(proposal.yesVotes).toBe(2);
        expect(proposal.noVotes).toBe(1);
        expect(proposal.isActive).toBe(false);
    });
});
```

## 9. Common Patterns & Anti-Patterns

### 9.1 Good Patterns
```typescript
// Pattern 1: Comprehensive validation
@action("create")
createProposal(creator: Name, title: string, description: string): void {
    requireAuth(creator);
    check(title.length > 0, "Title cannot be empty");
    check(title.length <= 256, "Title too long");
    check(description.length > 0, "Description cannot be empty");
    check(description.length <= 1024, "Description too long");
    // ... create logic
}

// Pattern 2: Proper state management
@action("vote")
castVote(voter: Name, proposalId: u64, voteChoice: boolean): void {
    // ... validation logic
    
    // Update proposal state
    if (voteChoice) {
        proposal.yesVotes += 1;
    } else {
        proposal.noVotes += 1;
    }
    
    // Record vote
    const voteRecord = new Vote(0, proposalId, voter, voteChoice);
    this.votesTable.store(voteRecord, this.receiver);
    
    // Update proposal
    this.proposalsTable.update(proposal, this.receiver);
}

// Pattern 3: Event logging
@action("vote")
castVote(voter: Name, proposalId: u64, voteChoice: boolean): void {
    // ... vote logic
    
    print(`[Vote] ${voter.toString()} voted ${voteChoice ? "YES" : "NO"} on proposal ${proposalId}`);
    print(`[Vote] Current results: YES=${proposal.yesVotes}, NO=${proposal.noVotes}`);
}
```

### 9.2 Anti-Patterns
```typescript
// Anti-pattern 1: No validation
@action("unsafe_vote")
unsafeVote(voter: Name, proposalId: u64, voteChoice: boolean): void {
    // No validation - dangerous!
    proposal.yesVotes += voteChoice ? 1 : 0;
    proposal.noVotes += voteChoice ? 0 : 1;
}

// Anti-pattern 2: No duplicate prevention
@action("duplicate_vote")
duplicateVote(voter: Name, proposalId: u64, voteChoice: boolean): void {
    // No check for existing vote - allows manipulation!
    proposal.yesVotes += voteChoice ? 1 : 0;
    proposal.noVotes += voteChoice ? 0 : 1;
}

// Anti-pattern 3: No authorization
@action("public_vote")
publicVote(voter: Name, proposalId: u64, voteChoice: boolean): void {
    // No authorization check - anyone can vote!
    proposal.yesVotes += voteChoice ? 1 : 0;
    proposal.noVotes += voteChoice ? 0 : 1;
}
```

## 10. Advanced Concepts

### 10.1 Delegated Voting
```typescript
// Delegated voting implementation
@action("delegate")
delegateVotingPower(delegator: Name, delegate: Name, power: u64): void {
    requireAuth(delegator);
    
    const delegation = new Delegation(delegator, delegate, power, Date.now());
    this.delegationsTable.store(delegation, this.receiver);
    
    print(`${delegator} delegated ${power} voting power to ${delegate}`);
}

@action("delegated_vote")
delegatedVote(delegate: Name, proposalId: u64, voteChoice: boolean): void {
    requireAuth(delegate);
    
    // Find all delegations to this delegate
    let delegation = this.delegationsTable.first();
    let totalPower = 0;
    
    while (delegation != null) {
        if (delegation.delegate == delegate) {
            totalPower += delegation.power;
        }
        delegation = this.delegationsTable.next(delegation);
    }
    
    check(totalPower > 0, "No delegated voting power");
    
    const proposal = this.proposalsTable.get(proposalId);
    check(proposal != null, "Proposal does not exist");
    check(proposal.isActive, "Proposal is closed");
    
    if (voteChoice) {
        proposal.yesVotes += totalPower;
    } else {
        proposal.noVotes += totalPower;
    }
    
    this.proposalsTable.update(proposal, this.receiver);
    print(`${delegate} voted with ${totalPower} delegated power`);
}
```

### 10.2 Proposal Categories
```typescript
// Categorized proposals with different requirements
enum ProposalCategory {
    GOVERNANCE,     // Protocol governance
    TREASURY,       // Treasury management
    TECHNICAL,      // Technical changes
    SOCIAL,         // Social proposals
    EMERGENCY       // Emergency actions
}

@action("categorized_proposal")
categorizedProposal(creator: Name, title: string, description: string, category: string): void {
    requireAuth(creator);
    
    // Different requirements based on category
    let minVotes: u64;
    let minPercentage: u64;
    let votingDuration: u64;
    
    switch (category) {
        case "GOVERNANCE":
            minVotes = 1000;
            minPercentage = 20;
            votingDuration = 7 * 24 * 60 * 60 * 1000; // 7 days
            break;
        case "TREASURY":
            minVotes = 500;
            minPercentage = 15;
            votingDuration = 5 * 24 * 60 * 60 * 1000; // 5 days
            break;
        case "TECHNICAL":
            minVotes = 200;
            minPercentage = 10;
            votingDuration = 3 * 24 * 60 * 60 * 1000; // 3 days
            break;
        case "SOCIAL":
            minVotes = 100;
            minPercentage = 5;
            votingDuration = 2 * 24 * 60 * 60 * 1000; // 2 days
            break;
        case "EMERGENCY":
            minVotes = 50;
            minPercentage = 5;
            votingDuration = 24 * 60 * 60 * 1000; // 1 day
            break;
        default:
            minVotes = 100;
            minPercentage = 10;
            votingDuration = 3 * 24 * 60 * 60 * 1000; // 3 days
    }
    
    // ... create proposal with category-specific requirements
}
```

## 11. Comparison with EVM

### 11.1 Governance Models
```solidity
// Solidity (EVM) - Compound-style governance
contract Governor {
    mapping(address => uint256) public votingPower;
    mapping(uint256 => Proposal) public proposals;
    
    function propose(address[] memory targets, uint256[] memory values, string[] memory signatures, bytes[] memory calldatas, string memory description) public returns (uint256) {
        // Proposal creation logic
    }
    
    function castVote(uint256 proposalId, uint8 support) public {
        // Voting logic
    }
}
```

```typescript
// AssemblyScript (Proton) - Custom governance
@contract
export class VotingContract extends Contract {
    private proposalsTable: TableStore<Proposal>;
    private votesTable: TableStore<Vote>;
    
    @action("create")
    createProposal(creator: Name, title: string, description: string): void {
        // Proposal creation logic
    }
    
    @action("vote")
    castVote(voter: Name, proposalId: u64, voteChoice: boolean): void {
        // Voting logic
    }
}
```

### 11.2 Key Differences
| Feature | Solidity | AssemblyScript |
|---------|----------|----------------|
| Governance Model | Compound-style | Custom |
| Voting Power | Token-weighted | Configurable |
| Proposal Execution | Automatic | Manual |
| Gas Costs | Variable | Fixed RAM/CPU/NET |

## 12. Next Steps

### 12.1 What You've Learned
- Governance fundamentals
- Voting mechanisms
- Proposal lifecycle
- Sybil resistance
- Quorum requirements
- Security patterns
- Event logging
- Testing strategies
- Advanced concepts

### 12.2 What's Next
- NFT mechanics (NFT Marketplace)
- DeFi protocols (Lending Protocol)

## 13. Resources

### 13.1 Documentation
- [XPR Network Contract SDK - Storage](https://docs.xprnetwork.org/contract-sdk/storage.html)
- [XPR Network Contract SDK - Execution Order](https://docs.xprnetwork.org/contract-sdk/execution-order.html)
- [XPR Network Contract SDK - Notifications](https://docs.xprnetwork.org/contract-sdk/notifications.html)
- [XPR Network Contract SDK - Testing](https://docs.xprnetwork.org/contract-sdk/testing.html)
- [XPR Network Contract SDK - Security](https://docs.xprnetwork.org/contract-sdk/security.html)

### 13.2 Governance Standards
- [Compound Governance](https://compound.finance/docs/governance)
- [Aave Governance](https://docs.aave.com/developers/v/2.0/guides/governance)
- [Uniswap Governance](https://uniswap.org/docs/v2/governance)

### 13.3 Tools
- Proton CLI
- Proton Wallet
- Block Explorer
- Development Tools


---

**Remember**: Governance is the foundation of decentralized systems. Understanding voting mechanisms, security patterns, and Sybil resistance is crucial for building robust governance systems that can scale and remain secure.
