//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract VendingMachine{
    address payable public owner;
    mapping (address => uint) public donutBalances;

    constructor(){
        owner = payable(msg.sender);
        donutBalances[address(this)] = 100; //address(this) refers to the address of smart contract.
        // msg.sender refers to the address of invoker.
    }

    function getVendingMachineBalance() public view returns(uint){
        return donutBalances[address(this)];
    }

    function restock(uint amount) public{
        require(msg.sender == owner, "Only the owner can restock this machine");
        donutBalances[address(this)] = donutBalances[address(this)] + amount;
    }

    function purchase(uint amountofdonuts) public payable{
        require(msg.value >= amountofdonuts*2 ether, "You must pay at least 2 ether per donut");
        require(donutBalances[address(this)] >= amountofdonuts, "Not enough donuts in machine !!");
        uint rem_amount = msg.value - (amountofdonuts*2 ether);
        payable(msg.sender).transfer(rem_amount);
        donutBalances[address(this)] = donutBalances[address(this)] - amountofdonuts;
        donutBalances[msg.sender] = donutBalances[msg.sender] + amountofdonuts;

    }
}