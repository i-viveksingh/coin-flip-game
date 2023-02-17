// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CoinFlip {
    address public owner;
    uint public betAmount;
    mapping(address => uint) public playerBets;
    
    constructor() {
        owner = msg.sender;
        betAmount = 1 ether;
    }
    
    function flipCoin() public payable {
        require(msg.value == betAmount, "Bet amount should be 1 ether.");
        
        if (block.timestamp % 2 == 0) {
            payable(msg.sender).transfer(betAmount * 2);
        }
        
        playerBets[msg.sender] += msg.value;
    }
    
    function withdraw() public {
        require(msg.sender == owner, "Only the owner can withdraw the balance.");
        
        payable(owner).transfer(address(this).balance);
    }
}
