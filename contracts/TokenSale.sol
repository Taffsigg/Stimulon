pragma solidity ^0.4.23;

contract Token {
    function transfer(address to, uint tokens) public returns (bool success);
}

contract TokenSale {
    Token token;
    mapping(address => uint) public balanceOf;
    address public sendToIfSuccessful;
    bool public saleClosed;
    bool public saleSuccessful;
    uint public amountRaised;
    uint public deadline;
    uint public goal;
    uint public valueOfToken;

    event GoalReached(address to, uint amountRaised);
    event Transferred(address to, uint value);

    constructor(address tokenAddress, address beneficiary, uint deadlineInMins, uint fundingGoal, uint etherValueOfToken) public {
        token = Token(tokenAddress);
        sendToIfSuccessful = beneficiary;
        deadline = deadlineInMins;
        goal = fundingGoal;
        valueOfToken = etherValueOfToken;
    }

    function () payable public{
        uint amount = msg.value;
        amountRaised += amount;
        balanceOf[msg.sender] += amount;
        token.transfer(msg.sender, amount / valueOfToken);
        emit Transferred(msg.sender, amount / valueOfToken);
    }
}