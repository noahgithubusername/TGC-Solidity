// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
contract FixedDepositBox {
    address public owner;
    mapping(address => bytes32) public passwordMap;
    uint256 public contractBalance;

    struct DepositInfo {
        uint256 investmentAmount;
        uint256 duration;
        uint256 interestRatePerHour;
        bool withdrawn;
    }
    mapping(address => DepositInfo) public depositRecords;

    constructor() {
        owner = msg.sender;
    }

    function deposit(uint256 _investmentAmount, uint256 _durationMinutes, uint256 _interestRatePerHour, bytes32 _password) external payable {
        require(msg.value == _investmentAmount, "Amount sent does not match investment amount.");
        require(_durationMinutes > 0, "Duration should be greater than 0.");
        require(_interestRatePerHour >= 0, "Interest rate cannot be negative.");

        contractBalance += _investmentAmount;
        passwordMap[msg.sender] = _password;
        depositRecords[msg.sender] = DepositInfo(_investmentAmount, _durationMinutes * 1 minutes, _interestRatePerHour, false);
    }

    function withdrawal(bytes32 _password) external {
        require(passwordMap[msg.sender] == _password, "Invalid password.");
        require(!depositRecords[msg.sender].withdrawn, "Funds already withdrawn.");
        require(block.timestamp >= depositRecords[msg.sender].duration + depositRecords[msg.sender].duration, "Duration not completed yet.");

        uint256 elapsedTime = block.timestamp - depositRecords[msg.sender].duration;
        uint256 interestEarned = (depositRecords[msg.sender].investmentAmount * depositRecords[msg.sender].interestRatePerHour * elapsedTime) / (1 hours * 100);
        uint256 totalAmount = depositRecords[msg.sender].investmentAmount + interestEarned;

        depositRecords[msg.sender].withdrawn = true;
        contractBalance -= totalAmount;

        payable(msg.sender).transfer(totalAmount);
    }

    // Function to withdraw contract balance by owner
    function withdrawContractBalance() external {
        require(msg.sender == owner, "Only owner can withdraw contract balance.");
        payable(owner).transfer(contractBalance);
        contractBalance = 0;
    }
}
