pragma solidity ^0.4.23;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Token.sol";

contract TokenTest {

    Token token = Token(DeployedAddresses.Token());

    function testTotalSupply() public {
        Assert.equal(token.totalSupply(),1000000,"Total supply 1000000");
    }

    function testTokenName() public {
        Assert.equal(token.name(), "Stimulon", "Name of the token is Stimulon");
    }

    function testTokenSymbol() public {
        Assert.equal(token.symbol(), "STM", "Symbol of the token is STM");
    }

    function testBalanceOf() public {
        uint _real = token.balanceOf(msg.sender);
        uint _expected = 1000000;
        Assert.equal(_real, _expected, "Balance initialized to msg.sender");
    }

    function testTransferFrom() public {
        token.transferFrom(msg.sender, 0x54478ED1AC5b0ea8E174D4d8b10f7223FCE21308, 20);
        uint balance = token.balanceOf(0x54478ED1AC5b0ea8E174D4d8b10f7223FCE21308);
        Assert.equal(balance, 20, "Transfer STM tokens");
    }

    //Just for testing the function an extra sender argument
    // function testApprove() public {
    //     address _expectedSpender = 0xA505c97094674b7befC266baeD20e5D9B5A35d16;
    //     uint _expectedValue = 10;
    //     token.approve(msg.sender, _expectedSpender, _expectedValue);
    //     (address spender, uint value) = token.getSpenderAndValue(msg.sender);
    //     Assert.equal(spender, _expectedSpender, "Approved spender");
    //     Assert.equal(value, _expectedValue, "Approved value to be spent by spender");
    // }
}