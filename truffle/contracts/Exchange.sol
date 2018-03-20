pragma solidity ^0.4.18;

import "./ExchangeInterface.sol";
import "./helper/Owned.sol";
import "./TokenExchangeManager.sol";
import "./NikToken.sol";
import "./helper/SafeMath.sol";

contract Exchange is Owned {

    TokenExchangeManager internal tokenManager;

    using SafeMath for uint;

    uint internal sellRate = 10000;
    uint internal buyRate = 1;
    event InvestedLog(string message, uint etherValue, uint tokensAmount, uint sellRate);
    event RevertLog(string message, uint etherValue, uint tokensAmount, uint sellRate, uint tokenBalance);
    event AmountLog(string message, uint requestedAmount, uint currentBalance);

    //request to buy tokens
    function sellTokens(uint amount) internal returns (bool) {
        AmountLog('Requested amount', amount, getTokenHandler().balanceOf(address(this)));
        if (amount > getTokenHandler().balanceOf(address(this))) {
            return false;
        }
        getTokenHandler().transfer(msg.sender, amount);

        return true;
    }

    function buyTokens () public payable returns (bool) {
        msg.sender.transfer(1 ether);
    }

    function getTokenHandler() private view returns (NikToken) {
        return NikToken(tokenManager.getTokenHandler());
    }

    function setTokenManager(address _tokenManager) public onlyOwner returns (bool success) {
        tokenManager = TokenExchangeManager(_tokenManager);

        return true;
    }

    function returnTokens(uint amount) public onlyOwner {
        getTokenHandler().transfer(msg.sender, amount);
    }

    function returnEth() public payable onlyOwner {
        msg.sender.transfer(1 ether);
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
