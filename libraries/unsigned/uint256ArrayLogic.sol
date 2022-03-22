// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Logic.sol";
/// 
/// @title uint256 Array Logic Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 22/3/2022, All Rights Reserved
/// @notice trivial functions for logical operations on string arrays not provided natively by Solidity.
///
library uint256ArrayLogic
{
    using Bytes32Logic for bytes32;
    
    string private constant _NAME = " uint256ArrayLogic: ";
    
    //string internal constant EMPTY = "";
    
    //bytes32[] internal constant EMPTY_ARRAY = (bytes32)[];
    //bytes32 internal constant EMPTY_HASH = keccak256(
        //abi.encode(EMPTY_ARRAY)
    //);
    modifier _requireNotEmpty(
        uint256[] memory lhs,
        uint256[] memory rhs
    ){
        require(
            lhs.length != 0 &&
            rhs.length != 0
        );
        _;
    }

    //modifier _requireEmpty(
        //uint256[] memory lhs,
        //uint256[] memory rhs
    //){
        //require(
            //lhs.length == 0 &&
            //rhs.length == 0
        //);
        //_;
    //}
    
    function lengthEqual(
        uint256[] memory lhs,
        uint256[] memory rhs
    )internal pure returns(
        bool
    ){
        return lhs.length == rhs.length;
    }
    function equal(
        uint256[] memory lhs,
        uint256[] memory rhs
    )internal pure returns(
        bool
    ){
        if(lhs.length ^ rhs.length != 0){
            return false;
        }
        
        return keccak256(
            abi.encode(lhs)
        ).equal(
            keccak256(
                abi.encode(rhs)
            )
        );
    }
    
    function notEqual(
        uint256[] memory lhs,
        uint256[] memory rhs
    )internal pure returns(
        bool
    ){
        if(lhs.length ^ rhs.length != 0){
            return true;
        }
        
        return keccak256(
            abi.encode(lhs)
        ).notEqual(
            keccak256(
                abi.encode(rhs)
            )
        );
    }
    
    function empty(
        uint256[] memory lhs
    )internal pure returns(
        bool
    ){
        return lhs.length == 0;
    }
    
    function notEmpty(
        uint256[] memory lhs
    )internal pure returns(
        bool
    ){
        return lhs.length != 0;
    }

    function notEmptyAndNotEqual(
        uint256[] memory lhs,
        uint256[] memory rhs
    )internal pure
        //_requireNotEmpty(lhs,rhs)
    returns(
        bool
    ){
        return notEmpty(lhs) && 
            notEmpty(rhs) &&
            notEqual(lhs,rhs);
    }
    
    function notEmptyAndAreEqual(
        uint256[] memory lhs,
        uint256[] memory rhs
    )internal pure
        //_requireNotEmpty(lhs,rhs)
    returns(
        bool
    ){
        return notEmpty(lhs) && 
            notEmpty(rhs) &&
            equal(lhs,rhs);
    }
    
    //lhs and rhs MUST be the same length otherwise revert
    function xor(
        uint256[] memory lhs,
        uint256[] memory rhs
    )internal returns(
        uint256[] memory ret
    ) //_notEmpty(lhs,rhs)
    {
        uint256 l = lhs.length;
        //_requireLengthEqual(lhs,rhs);
        require(
            l == rhs.length
        );
        
        ret = new uint256[](l);
        
        for(uint256 i; i < l; i++){
            ret[i] = lhs[i] ^ rhs[i];
        }
    }
    function and(
        uint256[] memory lhs,
        uint256[] memory rhs
    )internal returns(
        uint256[] memory ret
    ) //_notEmpty(lhs,rhs)
    {
        uint256 l = lhs.length;
        //requireLengthEqual(lhs,rhs);
        require(
            l == rhs.length
        );
        
        ret = new uint256[](l);
        
        for(uint256 i; i < l; i++){
            ret[i] = lhs[i] & rhs[i];
        }
    }
    function or(
        uint256[] memory lhs,
        uint256[] memory rhs
    )internal returns(
        uint256[] memory ret
    ) //_notEmpty(lhs,rhs)
    {
        uint256 l = lhs.length;
        
        require(
            l == rhs.length
            //
        );
        
        ret = new uint256[](l);
        
        for(uint256 i; i < l; i++){
            ret[i] = lhs[i] | rhs[i];
        }
    }
}