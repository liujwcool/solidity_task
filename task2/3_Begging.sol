// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Begging  is Ownable {

    // 记录每个捐赠者的捐赠金额
    mapping (address => uint256) public donations;

    // 构造函数设置合约所有者
    constructor() Ownable(msg.sender) {}

    // 捐赠函数
    function donate() public payable {
        require(msg.value > 0, "Donation amount must be greater than 0");
        donations[msg.sender] += msg.value;
    }

    // 把合约账户的金额全部取走
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "balance must be greater than 0");

        // 使用 transfer 发送资金
        payable(owner()).transfer(balance);
    }

    // 查询捐赠者的捐赠金额
    function getDonation(address donor) public view returns ( uint256 ) {
        return donations[donor];
    } 

        // 接收以太币的回退函数
    receive() external payable {
        donate();
    }
    
    // 获取合约余额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}