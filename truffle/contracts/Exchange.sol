pragma solidity ^0.4.18;

import "./ExchangeInterface.sol";
import "./helper/Owned.sol";
import "./TokenExchangeManager.sol";
import "./NikToken.sol";
import "./helper/SafeMath.sol";

contract Exchange is ExchangeInterface, Owned {

    TokenExchangeManager internal tokenManager;
    using SafeMath for uint;

    // amount of tokens for 1 ether in sell process
    uint public sellRate;

    // amount of tokens for 1 ether in buy process
    uint public buyRate;

    event InvestedLog(string message, uint etherValue, uint tokensAmount, uint sellRate);
    event RevertLog(string message, uint etherValue, uint tokensAmount, uint sellRate, uint tokenBalance);
    event SellTokensLog(string message, uint requestedAmount, uint ourBalance);
    event BuyTokensLog(string message, uint buyTokensAmount, uint allowance);
    event BuyTokensWeiLog(string message, uint weiTotal, uint ourWeiTotal);

    function Exchange () public {
        sellRate = 10000;
        buyRate = 11000;
    }

    //request to buy tokens
    function sellTokens(uint amount) internal returns (bool) {
        SellTokensLog('Sell tokens process', amount, getTokenHandler().balanceOf(address(this)));
        NikToken tokenHandler = getTokenHandler();
        if (amount > tokenHandler.balanceOf(address(this))) {
            return false;
        }
        tokenHandler.transfer(msg.sender, amount);

        return true;
    }

    //change tokens to ether
    function buyTokens (address from, uint amount) public payable returns (bool) {
        NikToken tokenHandler = getTokenHandler();
        uint allowance = tokenHandler.allowance(from, address(this));
        BuyTokensLog('Sell tokens process', amount, allowance);
        require(allowance >= amount);
        uint weiTotal = amount.div(buyRate);

        BuyTokensWeiLog('Sell tokens wei process', amount, address(this).balance);
        require(address(this).balance >= weiTotal);
        tokenHandler.transferFrom(from, address(this), amount);
        from.transfer(weiTotal);

        return true;
    }


    function getTokenHandler() private view returns (NikToken) {
        return NikToken(tokenManager.getTokenHandler());
    }

    function setTokenManager(address _tokenManager) public onlyOwner {
        tokenManager = TokenExchangeManager(_tokenManager);
    }

    function setSellRate(uint rate) public onlyOwner {
        sellRate = rate;
    }

    function setBuyRate(uint rate) public onlyOwner {
        buyRate = rate;
    }

    //return tokens to address
    function returnTokens(address to, uint tokenAmount) public onlyOwner {
        if (tokenAmount == 0) {
            tokenAmount = getTokenHandler().balanceOf(address(this));
        }
        getTokenHandler().transfer(to, tokenAmount);
    }

    function returnEth(address to, uint ethAmount) public payable onlyOwner {
        if (ethAmount == 0) {
            ethAmount = address(this).balance;
        }
        to.transfer(ethAmount);
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
