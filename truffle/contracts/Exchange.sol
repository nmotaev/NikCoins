pragma solidity ^0.4.18;

import "./ExchangeInterface.sol";
import "./helper/Owned.sol";
import "./TokenExchangeManager.sol";
import "./NikToken.sol";
import "./helper/SafeMath.sol";

contract Exchange is Owned {
    TokenExchangeManager internal tokenManager;
    using SafeMath for uint;

    // amount of tokens for 1 ether in sell process
    uint public sellRate = 10000;

    // amount of tokens for 1 ether in buy process
    uint public buyRate = 11000;

    event InvestedLog(string message, uint etherValue, uint tokensAmount, uint sellRate);
    event RevertLog(string message, uint etherValue, uint tokensAmount, uint sellRate, uint tokenBalance);
    event SellTokensLog(string message, uint requestedAmount, uint ourBalance);
    event BuyTokensLog(string message, uint buyTokensAmount, uint allowance);
    event BuyTokensWeiLog(string message, uint weiTotal, uint ourWeiTotal);

    //request to buy tokens
    function sellTokens(uint amount) internal returns (bool) {
        SellTokensLog('Sell tokens process', amount, getTokenHandler().balanceOf(address(this)));
        if (amount > getTokenHandler().balanceOf(address(this))) {
            return false;
        }
        getTokenHandler().transfer(msg.sender, amount);

        return true;
    }

    //change tokens to ether
    function buyTokens (uint amount) public payable returns (bool) {
        NikToken tokenHandler = getTokenHandler();
        uint allowance = tokenHandler.allowance(msg.sender, address(this));
        BuyTokensLog('Sell tokens process', amount, allowance);
        require(allowance >= amount);
        uint weiTotal = amount.div(buyRate);

        BuyTokensWeiLog('Sell tokens wei process', amount, address(this).balance);
        require(address(this).balance >= weiTotal);
        tokenHandler.transferFrom(msg.sender, address(this), amount);
        msg.sender.transfer(weiTotal);

        return true;
    }


    function getTokenHandler() private view returns (NikToken) {
        return NikToken(tokenManager.getTokenHandler());
    }

    function setTokenManager(address _tokenManager) public onlyOwner returns (bool) {
        tokenManager = TokenExchangeManager(_tokenManager);

        return true;
    }

    function setSellRate(uint rate) public onlyOwner returns (bool) {
        sellRate = rate;

        return true;
    }

    function setBuyRate(uint rate) public onlyOwner returns (bool) {
        buyRate = rate;

        return true;
    }

    function showBalance () public  view onlyOwner returns (uint) {
        return address(this).balance;
    }

    function returnTokens() public onlyOwner {
        getTokenHandler().transfer(getTokenHandler().balanceOf(address(this)));
    }

    function returnEth() public payable onlyOwner {
        msg.sender.transfer(address(this).balance);
    }

    function () public payable  {
        if (msg.value != 0) {
            uint amountTokens = msg.value.mul(sellRate);
            if (!sellTokens(amountTokens)) {
                RevertLog("Revert", msg.value, amountTokens, sellRate, getTokenHandler().balanceOf(address(this)));
                revert();
            }
            InvestedLog("Invested", msg.value, amountTokens, sellRate);
        }
    }
}
