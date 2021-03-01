// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.2 <0.8.0;

//import "https://github.com/vigilance91/solidarity/constraints/AddressBalanceConstraints.sol";

/// @title Msg.sender Balance Contraints where right hand operands is type Uint256
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// @notice trivial utilities for constraining the state of the EVM (using require)
/// based on the value of msg.sender.balance where the right-hand side (RHS) value being compared is a uint256
library MsgSenderBalanceUint256Constraints
{
    //using LogicalConstraints for bool;
    using AddressBalanceUint256Logic for address;
    
    function requireSenderBalanceEqual(
        uint256 rhs
    ) public view{
        msg.sender.requireBalanceEqual(rhs);
    }
    function requireSenderBalanceNotEqual(
        uint256 rhs
    ) public view
    {
        msg.sender.requireBalanceNotEqual(rhs);
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