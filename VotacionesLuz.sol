// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract VotingSystem {
    // Structure to represent a candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Mapping to store and retrieve candidates
    mapping(uint => Candidate) public candidates;

    // Mapping to track if an address has already voted
    mapping(address => bool) public hasVoted;

    // Event to notify when a vote is cast
    event VoteCasted(uint indexed candidateId);

    // Function to add a candidate
    function addCandidate(uint _id, string memory _name) public {
        candidates[_id] = Candidate(_id, _name, 0);
    }

    // Function to cast a vote for a candidate
    function castVote(uint _candidateId) public {
        require(!hasVoted[msg.sender], "You have already voted.");

        Candidate storage candidate = candidates[_candidateId];
        require(candidate.id != 0, "Invalid candidate ID.");

        candidate.voteCount++;
        hasVoted[msg.sender] = true;

        emit VoteCasted(_candidateId);
    }

    // Function to get the vote count of a candidate
    function getVoteCount(uint _candidateId) public view returns (uint) {
        return candidates[_candidateId].voteCount;
    }
}