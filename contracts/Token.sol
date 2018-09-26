pragma solidity ^0.4.23;

contract Token {
    uint256 public totalSupply = 1000000;
    string public constant name = "Stimulon";
    string public constant symbol = "STM";

    mapping(address => uint) public balanceOf;

    constructor() public {
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address to, uint tokens) public returns (bool success) {
        require(balanceOf[msg.sender] > tokens, "Insufficient balance with the main account");
        balanceOf[to] += tokens;
        balanceOf[msg.sender] -= tokens;
        return true;
    }

    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        require(balanceOf[from] > tokens, "Insufficient balance with the sender");
        balanceOf[to] += tokens;
        balanceOf[from] -= tokens;
        return true;
    }
}