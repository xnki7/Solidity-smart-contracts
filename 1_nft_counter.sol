//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract NFTcount{
    uint public numberofNFT;

    function checkTotalNFT() public view returns(uint256){
        return numberofNFT;
    }

    function addNFT() public{
        numberofNFT += 1;
    }

    function deleteNFT() public{
        numberofNFT -= 1;
    }
}