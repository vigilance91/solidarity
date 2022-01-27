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
    using logicConstraints for bool;
    
    using uint256Constraints for uint256;
    
    using SafeMath for uint256;
    
    //string private constant _NAME = ' unitConstraints: ';
    
    string private constant _ERR_IS_KEY =  string(
        abi.encodePacked(
            _NAME,
        )
    );
    string private constant _ERR_IS_NOT_KEY = string(
        abi.encodePacked(
            _NAME,
            "invalid key: "
        )
    );
    string private constant _ERR_INVALID_DENOMINATION = string(
        abi.encodePacked(
            _NAME,
            'invalid denomination'
        )
    );
    
    function requireIsUnitKey(
        bytes32 key
    )internal pure
    {
        units.isUnitKey(key).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_IS_NOT_KEY,
                    key
                )
            )
        );
    }
    function requireNotUnitKey(
        bytes32 key
    )internal pure
    {
        units.isUnitKey(key).requireFalse(
            string(
                abi.encodePacked(
                    _ERR_IS_KEY,
                    key
                )
            )
        );
    }
    //
    //reverts if `lhs` is 1 BABBAGE or greater
    function requireWeiDenomination(
        uint256 amount
    )internal pure
    {
        unitsLogic.isWeiDenomination(amount).requireTrue(
            _ERR_INVALID_DENOMINATION
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
            //_ERR_ISF  //'insufficient funds'
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
            //_ERR_EXCESS_FUNDS
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
            //_ERR_EXCESS_FUNDS
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
            //_ERR_EXCESS_FUNDS
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
            //string(
                //abi.encodePacked(
                    //_ERR_NOT_IN_RANGE,
                //)
            //)
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
            max.mul(units),
            //string(
                //abi.encodePacked(
                    //_ERR_NOT_IN_XRANGE,
                //)
            //)
        );
    }
    */
}