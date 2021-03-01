// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.2 <0.8.0;

import "https://github.com/vigilance91/solidarity/constraints/AddressBalanceConstraints.sol";

/// @title Msg.sender Balance Contraints where right hand operands is type Address
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// @notice trivial utilities for constraining the state of the EVM (using require)
/// based on the value of msg.sender.balance where the right-hand side (RHS) value is an address to which their balances are compared
library MsgSenderBalanceAddressConstraints
{
    //using LogicalConstraints for bool;
    using AddressBalanceConstraints for address;
    
    //function requireSenderBalanceEqual(
        //address rhs
    //) public view{
        //LogicConstraints.requireTrue(
            //msg.sender.requireEqual(rhs),
            "addresses are not equal"
        //);
    //}
    function requireSenderBalanceNotEqual(
        address rhs
    ) public view
    {
        msg.sender.requireNotEqual(rhs);
    }
    /**
    * >
    */
    function requireSenderBalanceGreaterThan(
        address rhs
    ) public view
    {
        msg.sender.requireBalanceGreaterThan(rhs);
    }
    /**
    * >=
    */
    function requireSenderBalanceGreaterThanOrEqual(
        address rhs
    ) public view
    {
        msg.sender.requireBalanceGreaterThanOrEqual(rhs);
    }
    /**
    * <
    */
    function requireSenderBalanceLessThan(
        address rhs
    ) public view
    {
        msg.sender.requireBalanceLessThan(rhs);
    }
    /**
    * <=
    */
    function requireSenderBalanceLessThanOrEqual(
        address rhs
    ) public view
    {
        msg.sender.requireBalanceLessThanOrEqual(rhs);
    }
    function requireSenderBalanceGreaterThanZero(
    ) public view
    {
        msg.sender.requireBalanceGreaterThanZero();
    }
    
    function requireSenderBalanceGreaterThanZeroAndEqual(
        address rhs
    ) public view
    {
        msg.sender.requireBalanceGreaterThanZeroAndEqual(rhs);
    }
    function requireSenderBalanceGreaterThanZeroAndNotEqual(
        address rhs
    ) public view
    {
        msg.sender.requireBalanceGreaterThanZeroAndNotEqual(rhs);
    }
    /**
    *array functions
    */
    //function notThisAndNotNullArray(
        //address self,
        //address[] memory container
    //) public view
    {
        //for(uint256 i = 0; i < container.length; i++){
            //address rhs = container[i];
            //isNotThisAndNotNull(self, rhs);
            //notEqual(self, rhs);
        //}
    //}
}

library MsgSenderBalanceUint256Constraints
{
    //using LogicalConstraints for bool;
    using AddressBalanceUint256Logic for address;
    
    //function requireSenderBalanceEqual(
        //uint256 rhs
    //) public view{
        //LogicConstraints.requireTrue(
            //msg.sender.requireEqual(rhs),
            "addresses are not equal"
        //);
    //}
    function requireSenderBalanceNotEqual(
        uint256 rhs
    ) public view
    {
        msg.sender.requireNotEqual(rhs);
    }
    /**
    * >
    */
    function requireSenderBalanceGreaterThan(
        uint256 rhs
    ) public view
    {
        msg.sender.requireBalanceGreaterThan(rhs);
    }
    /**
    * >=
    */
    function requireSenderBalanceGreaterThanOrEqual(
        uint256 rhs
    ) public view
    {
        msg.sender.requireBalanceGreaterThanOrEqual(rhs);
    }
    /**
    * <
    */
    function requireSenderBalanceLessThan(
        uint256 rhs
    ) public view
    {
        msg.sender.requireBalanceLessThan(rhs);
    }
    /**
    * <=
    */
    function requireSenderBalanceLessThanOrEqual(
        uint256 rhs
    ) public view
    {
        msg.sender.requireBalanceLessThanOrEqual(rhs);
    }
    function requireSenderBalanceGreaterThanZero(
    ) public view
    {
        msg.sender.requireBalanceGreaterThanZero();
    }
    
    function requireSenderBalanceGreaterThanZeroAndEqual(
        uint256 rhs
    ) public view
    {
        msg.sender.requireBalanceGreaterThanZeroAndEqual(rhs);
    }
    function requireSenderBalanceGreaterThanZeroAndNotEqual(
        uint256 rhs
    ) public view
    {
        msg.sender.requireBalanceGreaterThanZeroAndNotEqual(rhs);
    }
    /**
    *array functions
    */
    //function notZeroAndNotEqualArray(
        //uint256[] memory container
    //) public view
    {
        //for(uint256 i = 0; i < container.length; i++){
            //address rhs = container[i];
            //msg.sender.notZeroAndNotEqual(rhs);
        //}
    //}
}