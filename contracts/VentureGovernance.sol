// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

/// @title Venture Governance Contract
contract VentureGovernance is Ownable {
    struct Proposal {
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        bool executed;
    }

    Proposal[] public proposals;

    mapping(uint256 => mapping(address => bool)) public hasVoted;

    function createProposal(string memory _description) external onlyOwner {
        proposals.push(Proposal(_description, 0, 0, false));
    }

    function vote(uint256 proposalId, bool support) external {
        require(!hasVoted[proposalId][msg.sender], "Already voted");
        
        if (support) {
            proposals[proposalId].votesFor++;
        } else {
            proposals[proposalId].votesAgainst++;
        }

        hasVoted[proposalId][msg.sender] = true;
    }

    function executeProposal(uint256 proposalId) external onlyOwner {
        require(!proposals[proposalId].executed, "Proposal already executed");
        proposals[proposalId].executed = true;
    }
}
