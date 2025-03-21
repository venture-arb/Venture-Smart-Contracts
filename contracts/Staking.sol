// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title Staking Contract for $VNT
contract Staking is Ownable {
    IERC20 public vntToken;
    uint256 public rewardRate = 10; // 10% APY

    struct Staker {
        uint256 stakedAmount;
        uint256 lastUpdated;
        uint256 rewardDebt;
    }

    mapping(address => Staker) public stakers;

    constructor(address _vntToken) {
        vntToken = IERC20(_vntToken);
    }

    function stake(uint256 _amount) external {
        require(_amount > 0, "Cannot stake 0");
        vntToken.transferFrom(msg.sender, address(this), _amount);

        Staker storage staker = stakers[msg.sender];
        staker.stakedAmount += _amount;
        staker.lastUpdated = block.timestamp;
    }

    function claimRewards() external {
        Staker storage staker = stakers[msg.sender];
        uint256 timeDiff = block.timestamp - staker.lastUpdated;
        uint256 reward = (staker.stakedAmount * rewardRate * timeDiff) / (365 days * 100);
        
        require(reward > 0, "No rewards to claim");
        vntToken.transfer(msg.sender, reward);
        staker.lastUpdated = block.timestamp;
    }

    function withdraw(uint256 _amount) external {
        Staker storage staker = stakers[msg.sender];
        require(_amount <= staker.stakedAmount, "Insufficient staked balance");

        vntToken.transfer(msg.sender, _amount);
        staker.stakedAmount -= _amount;
        staker.lastUpdated = block.timestamp;
    }
}
