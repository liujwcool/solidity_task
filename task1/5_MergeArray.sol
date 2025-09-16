// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeArray {

    function Merge(uint256[] calldata a, uint256[] calldata b) public pure returns(uint256[] memory) {
        uint256 i;
        uint256 j;
        uint256 k;
        uint256 al = a.length;
        uint256 bl = b.length;
        uint256[] memory r = new uint256[](al + bl);

        while (i < al && j < bl) {
            if (a[i] <= b[j]) {
                r[k++] = a[i++];
            } else {
                r[k++] = b[j++];
            }
        }
        while (i < al) r[k++] = a[i++];
        while (j < bl) r[k++] = b[j++];
        return r;
    }
}