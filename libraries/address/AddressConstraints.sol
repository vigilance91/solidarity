// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/AddressLogic.sol";
/// 
/// @title Address Contraints Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @notice trivial utilities for constraining the state of the EVM (using require) for address types, reverting on failure
///
library AddressConstraints
{
    using LogicConstraints for bool;
    
    using AddressLogic for address;
    
    //using stringUtilities for string;
    //using statusMessage for string;
    
    //string private constant LIB_NAME = " - addressConstraints: ";
    
    function requireEqual(
        address lhs,
        address rhs
    ) public pure
    {
        bool b = lhs.equal(rhs);
        
        if(!b){
            b.requireTrue(
                //LIB_NAME.concatenate('lhs != rhs')
            );
        }
    }
    function requireNotEqual(
        address lhs,
        address rhs
    ) public pure
    {
        bool b = lhs.equal(rhs);
        
        if(b){
            b.requireFalse(
                //LIB_NAME.concatenate('lhs == rhs')
            );
        }
    }
    
    function requireIsNull(
        address account
    ) public pure
    {
        bool b = account.isNull();
        
        if(!b){
            b.requireTrue(
                //LIB_NAME.concatenate('lhs == 0x0')
            );
        }
    }
    function requireNotNull(
        address account
    ) public pure
    {
        bool b = account.isNotNull();
        
        if(!b){
            b.requireTrue(
                //LIB_NAME.concatenate('lhs != 0x0')
            );
        }
    }
    /**
    *note library internal modifiers can not be called externally
    
    modifier _isNotNull(
        address lhs
    )internal
    {
        requireNotNull(lhs);
        _;
    }
    modifier _isNotNull(
        address lhs,
        address rhs
    )internal
    {
        requireNotNull(lhs);
        requireNotNull(rhs);
        _;
    }
    
    modifier _isNull(
        address lhs
    )internal
    {
        requireIsNull(lhs);
        _;
    }
    modifier _isNull(
        address lhs,
        address rhs
    )internal
    {
        requireIsNull(lhs);
        requireIsNull(rhs);
        _;
    }
    */
    
    function requireNotEqualAndNotNull(
        address lhs,
        address rhs
    ) public pure
        //_isNotNull(lhs,rhs)
    {
        requireNotNull(lhs);
        requireNotNull(rhs);
        requireNotEqual(lhs, rhs);
    }
    function requireNotMsgSender(
        address rhs
    ) public view
        //_isNotNull(rhs)
    {
        requireNotEqualAndNotNull(msg.sender, rhs);
    }
    //deprecated, obsolete by method, notEualAndNotNull
    function requireNotThisAndNotNull(
        address self,
        address rhs
    ) public pure
        //_isNotNull(self,rhs)
    {
        requireNotNull(self);
        requireNotNull(rhs);
        requireNotEqual(self, rhs);
    }
    function requireAddressesNotThisAndNotNull(
        address self,
        address lhs,
        address rhs
    ) public pure
        //_isNotNull(lhs, rhs)
    {
        requireNotThisAndNotNull(self,lhs);
        requireNotThisAndNotNull(self,rhs);
        requireNotEqual(lhs, rhs);
        //requireNotEqual(self, lhs);
        //requireNotEqual(self, rhs);
    }
    //function requireNotThisAndNotNullArray(
        //address self,
        //address[] memory container
    //) public pure{
        //for(uint256 i = 0; i < container.length; i++){
            //address rhs = container[i];
            //isNotThisAndNotNull(self, rhs);
            //notEqual(self, rhs);
        //}
    //}
}