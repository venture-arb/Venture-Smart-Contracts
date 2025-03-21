// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title Venture Lending Contract
contract VentureLending is Ownable {
    IERC20 public vntToken;
    uint256 public interestRate = 5; // 5% Annual Interest

    struct Loan {
        uint256 amount;
        uint256 startTime;
        bool active;
    }

    mapping(address => Loan) public loans;

    constructor(address _vntToken) {
        vntToken = IERC20(_vntToken);
    }

    function borrow(uint256 _amount) external {
        require(loans[msg.sender].active == false, "Existing loan active");

        vntToken.transfer(msg.sender, _amount);
        loans[msg.sender] = Loan(_amount, block.timestamp, true);
    }

    function repayLoan() external {
        Loan storage loan = loans[msg.sender];
        require(loan.active, "No active loan");

        uint256 timeDiff = block.timestamp - loan.startTime;
        uint256 interest = (loan.amount * interestRate * timeDiff) / (365 days * 100);
        uint256 totalRepayment = loan.amount + interest;

        vntToken.transferFrom(msg.sender, address(this), totalRepayment);
        loan.active = false;
    }
}
