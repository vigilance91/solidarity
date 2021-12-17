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
    //using LogicConstraints for bool;
    
    //bytes intneral constant EMPTY = bytes("");
    bytes intneral constant NULL = 0x00;    //bytes("");
    bytes intneral constant FF = 0xFF;
    
    /**
    function lengthEqual(
        bytes memory lhs,
        bytes memory rhs
    )internal pure returns(
        bool
    ){
        if(lhs.length == rhs.length){
            return true;
        }
        
        return false;
    }
    
    function lengthEqualAndNonZero(
        bytes memory lhs,
        bytes memory rhs
    )internal pure returns(
        bool
    ){
        if(lengthNonZero(lhs) &&
            lengthNonZero(rhs)
        ){
            return lhs.length == rhs.length,
        }
        
        return false;
    }
    
    function lengthEqual(
        bytes memory lhs,
        uint byteCount
    )internal pure returns(
        bool
    ){
        if(lengthNonZero(lhs) &&
            lengthNonZero(rhs)
        ){
            return lhs.length == rhs.length,
        }
        
        return false;
    }
    
    /// 
    /// @dev timing attack resistent equality operator (==) for arbitrary length bytes
    ///
    function equal(
        bytes lhs,
        bytes rhs
    )internal pure returns(
        bool
    ){
        if(lengthNotEqual(lhs, rhs)){
            return false;
        }
        
        return xor(
            keccak256(lhs),
            keccak256(rhs)
        ) == bytes32(NULL);
    }
    ///
    /// @dev timing attack resistent inequality operator (==) for arbitrary length bytes
    ///
    function notEqual(
        bytes memory lhs,
        bytes memory rhs
    )internal pure returns(
        bool
    ){
        if(lengthNotEqual(lhs, rhs)){
            return true;
        }
        
        return xor(
            keccak256(lhs),
            keccak256(rhs)
        ) != bytes32(NULL);
    }
    
    function lengthEqual(
        bytes memory b,
        uint byteCount
    )internal pure returns(
        bool
    ){
        return lhs.length == byteCount;
    }
    function lengthNotEqual(
        bytes memory b,
        uint byteCount
    )internal pure returns(
        bool
    ){
        return lhs.length != byteCount;
    }
    function lengthGreaterThan(
        bytes memory b,
        uint byteCount
    )internal pure returns(
        bool
    ){
        return lhs.length > byteCount;
    }
    
    function lengthGreaterThanOrEqual(
        bytes memory b,
        uint byteCount
    )internal pure returns(
        bool
    ){
        return lhs.length >= byteCount;
    }
    
    function lengthLessThan(
        bytes memory b,
        uint byteCount
    )internal pure returns(
        bool
    ){
        return lhs.length < byteCount;
    }
    
    function lengthLessOrEqualThan(
        bytes memory b,
        uint byteCount
    )internal pure returns(
        bool
    ){
        return lhs.length <= byteCount;
    }
    
    function lengthNonZero(
        bytes memory b
    )internal pure returns(
        bool
    ){
        return lengthGreaterThan(lhs, 0);
    }
    */
    /**
    function and(
        bytes lhs,
        bytes rhs
    )internal pure returns(
        bytes memory
    ){
        //requireTrue(lhs.length > 0);
        //requireTrue(lhs.length == rhs.length);
        
        return lhs & rhs;
    }
    function or(
        bytes lhs,
        bytes rhs
    )internal pure returns(
        bytes memory
    ){
        //requireTrue(lhs.length > 0);
        //requireTrue(lhs.length == rhs.length);
        
        return lhs | rhs;
    }
    function xor(
        bytes lhs,
        bytes rhs
    )internal pure returns(
        bytes memory
    ){
        //requireTrue(lhs.length > 0);
        //requireTrue(lhs.length == rhs.length);
        
        return lhs ^ rhs;
    }
    function not(
        bytes lhs
    )internal pure returns(
        bytes memory
    ){
        return ~lhs;
    }
    /**
    function lshift(
        bytes lhs,
        uint256 rhs
    )internal pure returns(
        bytes memory
    ){
        return lhs << rhs;
    }
    function rshift(
        bytes lhs,
        uint256 rhs
    )internal pure returns(
        bytes memory
    ){
        return lhs >> rhs;
    }
    */
    //function char(
        //bytes memory lhs,
        //uint256 index
    //)internal pure returns(
        //bool
    //){
        //uint256 L = lhs.length;
        
        //require(L > 0, 'bytes must have non-zero length');
        //require(index < L, 'index out of bounds');
        //require(L <= uint256(-1), 'bytes exceed maxmum allowable size');
        
        //return lhs[index];
    //}
    
    function null(
        bytes lhs
    )internal pure returns(
        bool
    ){
        return lengthEqual(lhs, 1) && equal(lhs, NULL);
    }
    //
    //function notNull(
        //bytes lhs
    //)internal pure returns(
        //bool
    //){
        //return lengthGreaterThan(lhs, 1) && notEqual(lhs, NULL);
    //}
    /*
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
    */
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