// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

contract Election {

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    uint public candidateCount;
    uint public totalVotes;
    uint private maxVotes;

    mapping(uint => Candidate) public candidateLookup;
    mapping(address => bool) public voterLookup;

    event votedEvent(uint indexed id);

    function addCandidate(string memory name) public {
        candidateLookup[candidateCount] = Candidate(candidateCount, name, 0);
        candidateCount++;
    }

    constructor(uint votersAmount) public {
        require(votersAmount < 10);
        maxVotes = votersAmount;
        addCandidate("kitty");
        addCandidate("doggy");
    }

    function getCandidate(uint id) external view returns (string memory name, uint voteCount) {
        name = candidateLookup[id].name;
        voteCount = candidateLookup[id].voteCount; 
    }

    function getCandidates() external view returns (string[] memory, uint[] memory) {
        string[] memory names = new string[](candidateCount);
        uint[] memory voteCounts = new uint[](candidateCount);
        
        for (uint i = 0; i < candidateCount; i++) {
            names[i] = candidateLookup[i].name;
            voteCounts[i] = candidateLookup[i].voteCount;
        }
        return (names, voteCounts);
    }

    function vote(uint id) external {
        require(totalVotes < maxVotes);
        require(!voterLookup[msg.sender]);
        require(id >= 0 && id <= candidateCount - 1);
        candidateLookup[id].voteCount++;
        totalVotes++;
        voterLookup[msg.sender] = true;
        emit votedEvent(id);
    }
}