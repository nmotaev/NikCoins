pragma solidity ^0.4.18;

contract ExchangeInterface {
    function sellTokens(address to, uint amount) public returns (bool success);
    function buyTokens(address from, uint amount) public returns (bool success);
    function setTokenManager(address _tokenManager) public returns (bool success);
}
