pragma solidity ^0.4.18;

import "./helper/Owned.sol";

contract TokenExchangeManager is Owned {

    address internal tokenAddress;
    address internal exchangeAddress;
    bool public active = false;

    modifier mustBeActive {
        require(active);
        _;
    }

    modifier onlyExchangeHandler {
        require(msg.sender == exchangeAddress);
        _;
    }

    event ErrorDebug(string message);

    function getTokenHandler() external view mustBeActive onlyExchangeHandler returns (address) {
        return tokenAddress;
    }

    function getExchangeHandler() external view mustBeActive returns (address) {
        return exchangeAddress;
    }

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

    function init (address _tokenAddress, address _exchangeAddress) public onlyOwner returns (bool) {
        if (active) {
            ErrorDebug("At first you must deactivate this manager.");

            return false;
        }
        tokenAddress = _tokenAddress;
        exchangeAddress = _exchangeAddress;
        activate();

        return true;
    }
}
