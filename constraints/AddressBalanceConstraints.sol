// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.2 <0.8.0;

import "https://github.com/vigilance91/solidarity/constraints/LogicConstraints.sol";
import "https://github.com/vigilance91/solidarity/constraints/AddressConstraints.sol";

import "https://github.com/vigilance91/solidarity/utils/AddressBalanceLogic.sol";

/// @title Address Balance Contraints
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// @notice trivial utilities for constraining the state of the EVM (using require)
/// for address types, reverting on failure.
library AddressBalanceConstraints
{
    using LogicConstraints for bool;
    using AddressConstraints for address;
    
    using AddressBalanceLogic for address;
    
    //function requireBalanceEqual(
        //address lhs,
        //address rhs
    //) public pure
    //{
        //lhs.equal(rhs).requireTrue(
            //"addresses are not equal"
        //);
    //}
    function requireBalanceNotEqual(
        address lhs,
        address rhs
    ) public pure
    {
        //lhs.isNotNullAndNotEqual(rhs);
        
        lhs.balanceNotEqual(rhs).requireTrue(
            //"addresses are equal"
        );
    }
    // >
    function requireBalanceGreaterThan(
        address lhs,
        address rhs
    ) public pure
    {
        lhs.balanceGreaterThan(rhs).requireTrue(
        );
    }
    // >=
    function requireBalanceGreaterThanOrEqual(
        address lhs,
        address rhs
    ) public pure
    {
        lhs.balanceGreaterThanOrEqual(rhs).requireTrue(
        );
    }
    // <
    function requireBalanceLessThan(
        address lhs,
        address rhs
    ) public pure
    {
        lhs.balanceLessThan(rhs).requireTrue(
        );
    }
    // <=
    function requireBalanceLessThanOrEqual(
        address lhs,
        address rhs
    ) public pure
    {
        lhs.balanceLessThanOrEqual(rhs).requireTrue(
        );
    }
    
    function requireBalanceGreaterThanZero(
        address lhs
    ) public pure
    {
        lhs.balanceGreaterThanZero().requireTrue();
    }
    //function isNotZero(
        //address account
    //) public pure
    //{
        //account.isNotZero().requireTrue(
            //"balance must not be 0"
        //);
    //}
    function requireBalanceGreaterThanZeroAndEqual(
        address lhs,
        address rhs
    ) public pure
    {
        lhs.balanceGreaterThanZero().requireTrue();
        rhs.balanceGreaterThanZero().requireTrue();
        
        lhs.balanceEqual(rhs).requireTrue();
    }
    function requireBalanceGreaterThanZeroAndNotEqual(
        address lhs,
        address rhs
    ) public pure
    {
        lhs.balanceGreaterThanZeroAndNotEqual(rhs).requireTrue();
    }
    /**
    *array functions
    */
    //function requireBalanceGreaterThanZeroAndNotEqualArray(
        //address self,
        //address[] memory container
    //) public pure
    //{
        ////LogicConstraints.requireTrue(
            ////container.length > 0
        ////);
        
        //for(uint256 i = 0; i < container.length; i++){
            //address rhs = container[i];
            ////self.balanceGreaterThanZeroAndNotEqual(rhs).requireTrue();
            ////self.balanceNotEqual(rhs).requireTrue();
        //}
    //}
}