// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.2 <0.8.0;

import "https://github.com/vigilance91/solidarity/utils/AddressBalanceLogic.sol";

/// @title Msg.sender Balance Logic where right operand is of Uint256 type
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// @notice trivial library for logical or bitwise operations on the balances of the sender of a message to a contract,
/// which is not provided natively by Solidity,
/// where the right had operand is of type uint256 and corresponds to some arbitrary value checked to contrain the EVM state,
/// which does not have to be the value of a wallet's (or contract's) address
library MsgSenderBalanceUint256Logic
{
    using uint256Logic for uint256;
    
    function senderBalanceEqual(
        uint256 rhs
    ) public view
        returns(bool)
    {
        return msg.sender.balance.equal(rhs);
    }
    function senderBalanceNotEqual(
        uint256 rhs
    ) public view
        returns(bool)
    {
        return msg.sender.balance.notEqual(rhs);
    }
    
    function senderBalanceGreaterThan(
        uint256 rhs
    ) public view
        returns(bool)
    {
        return msg.sender.balance.greaterThan(rhs);
    }
    function senderBalanceGreaterThanOrEqualTo(
        uint256 rhs
    ) public view
        returns(bool)
    {
        return msg.sender.balance.greaterThanOrEqualTo(rhs);
    }
    
    function senderBalanceLessThan(
        uint256 rhs
    ) public view
        returns(bool)
    {
        return msg.sender.balance.lessThan(rhs);
    }
    function senderBalanceLessThanOrEqualTo(
        uint256 rhs
    ) public view
        returns(bool)
    {
        return msg.sender.balance.lessThanOrEqualTo(rhs);
    }
    
    function senderBalanceGreaterThanZero(
    ) public view
        returns(bool)
    {
        return msg.sender.balance.greaterThanZero();
    }
    function senderBalanceGreaterThanZeroAndEqual(
        uint256 rhs
    ) public view
        returns(bool)
    {
        return msg.sender.balance.greaterThanZeroAndEqual(rhs);
    }
    function senderBalanceGreaterThanZeroAndNotEqual(
        uint256 rhs
    ) public view
        returns(bool)
    {
        return msg.sender.balance.greaterThanZeroAndNotEqual(rhs);
    }
    
    function balanceGreaterThan(
        uint256 rhs
    )public pure
        returns(bool)
    {
        return msg.sender.balance.greaterThan(rhs);
    }
    function balanceGreaterThanOrEqual(
        uint256 rhs
    )public pure
        returns(bool)
    {
        return msg.sender.balance.greaterThanOrEqual(rhs);
    }
    
    function balanceLessThan(
        uint256 rhs
    )public pure
        returns(bool)
    {
        return msg.sender.balance.lessThan(rhs);
    }
    function balanceLessThanOrEqual(
        uint256 rhs
    )public pure
        returns(bool)
    {
        return msg.sender.balance.lessThanOrEqual(rhs);
    }
    
    /**
    *array functions for address balance logic
    */
    //function senderBalanceGreaterThanZeroAndEqualArray(
        //address[] memory container
    //) public pure
    //{
        //bool ret = true;
        
        //for(uint256 i = 0; i < container.length; i++){
            //address rhs = container[i];
            //if(!msg.sender.greaterThanZeroAndEqual(rhs) || msg.sender.equal(rhs)){
                //ret = false;
                //break;
            //}
        //}
        //return ret;
    //}
    //function senderBalanceGreaterThanZeroAndEqualArray(
        //address[] memory container
    //) public pure
    //{
        //return msg.sender.greaterThanZeroAndEqualArray(container);
    //}
}