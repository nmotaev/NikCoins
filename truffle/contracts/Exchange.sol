pragma solidity ^0.4.18;

import "./ExchangeInterface.sol";
import "./helper/Owned.sol";
import "./TokenExchangeManager.sol";
import "./NikToken.sol";

contract Exchange is ExchangeInterface, Owned {

    TokenExchangeManager internal tokenManager;

    uint internal sellRate = 1;
    uint internal buyRate = 1;

    function sellTokens(uint amount) public returns (bool success) {
        address to = msg.sender;
        uint amountWithRate = amount * sellRate;
        getTokenHandler().transfer(to, amount);

        return true;
    }

    function buyTokens(uint amount) public returns (bool success) {
        address from = msg.sender;
        uint amountWithRate = amount * buyRate;
        getTokenHandler().transferFrom(from, address(this), amountWithRate);

        return true;
    }

    function getTokenHandler() private returns (NikToken) {
        return NikToken(tokenManager.getTokenHandler());
    }

    function setTokenManager(address _tokenManager) public onlyOwner returns (bool success) {
        tokenManager = TokenExchangeManager(_tokenManager);

        return true;
    }
}
