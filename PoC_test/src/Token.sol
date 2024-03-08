// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {MathDelea as math} from "./LibMath.sol";

contract TrainingToken is ERC20, ReentrancyGuard {
    uint256 public constant INITIAL_SUPPLY = 1000 * (10 ** 18); // 1000 tokens
    uint256 private constant a = 100;
    uint128 private constant u = 1e6;

    constructor() ERC20("TrainingToken", unicode"TTK") {
        _mint(address(this), INITIAL_SUPPLY);
    }

    function train(uint256 x) public nonReentrant {
        require(x > 0, unicode"x doit être supérieur à 0");
        uint256 R = balanceOf(address(this));
        uint256 reward = distribution(R, x);
        _transfer(address(this), msg.sender, reward);
    }

    function infere(uint256 amount) public nonReentrant {
        require(amount > 0, unicode"Le montant doit être supérieur à 0");
        _transfer(msg.sender, address(this), amount);
    }

    function distribution(uint256 R, uint256 update) private pure returns (uint256) {
        int128 supply = int128(uint128(((R << 128) / 1e18) >> 64));
        int128 result = math.mul(
            supply,
            math.sub(
                math.fromUInt(1),
                math.exp(-math.div(math.fromUInt(update), math.mul(math.fromUInt(a), math.fromUInt(u))))
            )
        );
        int128 entier = result >> 64;
        int128 decimal = math.mul(math.sub(result, math.fromInt(entier)), math.fromInt(1e18)) >> 64;
        uint256 token = uint256(int256(entier * 1e18 + decimal));
        return token;
    }
}
