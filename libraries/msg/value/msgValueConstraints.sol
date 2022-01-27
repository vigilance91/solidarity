// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";

import "https://github.com/vigilance91/solidarity/libraries/msg/value/msgValueLogic.sol";
/// 
/// @title msg.value Contraints, where right hand operands is type Uint256
/// @author Tyler R. Drury - 27/4/2021, All Rights Reserved
/// @notice trivial utilities for constraining the state of the EVM (using require)
/// based on the value of msg.value where the right-hand side (RHS) value being compared is a uint256
/// 
library msgValueConstraints
{
    using logicConstraints for bool;

    using msgValueLogic for uint256;
    
    using uint256Constraints for uint256;
    
    //string private constant _NAME = " - msgValueConstraints: ";
    
    function requireMsgValueEqual(
        uint256 rhs
    )internal view
    {
        msg.value.requireEqual(
            rhs
        );
    }
    function requireMsgValueNotEqual(
        uint256 rhs
    )internal view
    {
        msg.value.requireNotEqual(
            rhs
        );
    }
    //msg.value == 0, this should never be used, since a function which requires a msg.value of  0 is a non-payable Function
    //and such behaviour is compiler enforced
    function requireMsgValueGreaterThanZero(
    )internal view
    {
        msg.value.requireGreaterThanZero(
            //''
        );
    }
    //msg.value != 0
    function requireMsgValueIsZero(
    )internal view
    {
        msg.value.requireIsZero(
            //''
        );
    }
    /**
    * >
    */
    function requireMsgValueGreaterThan(
        uint256 rhs
    )internal view
    {
        msg.value.requireGreaterThan(
            rhs
            //""
        );
    }
    /**
    * >=
    */
    function requireMsgValueGreaterThanOrEqual(
        uint256 rhs
    )internal view
    {
        msg.value.requireGreaterThanOrEqual(
            rhs
        );
    }
    /**
    * <
    */
    function requireMsgValueLessThan(
        uint256 rhs
    )internal view
    {
        msg.value.requireLessThan(
            rhs
        );
    }
    /**
    * <=
    */
    function requireMsgValueLessThanOrEqual(
        uint256 rhs
    )internal view
    {
        msg.value.requireLessThanOrEqual(
            rhs
        );
    }
    //msg.value != 0 && msg.value == rhs
    function requireMsgValueEqualAndNonZero(
        uint256 rhs
    )internal view
    {
        (msgValueLogic.msgValueGreaterThanZero() && rhs.msgValueEqual()).requireTrue(
        );
    }
    //msg.value != 0 && msg.value != rhs
    function requireMsgValueNotEqualAndNonZero(
        uint256 rhs
    )internal view
    {
        (msgValueLogic.msgValueGreaterThanZero() && rhs.msgValueNotEqual()).requireTrue();
    }
    /*
    //msg.value != 0 && msg.value > rhs
    function requireMsgValueGreaterThanAndNonZero(
        uint256 rhs
    )internal view
    {
        (msgValueLogic.msgValueGreaterThanZero() && rhs.msgValueGreaterThan()).requireTrue();
    }
    //msg.value != 0 && msg.value >= rhs
    function requireMsgValueGreaterThanOrEqualAndNonzero(
        uint256 rhs
    )internal view
    {
        (msgValueLogic.msgValueGreaterThanZero() && rhs.msgValueGreaterThanOrEqual()).requireTrue(
            //''
        );
    }
    */
    //msg.value != 0 && msg.value < rhs
    function requireMsgValueLessThanAndNonZero(
        uint256 rhs
    )internal view
    {
        (msgValueLogic.msgValueGreaterThanZero() && rhs.msgValueLessThan()).requireTrue();
    }
    //msg.value != 0 && msg.value <= rhs
    function requireMsgValueLessThanOrEqualAndNonzero(
        uint256 rhs
    )internal view
    {
        (msgValueLogic.msgValueGreaterThanZero() && rhs.msgValueLessThanOrEqual()).requireTrue();
    }
    
    //function requireMsgValueInRange(
        //uint256 min,
        //uint256 max
    //)internal view
    //{
        //msg.value.inRange(min, max).requireTrue(
        //);
    //}
    
    //function requireMsgValueInXRange(
        //uint256 min,
        //uint256 max
    //)internal view
    //{
        //msg.value.inXRange(min, max).requireTrue(
        //);
    //}
    /**
    *array functions
    */
    //function notZeroAndNotEqualArray(
        //uint256[] memory container
    //)internal view
    //{
        //for(uint256 i = 0; i < container.length; i++){
            //address rhs = container[i];
            //msg.sender.notZeroAndNotEqual(rhs);
        //}
    //}
}