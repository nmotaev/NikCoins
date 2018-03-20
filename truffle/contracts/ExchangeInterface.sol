pragma solidity ^0.4.18;

contract ExchangeInterface {
    function sellTokens(uint amount) internal returns (bool);
    function buyTokens (address from, uint amount) public payable returns (bool);
    function setTokenManager(address _tokenManager) public;
}
