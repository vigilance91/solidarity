// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Logic.sol";
//import "https://github.com/vigilance91/solidarity/libraries/libraries/bytesUtilities.sol";
/// 
/// @title Bytes Array Logic Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 22/3/2022, All Rights Reserved
/// @notice trivial functions for logical operations on bytes arrays not provided natively by Solidity.
///
library bytesArrayLogic
{
    using Bytes32Logic for bytes32;
    //using stringUtils for string;
    
    string private constant _NAME = " bytesArrayLogic: ";
    
    bytes internal constant EMPTY = "";
    
    //bytes[] internal constant EMPTY = [];
    //bytes32 internal constant EMPTY_HASH = keccak256(
        //abi.encode(EMPTY)
    //);
    
     modifier _requireNotEmpty(
        bytes[] memory lhs,
        bytes[] memory rhs
    ){
        require(
            lhs.length != 0 &&
            rhs.length != 0
        );
        _;
    }

    //modifier _requireEmpty(
        //bytes[] memory lhs,
        //bytes[] memory rhs
    //){
        //require(
            //lhs.length == 0 &&
            //rhs.length == 0
        //);
        //_;
    //}

    function lengthEqual(
        bytes[] memory lhs,
        bytes[] memory rhs
    )internal pure returns(
        bool
    ){
        return lhs.length == rhs.length;
    }
    function equal(
        bytes[] memory lhs,
        bytes[] memory rhs
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
        bytes[] memory lhs,
        bytes[] memory rhs
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
        bytes[] memory lhs
    )internal pure returns(
        bool
    ){
        return lhs.length == 0;
    }
    
    function notEmpty(
        bytes[] memory lhs
    )internal pure returns(
        bool
    ){
        return lhs.length != 0;
    }
    
    function notEmptyAndNotEqual(
        bytes[] memory lhs,
        bytes[] memory rhs
    )internal pure
        //_requireNotEmpty(lhs,rhs)
    returns(
        bool
    ){
        return notEmpty(
            lhs
        ) && notEmpty(
            rhs
        ) && notEqual(lhs,rhs);
    }
    
    function notEmptyAndAreEqual(
        bytes[] memory lhs,
        bytes[] memory rhs
    )internal pure
        //_requireNotEmpty(lhs,rhs)
    returns(
        bool
    ){
        return notEmpty(
            lhs
        ) && notEmpty(
            rhs
        ) && equal(lhs,rhs);
    }
    /**
    * lhs and rhs MUST be the same length otherwise revert
    //function xor(
        //bytes[] memory lhs,
        //bytes[] memory rhs
    //)internal returns(
        bytes[] memory ret
    //) _notEmpty(lhs,rhs)
    //{
        //_requireLengthEqual(lhs,rhs);
        
        //ret = new bytes[](lhs.length);
        bytes memory lb;
        bytes memory rb;
        
        //for(uint256 i; i < L; i++){
            //lb = lhs[i];
            //rb = rhs[i];
            
            //require(lb.length == rb.length);
            
            //ret[i] = lb ^ rb;
        //}
    //}
    //function and(
        //bytes[] memory lhs,
        //bytes[] memory rhs
    //)internal returns(
        bytes[] memory ret
    //) _notEmpty(lhs,rhs)
    //{
        //require(lhs.length == rhs.rhs);
        
        //ret = new bytes[](lhs.length);
        
        bytes memory lb;
        bytes memory rb;
        
        //for(uint256 i; i < L; i++){
            //lb = lhs[i];
            //rb = rhs[i];
            
            //require(lb.length == rb.length);
            
            //ret[i] = lb & rb;
        //}
    //}
    //function or(
        //bytes[] memory lhs,
        //bytes[] memory rhs
    //)internal returns(
        //bytes[] memory ret
    //) _notEmpty(lhs,rhs)
    //{
        ////_requireLengthEqual(lhs,rhs);
        //require(lhs.length == rhs.rhs);
        
        //ret = new bytes[](lhs.length);
        
        //for(uint256 i; i < L; i++){
            //bytes lb = bytes(lhs[i]);
            //bytes rb = bytes(rhs[i]);
            
            //require(lb.length == rb.length);
            
            //ret[i] = string(bytes(lb) | bytes(rb));
        //}
    //}
    function not(
        bytes[] memory self
    )internal returns(
        bytes[] memory ret
    ){
        notEmpty(self);
        
        ret = new bytes[](self.length);
        
        for(uint256 i; i < self.length; i++){
            ret[i] = !self[i];
        };
    }
    */   
}