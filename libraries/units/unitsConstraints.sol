// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";

import "./unitsLogic.sol";
//import "https://github.com/vigilance91/solidarity/libraries/units/unitsLogic.sol";
/// 
/// @title Unit Constraints Library
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @notice This library provides trivial functions for constraining
/// the state of the EVM (using require) based on arbitrary denominations of ether,
/// reverting on failure.
/// todo: make public, to reduce bytecode size?
/// 
library unitsConstraints
{
    using LogicConstraints for bool;
    
    using uint256Constraints for uint256;
    
    using SafeMath for uint256;
    
    //string private constant _NAME = ' unitConstraints: ';
    
    function requireIsUnitKey(
        bytes32 key
    )internal pure
    {
        units.isUnitKey(key).requireTrue(
            "invalid key"
        );
    }
    function requireNotUnitKey(
        bytes32 key
    )internal pure
    {
        units.isUnitKey(key).requireFalse(
            "is key"
        );
    }
    //string private constant _NAME = ' unitConstraints: ';
    //
    //reverts if `lhs` is 1 BABBAGE or greater
    function requireWeiDenomination(
        uint256 amount
    )internal pure
    {
        unitsLogic.isWeiDenomination(amount).requireTrue(
            'invalid denomination'
        );
    }
    //function requireWeiDenomination(
        //uint256 amount
    //)internal pure
    //{
        //unitsLogic.isWeiDenomination(amount).requireFalse(
            //'cannot be denomination'
        //);
    //}
    function requireUnitsZero(
        uint256 lhs,
        uint256 units
    )internal pure
    {
        requireWeiDenomination(units);
        
        (lhs < units).requireTrue(
            'funds in excess'
        );
    }
    //
    // >, >=
    //
    function requireUnitsGreaterThan(
        uint256 lhs,
        uint256 amount,
        uint256 units
    )internal pure
    {
        requireWeiDenomination(units);
        
        lhs.requireGreaterThan(
            amount.mul(units)
            //_NAME.concatentate('insufficient funds')
        );
    }
    function requireUnitsGreaterThanOrEqual(
        uint256 lhs,
        uint256 amount,
        uint256 units
    )internal pure
    {
        requireWeiDenomination(units);
        
        lhs.requireGreaterThanOrEqual(
            amount.mul(units)
            //_NAME.concatentate('funds in excess')
        );
    }
    //using units for uint256;
    //
    // <, <=
    //
    function requireUnitsLessThan(
        uint256 lhs,
        uint256 amount,
        uint256 units
    )internal pure
    {
        requireWeiDenomination(units);
        
        lhs.requireLessThan(
            amount.mul(units)
            //_NAME.concatentate('funds in excess')
        );
    }
    function requireUnitsLessThanOrEqual(
        uint256 lhs,
        uint256 amount,
        uint256 units
    )internal pure
    {
        requireWeiDenomination(units);
        
        lhs.requireLessThanOrEqual(
            amount.mul(units)
            //_NAME.concatentate('funds in excess')
        );
    }
    /*
    function requireInRangeUnits(
        uint256 lhs,
        uint256 min,
        uint256 max,
        uint256 units
    )internal pure
    {
        lhs.requireInRange(
            min.mul(units),
            max.mul(units)
            //_NAME.concatentate('funds not in range')
        );
    }
    function requireInXRangeUnits(
        uint256 lhs,
        uint256 min,
        uint256 max,
        uint256 units
    )internal pure
    {
        requireWeiDenomination(units);
        
        lhs.requireInXRange(
            min.mul(units),
            max.mul(units)
            //_NAME.concatentate('funds not in range')
        );
    }
    */
}