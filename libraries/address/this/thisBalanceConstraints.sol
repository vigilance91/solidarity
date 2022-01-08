// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";

import "./thisBalanceLogic.sol";
//import "https://github.com/vigilance91/solidarity/libraries/address/this/thisBalanceLogic.sol";

/// @title This (calling contract contract) Balance Contraints
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// @notice trivial utilities for constraining the state of the EVM (using require)
/// for address types, reverting on failure.
library thisBalanceConstraints
{
    using LogicConstraints for bool;
    //using AddressConstraints for address;
    
    using thisBalanceLogic for address;
    using thisBalanceLogic for uint256;
    
    //string private constant LIB_NAME = 'AddressBalanceConstraints: ';
    
    //function requireBalanceEqual(
        //address lhs,
        //address rhs
    //) internal view
    //{
        //lhs.equal(rhs).requireTrue(
            //"lhs.balance != rhs.balance"
        //);
    //}
    function requireThisBalanceNotEqual(
        address rhs
    )internal view
    {
        //lhs.isNotNullAndNotEqual(rhs);
        
        rhs.thisBalanceNotEqual().requireTrue(
            //_NAME.concatenate("lhs == rhs")
        );
    }
    // >
    function requireThisBalanceGreaterThan(
        address rhs
    )internal view
    {
        rhs.thisBalanceGreaterThan().requireTrue(
            //_NAME.concatenate('not >')
        );
    }
    // >=
    function requireThisBalanceGreaterThanOrEqual(
        address rhs
    )internal view
    {
        rhs.thisBalanceGreaterThanOrEqual().requireTrue(
            //_NAME.concatenate('not >=')
        );
    }
    // <
    function requireThisBalanceLessThan(
        address rhs
    )internal view
    {
        rhs.thisBalanceLessThan().requireTrue(
            //_NAME.concatenate('not <')
        );
    }
    // <=
    function requireThisBalanceLessThanOrEqual(
        address rhs
    )internal view
    {
        rhs.thisBalanceLessThanOrEqual().requireTrue(
            //_NAME.concatenate('not <=');
        );
    }
    function requireThisBalanceIsZero(
    )internal view
    {
        thisBalanceLogic.thisBalanceIsZero().requireTrue(
            //_NAME.concatenate('balance == 0')
        );
    }
    function requireThisBalanceGreaterThanZero(
    )internal view
    {
        thisBalanceLogic.thisBalanceGreaterThanZero().requireTrue(
            //_NAME.concatenate('balance == 0')
        );
    }
    //function isNotZero(
        //address account
    //) internal view
    //{
        //account.isNotZero().requireTrue(
            //"balance must not be 0"
        //);
    //}
    function requireThisBalanceGreaterThanZeroAndEqual(
        address rhs
    )internal view
    {
        rhs.thisBalanceGreaterThanZeroAndEqual().requireTrue();
    }
    function requireThisBalanceGreaterThanZeroAndNotEqual(
        address rhs
    )internal view
    {
        rhs.thisBalanceGreaterThanZeroAndNotEqual().requireTrue(
            //_NAME.concatenate('balance not > 0 or not > rhs')
        );
    }
    /**
    *array functions
    */
    //function requireBalanceGreaterThanZeroAndNotEqualArray(
        //address self,
        //address[] memory container
    //)internal view
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
    
    //
    //amounts, rhs of type uint256
    //
    function requireThisBalanceEqual(
        uint256 rhs
    )internal view
    {
        rhs.thisBalanceEqual().requireTrue();
    }
    // lhs.balance != rhs.balance
    function requireThisBalanceNotEqual(
        uint256 rhs
    )internal view
    {
        rhs.thisBalanceNotEqual().requireTrue();
    }
    function requireThisBalanceGreaterThan(
        uint256 rhs
    )internal view
    {
        rhs.thisBalanceGreaterThan().requireTrue();
    }
    function requireThisBalanceGreaterThanOrEqual(
        uint256 rhs
    )internal view
    {
        rhs.thisBalanceGreaterThanOrEqual().requireTrue();
    }
    
    function requireThisBalanceLessThan(
        uint256 rhs
    )internal view
    {
        rhs.thisBalanceLessThan().requireTrue();
    }
    function requireThisBalanceLessThanOrEqual(
        uint256 rhs
    )internal view
    {
        rhs.thisBalanceLessThanOrEqual().requireTrue();
    }
}