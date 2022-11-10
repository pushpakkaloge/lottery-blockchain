pragma solidity >=0.5.0 <0.9.0;


contract Lottery{
    address public manager;
    address payable[] public participants;

    constructor(){
        manager = msg.sender;
    }

    receive() external payable{
        participants.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
    }

    function selectWinner() public view returns (address){
        uint randomValue = random();
        address payable winner;
        uint winnerIndex = randomValue % participants.length;
        winner = participants[winnerIndex];

        return winner;
    }

}
