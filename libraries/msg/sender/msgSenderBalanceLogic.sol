// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/vigilance91/solidarity/libraries/address/addressBalanceLogic.sol";
/// 
/// @title Msg.sender Balance Logic where right operand is of Uint256 type
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// @notice trivial library for logical or bitwise operations on the balances of the sender of a message to a contract,
/// which is not provided natively by Solidity,
/// where the right had operand is of type uint256 and corresponds to some arbitrary value checked to contrain the EVM state,
/// which does not have to be the value of a wallet's (or contract's) address
/// 
library msgSenderBalanceLogic
{
    using addressBalanceLogic for uint256;
    /**
    *LHS is msg.sender.balance and RHS operatnd type uint256
    */
    function senderBalanceEqual(
        uint256 amount
    )internal pure returns(
        bool
    ){
        return msg.sender.balanceEqual(amount);
    }
    // lhs.balance != rhs.balance
    function senderBalanceNotEqual(
        uint256 amount
    )internal pure returns(
        bool
    ){
        return msg.sender.balanceNotEqual(amount);
    }
    function senderBalanceGreaterThan(
        uint256 amount
    )internal pure returns(
        bool
    ){
        return msg.sender.balanceGreaterThan(amount);
    }
    function senderBalanceGreaterThanOrEqual(
        uint256 amount
    )internal pure returns(
        bool
    ){
        return msg.sender.balanceGreaterThanOrEqual(amount);
    }
    
    function senderBalanceLessThan(
        uint256 amount
    )internal pure returns(
        bool
    ){
        return msg.sender.balanceLessThan(amount);
    }
    function senderBalanceLessThanOrEqual(
        uint256 amount
    )internal pure returns(
        bool
    ){
        return msg.sender.balanceLessThanOrEqual(amount);
    }
}