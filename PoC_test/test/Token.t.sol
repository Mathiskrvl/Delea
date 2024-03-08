// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "forge-std/console.sol";
import {MathDelea as math} from "../src/LibMath.sol";

contract TokenTest is Test {
    uint256 public constant INITIAL_SUPPLY = 1000 * 1e18;
    uint128 private constant a = 100;
    uint128 private constant u = 1e6;

    function test_eandpower() public {
        uint256 a1 = 1000 * 1e18;
        uint256 b = 1000 * (10 ** 18);
        assertEq(a1, b);
    }

    function test_supply_in_float() public view {
        int128 supply = int128(uint128(((INITIAL_SUPPLY << 128) / 1e18) >> 64));
        console.logInt(supply);
        // assertEq(supply, 0x3E80000000000000000);
    }

    function test_distri() public view {
        // uint256 R = INITIAL_SUPPLY;
        int128 R = int128(uint128(((INITIAL_SUPPLY << 128) / 1e18) >> 64));
        uint256 update = 1e6;
        int128 result = math.mul(
            R,
            math.sub(
                math.fromUInt(1),
                math.exp(-math.div(math.fromUInt(update), math.mul(math.fromUInt(a), math.fromUInt(u))))
            )
        );
        int128 entier = result >> 64;
        int128 decimal = math.mul(math.sub(result, math.fromInt(entier)), math.fromInt(1e18)) >> 64;
        uint256 token = uint256(int256(entier * 1e18 + decimal));
        console.logUint(token);
    }
}
