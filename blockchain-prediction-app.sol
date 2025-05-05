// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract EtherTransfer {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Function to transfer Ether from this contract to another address
    function transferEther(address payable _recipient, uint256 _amount) external {
        require(msg.sender == owner, "Only owner can transfer");
        require(address(this).balance >= _amount, "Insufficient balance");

        (bool success, ) = _recipient.call{value: _amount}("");
        require(success, "Transfer failed");
    }

    // Function to check the contract's Ether balance
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
