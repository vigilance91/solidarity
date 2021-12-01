// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
/**
 * todo create struct or contract for a mapping of addresses to byte32, for user account passwords!
 * libraries with internal functions have to function body injected into all callsites (this increases size and gas cost)
 * however, internal libraries do not need to be deployed, only included with the contracts that use them
*/

//note: this causes an error if bytes is above 127, (beyond human readable ASCII range)
//function concat(bytes1 lhs, string memory rhs)public pure returns(string memory){
    //string memory s = string(abi.encode(lhs));
    //return string(abi.encodePacked(s, rhs));
//}

/// 
/// @title Bytes Logic Library
/// @author Tyler R. Drury - 4/3/2021, All Rights Reserved
/// @notice trivial functions for the bytes data type not provided natively by Solidity.
/// 
library BytesLogic
{
    //bytes public constant EMPTY = 0x00;    //bytes("");
    //bytes public constant FF = 0xFF;
    
    /**
    function equal(
        bytes lhs,
        bytes rhs
    ) internal pure
        returns(bool)
    {
        if(lhs.length != rhs.length){
            return false;
        }
        return xor(lhs, rhs) == 0;
    }
    function notEqual(
        bytes lhs,
        bytes rhs
    ) internal pure
        returns(bool)
    {
        if(lhs.length != rhs.length){
            return true;
        }
        return xor(lhs, rhs) != 0;
    }
    */
    /**
    function and(
        bytes lhs,
        bytes rhs
    )internal pure
        returns(bytes)
    {
        return lhs & rhs;
    }
    function or(
        bytes lhs,
        bytes rhs
    )internal pure
        returns(bytes)
    {
        return lhs | rhs;
    }
    function xor(
        bytes lhs,
        bytes rhs
    )internal pure
        returns(bytes)
    {
        //require(lhs.length == rhs.length);
        return lhs ^ rhs;
    }
    function not(
        bytes lhs
    )internal pure
        returns(bytes)
    {
        return ~lhs;
    }
    /**
    function lshift(
        bytes lhs,
        uint256 rhs
    )internal pure
        returns(bytes)
    {
        return lhs << rhs;
    }
    function rshift(
        bytes lhs,
        uint256 rhs
    )internal pure
        returns(bytes)
    {
        return lhs >> rhs;
    }
    */
    //function char(
        //bytes lhs
        //uint256 index
    //)internal pure returns(
        //bool
    //){
        //require(index < lhs.length,'index out of bounds');
        //return lhs[index];
    //}
    function empty(
        bytes lhs
    )internal pure returns(
        bool
    ){
        return lhs == EMPTY;
    }
    
    function notEmpty(
        bytes lhs
    )internal pure returns(
        bool
    ){
        return lhs != EMPTY;
    }
    /**
    function notEmptyAndNotEqual(
        bytes lhs,
        bytes rhs
    )public pure returns(
        bool
    ){
        return notEmpty(
            lhs
        ) && notEmpty(
            rhs
        ) && notEqual(lhs,rhs);
    }
    
    function notEmptyAndAreEqual(
        bytes lhs,
        bytes rhs
    )public pure returns(
        bool
    ){
        return notEmpty(
            lhs
        ) && notEmpty(
            rhs
        ) && equal(lhs,rhs);
    }
    */
}