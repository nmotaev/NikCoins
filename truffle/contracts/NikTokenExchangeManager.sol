pragma solidity ^0.4.18;

import "./helper/Owned.sol";

contract NikTokenExchangeManager is Owned {

    address public nikTokenAddress;

    address public exchangeAddress;

    function changeNikTokenAddress (address _nikTokenAddress) public onlyOwner {
        nikTokenAddress = _nikTokenAddress;
    }

    function changeExchangeAddress (address _exchangeAddress) public onlyOwner {
        exchangeAddress = _exchangeAddress;
    }

    function init (address _nikTokenAddress, address _exchangeAddress) public onlyOwner {
        nikTokenAddress = _nikTokenAddress;
        exchangeAddress = _exchangeAddress;
    }
}
