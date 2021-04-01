// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

contract Election {

    struct Candidate {
        string name;
        uint voteCount;
    }

    uint public totalVotes;
    uint private maxVotes;
    Candidate votingObject;

    mapping(address => bool) public voterLookup;

    event votedEvent();

    function addCandidate(string memory name) private {
        votingObject = Candidate(name, 0);
    }

    constructor(string memory votingObjectName, uint votersAmount) public {
        require(votersAmount < 10);
        maxVotes = votersAmount;
        addCandidate(votingObjectName);
    }

    function getCandidate() external view returns (string memory name, uint voteCount) {
        name = votingObject.name;
        voteCount = votingObject.voteCount; 
    }

    function vote() external {
        require(totalVotes < maxVotes);
        require(!voterLookup[msg.sender]);
        votingObject.voteCount++;
        totalVotes++;
        voterLookup[msg.sender] = true;
        emit votedEvent();
    }
}