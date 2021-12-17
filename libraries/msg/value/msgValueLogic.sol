// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Logic.sol";

/// @title Msg.sender Balance Logic where right operand is of Uint256 type
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// @notice trivial library for logical or bitwise operations on the balances of the sender of a message to a contract,
/// which is not provided natively by Solidity,
/// where the right had operand is of type uint256 and corresponds to some arbitrary value checked to contrain the EVM state,
/// which does not have to be the value of a wallet's (or contract's) address
library msgValueLogic
{
    using uint256Logic for uint256;
    /**
    *RHS operatnd type uint256
    */
    function msgValueEqual(
        uint256 amount
    )internal view returns(
        bool
    ){
        return msg.value.equal(amount);
    }
    // lhs.balance != rhs.balance
    function msgValueNotEqual(
        uint256 amount
    )internal view returns(
        bool
    ){
        return msg.value.notEqual(amount);
    }
    function msgValueGreaterThan(
        uint256 amount
    )internal view returns(
        bool
    ){
        return msg.value.greaterThan(amount);
    }
    function msgValueGreaterThanOrEqual(
        uint256 amount
    )internal view returns(
        bool
    ){
        return msg.value.greaterThanOrEqual(amount);
    }
    
    function msgValueLessThan(
        uint256 amount
    )internal view returns(
        bool
    ){
        return msg.value.lessThan(amount);
    }
    function msgValueLessThanOrEqual(
        uint256 amount
    )internal view returns(
        bool
    ){
        return msg.value.lessThanOrEqual(amount);
    }
    function msgValueEqualZero(
    )internal view returns(
        bool
    ){
        return msg.value.equal(uint256Logic.ZERO);
    }
    function msgValueGreaterThanZero(
    )internal view returns(
        bool
    ){
        return msg.value.greaterThanZero();
    }
}