if (typeof window.web3 !== 'undefined') {
    window.web3 = new Web3(web3.currentProvider);   
}
else {
    window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"))
}
var account;
window.web3.eth.getAccounts((error, accounts) => {
    account = accounts[0];
});

var tokenSaleAddress = '0xa633a26e180911e03ba7e4d83ff597e4d8d190b4';

function getBalance() {
    if(account != null) {
        web3.eth.getBalance(account, (error, balance) => {
            document.getElementById("myBalance").innerText = "Ether Balance: "+web3.fromWei(balance, 'ether').toString();
            console.log(web3.fromWei(balance, 'ether').toString());
        });
    }
    else {
        notice("Not logged into MetaMask. Login and Reload")
    }
}

function getSTM() {
    //Call the tokenSale contract to get STM
    var amount = document.getElementById("amount").value;
    console.log(amount);
    web3.eth.sendTransaction({from: account, to: tokenSaleAddress, value: web3.toWei(amount, 'ether')}, function(err, transactionHash) {
        if (!err)
          console.log(transactionHash); 
      });
}

function notice(message) {
    document.getElementById("notice").innerText = message;
}