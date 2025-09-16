// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 在升序数组 a 中查找 target。
// 返回是否找到及其下标（若未找到，index 无意义）。
contract BinarySearch {
    function binarySearch(uint256[] memory a, uint256 target)
        public
        pure
        returns (bool found, uint256 index)
    {
        uint256 l = 0;
        uint256 r = a.length; // 开区间右边界
        while (l < r) {
            uint256 m = (l + r) >> 1;
            if (a[m] < target) {
                l = m + 1;
            } else {
                r = m;
            }
        }
        if (l < a.length && a[l] == target) {
            return (true, l);
        }
        return (false, 0);
    }
}