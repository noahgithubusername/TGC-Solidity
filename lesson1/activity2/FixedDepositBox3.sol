// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract FixedDepositBox {
    address public owner;
    mapping(address => uint256) public balances;
    mapping(address => uint256) public depositTimes;

    IERC20 public token;
    uint256 public contractBalance;

    event Deposit(address indexed from, uint256 amount, uint256 timestamp);
    event Withdrawal(address indexed to, uint256 amount, uint256 timestamp);

    constructor(address _tokenAddress) {
        owner = msg.sender;
        token = IERC20(_tokenAddress);
        contractBalance = token.balanceOf(address(this));
    }

    function deposit(uint256 _amount) external {
        require(_amount > 0, "Deposit amount must be greater than 0.");
        
        uint256 allowance = token.allowance(msg.sender, address(this));
        require(allowance >= _amount, "Insufficient allowance.");
        
        SafeERC20.safeTransferFrom(token, msg.sender, address(this), _amount);

        balances[msg.sender] += _amount;
        depositTimes[msg.sender] = block.timestamp;

        emit Deposit(msg.sender, _amount, block.timestamp);
    }

    function withdrawal(uint256 _amount) external {
        require(_amount > 0, "Withdrawal amount must be greater than 0.");
        require(balances[msg.sender] >= _amount, "Insufficient balance.");

        balances[msg.sender] -= _amount;

        SafeERC20.safeTransfer(token, msg.sender, _amount);

        emit Withdrawal(msg.sender, _amount, block.timestamp);
    }

    // Function to withdraw contract balance by owner
    function withdrawContractBalance() external {
        require(msg.sender == owner, "Only owner can withdraw contract balance.");

        uint256 contractTokenBalance = token.balanceOf(address(this));
        require(contractTokenBalance > 0, "Contract balance is zero.");

        SafeERC20.safeTransfer(token, owner, contractTokenBalance);
        contractBalance = token.balanceOf(address(this));
    }
}
