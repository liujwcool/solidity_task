// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntergerToRoma {
    function toRoman(uint256 num) public pure returns (string memory) {
        require(num >= 1 && num <= 3999, "out of range");

        uint16[13] memory values = [
            1000, 900, 500, 400,
            100,  90,  50,  40,
            10,   9,   5,   4,   1
        ];
        
        string[13] memory symbols = [
            "M","CM","D","CD",
            "C","XC","L","XL",
            "X","IX","V","IV","I"
        ];

        bytes memory out;
        for (uint256 i = 0; i < values.length; i++) {
            while (num >= values[i]) {
                num -= values[i];
                out = abi.encodePacked(out, symbols[i]);
            }
            if (num == 0) break;
        }
        return string(out);
    }
}