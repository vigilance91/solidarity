// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/AddressLogic.sol";

/// @title Address Contraints Library
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @notice trivial utilities for constraining the state of the EVM (using require)
/// for address types, reverting on failure.
library AddressConstraints
{
    using LogicConstraints for bool;
    
    using AddressLogic for address;
    
    function requireEqual(
        address lhs,
        address rhs
    ) public pure
    {
        lhs.equal(rhs).requireTrue(
            "addresses not equal"
        );
    }
    function requireNotEqual(
        address lhs,
        address rhs
    ) public pure
    {
        lhs.notEqual(rhs).requireTrue(
            "addresses equal"
        );
    }
    
    function requireIsNull(
        address account
    ) public pure
    {
        account.isNull().requireTrue(
            "address not null"
        );
    }
    function requireNotNull(
        address account
    ) public pure
    {
        account.isNotNull().requireTrue(
            "address null"
        );
    }
    
    /**
    *note library internal modifiers cna not be call externally
    
    modifier _notNull(
        address lhs
    )internal
    {
        requireNotNull(lhs);
        _;
    }
    modifier _notNull(
        address lhs,
        address rhs
    )internal
    {
        requireNotNull(lhs);
        requireNotNull(rhs);
        _;
    }
    
    //modifier _isNull(
        //address lhs
    //)internal
    //{
        //requireIsNull(lhs);
        //_;
    //}
    //modifier _isNull(
        //address lhs,
        //address rhs
    //)internal
    //{
        //requireIsNull(lhs);
        //requireIsNull(rhs);
        //_;
    //}
    */
    
    function requireNotEqualAndNotNull(
        address lhs,
        address rhs
    ) public pure
        //_requireNotNull(lhs,rhs)
    {
        requireNotNull(lhs);
        requireNotNull(rhs);
        requireNotEqual(lhs, rhs);
    }
    function requireNotMsgSender(
        address rhs
    ) public view
        //_requireNotNull(rhs)
    {
        requireNotEqualAndNotNull(msg.sender, rhs);
    }
    //deprecated, obsolete by method, notEualAndNotNull
    function requireNotThisAndNotNull(
        address self,
        address account
    ) public pure
        //_requireNotNull(self,rhs)
    {
        requireNotNull(self);
        requireNotNull(account);
        requireNotEqual(self, account);
    }
    function requireAddressesNotThisAndNotNull(
        address self,
        address lhs,
        address rhs
    ) public pure
        //_requireNotNull(lhs, rhs)
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