// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    address owner;

    // 一个mapping来存储候选人的得票数
    mapping(string => uint256) private votes;
    mapping(string => bool) private seen; // 是否已记录为候选人
    string[] private condidates;    // 候选人列表

    constructor() {
        owner = msg.sender;
    }

    // 一个vote函数，允许用户投票给某个候选人
    function vote(string calldata condidate) external {
        if (!seen[condidate]) {
            seen[condidate] = true;
            condidates.push(condidate);
        }
        votes[condidate] +=1;
    }
    // 一个getVotes函数，返回某个候选人的得票数
    function getVotes(string calldata condidate) external view returns (uint256) {
        return votes[condidate];
    }

    // 一个resetVotes函数，重置所有候选人的得票数
    function resetVotes() external {
        require(owner == msg.sender, "not owner");
        for (uint256 i = 0; i < condidates.length; i++) {
            votes[condidates[i]] = 0;
            seen[condidates[i]] = false;
        }
        delete condidates;       
    }

}