# Decentralized-Lottery-Smart-Contract

This Solidity smart contract implements a simple decentralized lottery system on the Ethereum blockchain. Participants can enter the lottery by sending exactly `0.001 ETH` to the contract. Once there are at least 3 participants, the contract manager can select a random winner who receives the total pooled Ether.

## Features
Permissioned Access: Only the contract manager (deployer) can view the balance and select a winner.

Participant Entry: Users can join the lottery by sending exactly `0.001 ETH` to the contract address.

Random Winner Selection: A pseudo-random number is generated using block.prevrandao, block.timestamp, and the participant count to select a winner.

Event Emission: Emits events when a participant enters and when a winner is selected.

Fallback Protection: Includes a fallback() function that reverts incorrect or unintended function calls.

Contract Functions
### `receive() external payable`
Accepts 0.001 ETH and registers the sender as a participant.
Emits ParticipantEntered.

### `fallback() external payable`
Reverts any incorrect or undefined function calls.

### `getBalance() public view returns (uint256)`
Returns the current contract balance.
Callable only by the manager.

### `selectWinner() public`
Selects a random winner from the participant pool.
Transfers the entire contract balance to the winner.
Resets the participant list.
Callable only by the manager and requires at least 3 participants.

### `getParticipants() public view returns (address payable[] memory)`
Returns the list of current participants.

# Events
### `ParticipantEntered(address indexed participant, uint256 amount)`
### `WinnerSelected(address indexed winner, uint256 prizeAmount)`

# Important Notes
The randomness logic is not cryptographically secure and should not be used in production environments where fairness is critical.
This contract is intended for educational and demonstration purposes.
