// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Will {
    address public owner;
    address public recipient;
    uint startTime;
    uint lastVisited;
    uint waitingYears;

    constructor (address _recipient , uint _waitingYears) {
        owner = msg.sender;
        recipient = _recipient;
        waitingYears = _waitingYears * 365 days;
        startTime = block.timestamp;
        lastVisited = block.timestamp;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can Habdle this");
        _;
    }

    modifier onlyRecipient {
        require(msg.sender == recipient, "Only recipient can Handle this");
        _;
    }

    function Deposit () public payable onlyOwner {
        lastVisited = block.timestamp;
    }

    function changeRecipient ( address newRecipient ) public onlyOwner {
        recipient = newRecipient;
    }

    function ping() public onlyOwner {
        lastVisited = block.timestamp;
    }

    function pullout() external onlyRecipient {
        require(lastVisited < block.timestamp - waitingYears );
        payable(recipient).transfer(address(this).balance);
    }

}