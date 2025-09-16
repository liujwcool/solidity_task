// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Reverse {
    function reverseString(string memory _input) public pure returns (string memory) {
        bytes memory b = bytes(_input);
        uint len = b.length;
        if (len < 1) return _input;

        for (uint i = 0; i < len / 2; i++) {
            bytes1 tmp = b[i];
            b[i] = b[len -1 -i];
            b[len -1 -i] = tmp;
        }

        return string(b);
    }
}