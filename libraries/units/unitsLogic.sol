// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Logic.sol";

import "./units.sol";
//import "https://github.com/vigilance91/solidarity/libraries/units/units.sol";
/// 
/// @title Unit Logic Library
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @notice This library provides trivial functions for constraining
/// the state of the EVM (using require) based on arbitrary ranges/denominations of ether,
/// reverting on failure.
/// 
library unitsLogic
{
    using SafeMath for uint256;
    
    using uint256Logic for uint256;
    
    //using units for uint256;
    
    function isWeiDenomination(
        uint256 amount
    )internal pure returns(
        bool
    ){
        return (
            //amount == units.WEI ||
            amount == units.BABBAGE ||
            amount == units.LOVELACE ||
            amount == units.SHANNON ||
            amount == units.SZABO ||
            //
            amount == units.FINNEY ||
            amount == units.ETHER ||
            amount == units.GRAND ||
            //
            amount == units.GETHER ||
            amount == units.METHER ||
            amount == units.TETHER
        );
    }
    //
    // >, >=
    //
    function unitsGreaterThan(
        uint256 lhs,
        uint256 amount,
        uint256 units
    )internal pure returns(
        bool
    ){
        return lhs.greaterThan(
            amount.mul(units)
            //'insufficient funds'
        );
    }
    function unitsGreaterThanOrEqual(
        uint256 lhs,
        uint256 amount,
        uint256 units
    )internal pure returns(
        bool
    ){
        return lhs.greaterThanOrEqual(
            amount.mul(units)
            //'funds in excess'
        );
    }
    //using units for uint256;
    //
    // <, <=
    //
    function unitsLessThan(
        uint256 lhs,
        uint256 amount,
        uint256 units
    )internal pure returns(
        bool
    ){
        return lhs.lessThan(
            amount.mul(units)
            //'funds in excess'
        );
    }
    function unitsLessThanOrEqual(
        uint256 lhs,
        uint256 amount,
        uint256 units
    )internal pure returns(
        bool
    ){
        return lhs.lessThanOrEqual(
            amount.mul(units)
            //'funds in excess'
        );
    }
    /*
    function unitsInRange(
        uint256 lhs,
        uint256 min,
        uint256 max,
        uint256 units
    )internal pure
    {
        lhs.inRange(
            min.mul(units),
            max.mul(units)
        );
    }
    function unitsInXRange(
        uint256 lhs,
        uint256 min,
        uint256 max,
        uint256 units
    )internal pure returns(
        bool
    ){
        return lhs.inXRange(
            min.mul(units),
            max.mul(units)
        );
    }
    */
}