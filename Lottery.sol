//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract Lottery{
    address public owner;
    address payable[] public players;
    uint public lotteryId;
    mapping(uint => address payable) public LotteryWinnerHistory;

    constructor(){
        owner = msg.sender;
        lotteryId=1;
    }

    // function getWinnerById(uint lotteryId) public view returns(address payable){
    //     return LotteryWinnerHistory[lotteryId];
    // }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function getPlayers() public view returns(address payable[] memory){
        return players;
    }

    function enter() public payable {
        require(msg.value >= 1 ether, "Pay the bear minimum entry fee of 1 ether");

        //address of player entering lottery
        players.push(payable(msg.sender));
    }

    function getRandomNumber() public view returns(uint){
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)) );
    }

    function pickWinner() public onlyOwner{
        
        uint index = getRandomNumber() % players.length;
        players[index].transfer(address(this).balance);

        LotteryWinnerHistory[lotteryId] = players[index];
        lotteryId++;
        

        //reset the state of contract
        players = new address payable[](0);
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only Owner of smart contract has access to this function");
        _;
    }


}