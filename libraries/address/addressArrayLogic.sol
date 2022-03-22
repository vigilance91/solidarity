// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Logic.sol";
/// 
/// @title Address Array Logic Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 22/3/2022, All Rights Reserved
/// @notice trivial functions for logical operations on string arrays not provided natively by Solidity.
///
library addressArrayLogic
{
    using Bytes32Logic for bytes32;
    
    string private constant _NAME = " addressArrayLogic: ";
    
    //string internal constant EMPTY = "";
    
    //address[] internal constant EMPTY_ARRAY = (address)[];
    //bytes32 internal constant EMPTY_HASH = keccak256(
        //abi.encode(EMPTY_ARRAY)
    //);
    modifier _requireNotEmpty(
        address[] memory lhs,
        address[] memory rhs
    ){
        require(
            lhs.length != 0 &&
            rhs.length != 0
        );
        _;
    }

    //modifier _requireEmpty(
        //address[] memory lhs,
        //address[] memory rhs
    //){
        //require(
            //lhs.length == 0 &&
            //rhs.length == 0
        //);
        //_;
    //}
    
    function lengthEqual(
        address[] memory lhs,
        address[] memory rhs
    )internal pure returns(
        bool
    ){
        return lhs.length == rhs.length;
    }
    function equal(
        address[] memory lhs,
        address[] memory rhs
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
        address[] memory lhs,
        address[] memory rhs
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
        address[] memory lhs
    )internal pure returns(
        bool
    ){
        return lhs.length == 0;
    }
    
    function notEmpty(
        address[] memory lhs
    )internal pure returns(
        bool
    ){
        return lhs.length != 0;
    }

    function notEmptyAndNotEqual(
        address[] memory lhs,
        address[] memory rhs
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
        address[] memory lhs,
        address[] memory rhs
    )internal pure
        //_requireNotEmpty(lhs,rhs)
    returns(
        bool
    ){
        return notEmpty(lhs) && 
            notEmpty(rhs) &&
            equal(lhs,rhs);
    }
    /*
    //lhs and rhs MUST be the same length otherwise revert
    function xor(
        address[] memory lhs,
        address[] memory rhs
    )internal returns(
        address[] memory ret
    ) //_notEmpty(lhs,rhs)
    {
        uint256 l = lhs.length;
        //_requireLengthEqual(lhs,rhs);
        require(
            l == rhs.length
        );
        
        ret = new address[](l);
        
        for(uint256 i; i < l; i++){
            ret[i] = address(
                bytes32(lhs[i]) ^ bytes32(rhs[i])
            );
        }
    }
    function and(
        address[] memory lhs,
        address[] memory rhs
    )internal returns(
        address[] memory ret
    ) //_notEmpty(lhs,rhs)
    {
        uint256 l = lhs.length;
        //requireLengthEqual(lhs,rhs);
        require(
            l == rhs.length
        );
        
        ret = new address[](l);
        
        for(uint256 i; i < l; i++){
            ret[i] = address(
                bytes32(lhs[i]) & bytes32(rhs[i])
            );
        }
    }
    function or(
        address[] memory lhs,
        address[] memory rhs
    )internal returns(
        address[] memory ret
    ) //_notEmpty(lhs,rhs)
    {
        uint256 l = lhs.length;
        
        require(
            l == rhs.length
            //
        );
        
        ret = new address[](l);
        
        for(uint256 i; i < l; i++){
            ret[i] = address(
                bytes32(lhs[i]) | bytes32(rhs[i])
            );
        }
    }
    */
}