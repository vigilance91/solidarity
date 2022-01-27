// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";

/// @title msg.value Safe Math Library
/// @author Tyler R. Drury - 27/4/2021, All Rights Reserved
/// @dev arithmetic operation wrapper library with added overflow and underflow checks for msg.value
/// note: callvalue() can be used in assembly fo msg.value, remove uint256SafeMath,
/// replace with direct inline assembly with lhs of callvalue() to see if possible gains
/// 
library msgValueSafeMath
{
    using SafeMath for uint256;
    using uint256Constraints for uint256;
    
    //using stringUtilities for string;
    //string private constant _NAME = ' msgValueSafeMath: ';
    //
    //string private constant _OVERFLOW = _NAME.concatenate('overflow');
    //string private constant _UNDERFLOW = _NAME.concatenate('underflow');
    //string private constant _DIVIDE_BY_ZERO = _NAME.concatenate('divide by zero');
    //string private constant _MODULO_ZERO = _NAME.concatenate('modulo zero');
    ///
    /// @return {uint256} addition of msg.value and an unsigned integer,
    /// reverting on overflow
    /// @dev Safe convenience wrapper for `msg.value + x`
    ///
    function msgValueAdd(
        uint256 rhs
    )internal pure returns(
        uint256 ret
    ){
        return msg.value._add(
            rhs
        );
    }
    ///
    /// @return {uin256} subtraction of msg.value and an unsigned integer,
    /// reverting on underflow (when res is negative)
    /// @dev safe convenience wrapper for `msg.value - x`
    ///
    function msgValueSub(
        uint256 rhs
    )internal pure returns(
        uint256 ret
    ){
        return msg.value._sub(
            rhs
        );
    }
    ///
    /// @return {uint256} subtraction of msg.value and an unsigned integer,
    /// reverting with custom message on overflow (when the result is negative)
    /// @dev Safe convenience wrapper for `msg.value - x`, outputs additionl message
    ///
    function msgValueSub(
        uint256 rhs,
        string memory errorMessage
    )internal pure returns(
        uint256 ret
    ){
        return msg.value._sub(
            rhs,
            errorMessage
        );
    }
    ///
    /// @return {uint256} subtraction of msg.value from an unsigned integer,
    /// reverting with custom message on overflow (when the result is negative)
    /// @dev Safe convenience wrapper for `x - msg.value`, outputs additionl message
    ///
    function subMsgValue(
        uint256 lhs,
        string memory errorMessage
    )internal pure returns(
        uint256 ret
    ){
        return lhs._sub(
            msg.value,
            errorMessage
        );
    }
    ///
    /// @return {uint256} multiplication of msg.value and an unsigned integer,
    /// reverting on overflow
    /// @dev Safe convenience wrapper for `msg.value * x`
    ///
    function msgValueMul(
        uint256 rhs
    )internal pure returns(
        uint256 ret
    ){
        if(msg.value == 0){
            return 0;
        }
        return msg.value._mul(rhs);
    }
    ///
    /// @return {uint256} integer division of msg.value and an unsigned integer,
    /// reverting on division by zero
    /// @dev Safe convenience wrapper for Solidity's `smg.value / x`
    ///
    function msgValueDiv(
        uint256 rhs
    )internal pure returns(
        uint256
    ){
        return msg.value._div(
            rhs
        );
    }
    ///
    /// @return {uint256} integer division of two unsigned integers,
    /// reverts with custom message on division by zero
    /// @dev safe wrapper for Solidity's `/` operator
    ///
    /// Requirements:
    ///     - divisor cannot be zero
    /// 
    /// NOTICE:
    ///     result is rounded towards zero
    ///
    function msgValueDiv(
        uint256 rhs,
        string memory errorMessage
    )internal pure returns(
        uint256 ret
    ){
        return msgValueDiv(rhs,errorMessage);
    }
    ///
    /// @return {uint256} remainder of dividing msg.value by an unsigned integers (unsigned integer modulo),
    /// reverting on divide by zero
    /// @dev Safe convenience wrapper for `msg.value % x`
    ///
    function msgValueMod(
        uint256 rhs
    )internal pure returns(
        uint256
    ){
        return msgValueMod(
            rhs,
            "modulo by zero"
        );
    }
    ///
    /// @returns {uint256} remainder of dividing two unsigned integers (unsigned integer modulo),
    /// reverting with custom message on modulo by zero
    ///
    function msgValueMod(
        uint256 rhs,
        string memory errorMessage
    )internal pure returns(
        uint256 ret
    ){
        return msg.value._mod(rhs,errorMessage);
    }
}