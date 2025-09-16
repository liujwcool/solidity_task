// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Roma2Interger {

    function fromRoman(string calldata roman) external pure returns (uint256) {
        bytes memory b = bytes(roman);
        require(b.length > 0, "empty");
        uint256 total = 0;
        uint256 i = 0;
        while (i < b.length) {
            uint256 v = _val(b[i]);
            if (i + 1 < b.length) {
                uint256 vn = _val(b[i + 1]);
                if (_isSubtractive(b[i], b[i + 1], v, vn)) {
                    total += (vn - v);
                    i += 2;
                    continue;
                }
            }
            total += v;
            i++;
        }
        return total;
    }

    function _val(bytes1 c) private pure returns (uint256) {
        if (c == 'I' || c == 'i') return 1;
        if (c == 'V' || c == 'v') return 5;
        if (c == 'X' || c == 'x') return 10;
        if (c == 'L' || c == 'l') return 50;
        if (c == 'C' || c == 'c') return 100;
        if (c == 'D' || c == 'd') return 500;
        if (c == 'M' || c == 'm') return 1000;
        revert("invalid roman char");
    }

    function _isSubtractive(bytes1 c, bytes1 n, uint256 v, uint256 vn) private pure returns (bool) {
        if (v >= vn) return false;
        if ((c == 'I' || c == 'i') && (n == 'V' || n == 'v' || n == 'X' || n == 'x')) return true;
        if ((c == 'X' || c == 'x') && (n == 'L' || n == 'l' || n == 'C' || n == 'c')) return true;
        if ((c == 'C' || c == 'c') && (n == 'D' || n == 'd' || n == 'M' || n == 'm')) return true;
        revert("invalid subtractive pair");
    }
}