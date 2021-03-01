// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.2 <0.8.0;

import "https://github.com/vigilance91/solidarity/utils/AddressBalanceLogic.sol";

/// @title Msg.sender Balance Logic where right operand is of type Addresses
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// @notice trivial library for logical operations on the balances of msg.sender,
///  where the right-hand side (RHS) value is an address to which their balances are compared.
library MsgSenderBalanceAddressLogic
{
    using AddressBalanceLogic for address;
    
    function senderBalanceEqual(
        address rhs
    ) public view
        returns(bool)
    {
        return msg.sender.equal(rhs);
    }
    function senderBalanceNotEqual(
        address rhs
    ) public view
        returns(bool)
    {
        return msg.sender.notEqual(rhs);
    }
    
    function senderBalanceGreaterThan(
        address rhs
    ) public view
        returns(bool)
    {
        return msg.sender.greaterThan(rhs);
    }
    function senderBalanceGreaterThanOrEqual(
        address rhs
    ) public view
        returns(bool)
    {
        return msg.sender.greaterThanOrEqual(rhs);
    }
    
    function senderBalanceLessThan(
        address rhs
    ) public view
        returns(bool)
    {
        return msg.sender.lessThan(rhs);
    }
    function senderBalanceLessThanOrEqualTo(
        address rhs
    ) public view
        returns(bool)
    {
        return msg.sender.lessThanOrEqual(rhs);
    }
    
    function senderBalanceGreaterThanZero(
    ) public view
        returns(bool)
    {
        return msg.sender.greaterThanZero();
    }
    function senderBalanceGreaterThanZeroAndEqual(
        address account
    ) public view
        returns(bool)
    {
        return msg.sender.greaterThanZeroAndEqual(account);
    }
    function senderBalanceGreaterThanZeroAndNotEqual(
        address rhs
    ) public view
        returns(bool)
    {
        return msg.sender.greaterThanZeroAndNotEqual(rhs);
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