pragma solidity ^0.4.23;

contract Token {
    uint256 public totalSupply = 1000000;
    string public constant name = "Stimulon";
    string public constant symbol = "STM";

    struct UserData {
        //Maps each user to the value limit
        mapping(address => uint) access;
        uint balance;
    }

    mapping(address => UserData) public balances;

    constructor() public {
        balances[msg.sender] = UserData({balance: totalSupply});
    }

    function balanceOf(address _owner) public view returns (uint balance) {
        return balances[_owner].balance;
    }

    function transfer(address to, uint tokens) public returns (bool success) {
        require(balances[msg.sender].balance >= tokens, "Insufficient balance with the main account");
        balances[to].balance += tokens;
        balances[msg.sender].balance -= tokens;
        return true;
    }

    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        require(balances[from].balance >= tokens, "Insufficient balance with the sender");
        require(balances[from].access[msg.sender] >= tokens, "Not allowed to access this account");
        balances[to].balance += tokens;
        balances[from].balance -= tokens;
        balances[from].access[msg.sender] -= tokens;
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        balances[msg.sender].access[_spender] = _value;
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return balances[_owner].access[_spender];
    }

    // function getSpenderAndValue(address _owner) public returns (address _spender, uint _value) {
    //     return (balances[_owner].spender, balances[_owner].value);
    // }
}