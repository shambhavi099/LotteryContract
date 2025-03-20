pragma solidity ^0.8.17;

contract Lottery {
    address[] public participants;
    address public winner;
    
    function enter() public payable {
        require(msg.value > 0, "Send ETH to enter");
        participants.push(msg.sender);
    }
    
    function pickWinner() public {
        require(participants.length > 0, "No participants");
        uint randomIndex = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, participants.length))) % participants.length;
        winner = participants[randomIndex];
        payable(winner).transfer(address(this).balance);
        delete participants;
    }
    
    function getParticipants() public view returns (address[] memory) {
        return participants;
    }
}
