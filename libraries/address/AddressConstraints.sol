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
            "addresses are not equal"
        );
    }
    function requireNotEqual(
        address lhs,
        address rhs
    ) public pure
    {
        lhs.notEqual(rhs).requireTrue(
            "addresses are equal"
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
    function isNotNull(
        address account
    ) public pure
    {
        account.isNotNull().requireTrue(
            "address null"
        );
    }
    function notEqualAndNotNull(
        address lhs,
        address rhs
    ) public pure
    {
        isNotNull(lhs);
        isNotNull(rhs);
        notEqual(lhs, rhs);
    }
    function notMsgSender(
        address rhs
    ) public view
    {
        notEqualAndNotNull(msg.sender, rhs);
    }
    //deprecated, obsolete by method, notEualAndNotNull
    function notThisAndNotNull(
        address self,
        address account
    ) public pure
    {
        isNotNull(self);
        isNotNull(account);
        notEqual(self, account);
    }
    function addressesNotThisAndNotNull(
        address self,
        address lhs,
        address rhs
    ) public pure
    {
        notThisAndNotNull(self,lhs);
        notThisAndNotNull(self,rhs);
        notEqual(lhs, rhs);
    }
    //function notThisAndNotNullArray(
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