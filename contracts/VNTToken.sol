// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title VNTToken - Native Token for Venture Ecosystem
contract VNTToken is ERC20, Ownable {
    uint256 public maxSupply = 1_000_000_000 * 10**18; // 1 Billion VNT

    constructor() ERC20("Venture Token", "VNT") {
        _mint(msg.sender, maxSupply); // Mint all tokens to deployer
    }

    /// @notice Burns tokens from the caller's balance
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    /// @notice Airdrops tokens to a recipient (onlyOwner)
    function airdrop(address recipient, uint256 amount) external onlyOwner {
        _transfer(owner(), recipient, amount);
    }
}
