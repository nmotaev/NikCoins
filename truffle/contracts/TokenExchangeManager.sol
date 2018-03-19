pragma solidity ^0.4.18;

import "./helper/Owned.sol";
import "./NikToken.sol";
import "./Exchange.sol";

contract TokenExchangeManager is Owned {

    NikToken public token;
    Exchange public exchange;
    bool public active = false;

    event ErrorDebug(string message);

    function deactivate() public onlyOwner returns (bool success) {
        if (active) {
            active = false;
        }

        return true;
    }

    function activate() public onlyOwner returns (bool success) {
        if (!active) {
            active = true;
        }

        return true;
    }

    function init (address tokenAddress, address exchangeAddress) public onlyOwner returns (bool) {
        if (active) {
            ErrorDebug("At first you must deactivate this manager.");

            return false;
        }
        token = NikToken(tokenAddress);
        exchange = Exchange(exchangeAddress);
        activate();

        return true;
    }
}
