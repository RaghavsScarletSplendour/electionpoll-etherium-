// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

contract Election {
    // Model a candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    //Store accounts that have voted
    mapping(address => bool) public voters;

    // Store candidates
    // Fetch candidates
    mapping(uint => Candidate) public candidates;

    // Store candidate count
    uint public candidatesCount;

    constructor() public{
        addCandidate(("Candidate 1"));
        addCandidate(("Candidate 2"));
    }

    function addCandidate (string memory _name) private  {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidateId) public {
    // Debug voter check
    if (voters[msg.sender]) {
        revert("Already voted");
    }
    require(!voters[msg.sender], "Already voted");
    require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");

    // Record voter
    voters[msg.sender] = true;

    // Update candidate vote count
    candidates[_candidateId].voteCount++;

    // Debugging
    emit LogVoteCast(msg.sender, _candidateId);
}

// Debugging event
event LogVoteCast(address indexed voter, uint candidateId);

}

