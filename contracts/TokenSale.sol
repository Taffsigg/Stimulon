pragma solidity ^0.4.23;

import "./Token.sol";

contract TokenSale {
    Token token;
    mapping(address => uint) public balanceOf;
    address public admin;
    uint public deadline;
    uint public goal;
    uint public valueOfToken;
    uint totalAmount;

    event GoalReached(address to, uint amountRaised);
    event Transferred(address to, uint value, bool isContrib);

    constructor(address tokenAddress, uint etherValueOfToken) public {
        token = Token(tokenAddress);
        admin = msg.sender;
        valueOfToken = etherValueOfToken * 1 ether;
    }

    function () public payable{
        uint amount = msg.value;
        totalAmount += amount;
        balanceOf[msg.sender] += amount;
        uint stm = amount / valueOfToken;
        token.transfer(msg.sender, stm);
        emit Transferred(msg.sender, stm, true);
    }

    function withdraw() public {
        require(msg.sender == admin, "Cannot withdraw. Not the owner");
        msg.sender.transfer(totalAmount);
        totalAmount = 0;
    }

}