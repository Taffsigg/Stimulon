var Token = artifacts.require("./Token.sol");
var TokenSale = artifacts.require("./TokenSale.sol")
var BigNumber = require('../js/bignumber.js');

module.exports = function(deployer) {
  //Deploy TokenSale after deploying Token and using its address
  deployer.deploy(Token).then(() => Token.deployed()).then(
    () => {
      return deployer.deploy(TokenSale, Token.address, 1);
    });
};