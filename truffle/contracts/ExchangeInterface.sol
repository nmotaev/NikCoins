pragma solidity ^0.4.18;

contract ExchangeInterface {
    function sellTokens(uint amount) public payable returns (bool);
    function buyTokens(uint amount) public payable returns (bool);
    function setTokenManager(address _tokenManager) public returns (bool);
}
