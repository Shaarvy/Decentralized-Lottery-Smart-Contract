// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Lottery {
    address public manager;
    address payable[] public participants;

    event ParticipantEntered(address indexed participant, uint256 amount);
    event WinnerSelected(address indexed winner, uint256 prizeAmount);

    constructor() {
        manager = msg.sender;
    }

    // Only accept exact 0.001 ether
    receive() external payable {
        require(msg.value == 0.001 ether, "Send exactly 0.001 ETH to participate");
        participants.push(payable(msg.sender));
        emit ParticipantEntered(msg.sender, msg.value);
    }

    // Optional fallback to handle incorrect function calls
    fallback() external payable {
        revert("Fallback: Function does not exist");
    }

    // View balance (only manager can call this)
    function getBalance() public view returns (uint256) {
        require(msg.sender == manager, "Only manager can view balance");
        return address(this).balance;
    }

    // Generate random number (not truly random — for demonstration only)
    function random() internal view returns (uint256) {
        return uint256(
            keccak256(
                abi.encodePacked(block.prevrandao, block.timestamp, participants.length)
            )
        );
    }

    // Select winner (only manager, at least 3 participants)
    function selectWinner() public {
        require(msg.sender == manager, "Only manager can select winner");
        require(participants.length >= 3, "At least 3 participants required");

        uint256 index = random() % participants.length;
        address payable winner = participants[index];

        winner.transfer(getBalance());

        // ✅ Reset the participants array correctly
        participants = new address payable[](0);
}


    // Get list of participants (for frontend/testing)
    function getParticipants() public view returns (address payable[] memory) {
        return participants;
    }
}
