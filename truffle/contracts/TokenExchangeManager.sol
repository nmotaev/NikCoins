pragma solidity ^0.4.18;

import "./helper/Owned.sol";

contract TokenExchangeManager is Owned {

    address public tokenAddress;

    address public exchangeAddress;

    function changeTokenAddress (address _tokenAddress) public onlyOwner {
        tokenAddress = _tokenAddress;
    }

    function changeExchangeAddress (address _exchangeAddress) public onlyOwner {
        exchangeAddress = _exchangeAddress;
    }

    function init (address _tokenAddress, address _exchangeAddress) public onlyOwner {
        tokenAddress = _tokenAddress;
        exchangeAddress = _exchangeAddress;
    }
}
