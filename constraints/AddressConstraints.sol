// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.2 <0.8.0;

//import "https://github.com/vigilance91/solidarity/constraints/LogicConstraints.sol";

/// @title Address Contraints
/// @author Tyler R. Drury - 3/1/2021, ALl Rights Reserved
/// @notice trivial utilities for constraining the state of the EVM (using require)
/// for address types, reverting on failure.
library AddressConstraints
{
    //using LogicalConstraints for bool;
    
    address public constant NULL = address(0);
    
    function isNotNull(
        address account
    ) public pure{
        //(account != NULL).requireTrue("address is null");
        require(account != NULL, "address null");
    }
    function notEqual(
        address lhs,
        address rhs
    ) public pure{
        //(lhs != rhs).requireTrue("addresses are equal");
        require(lhs != rhs,"addresses are equal");
    }
    function notEqualAndNotNull(
        address lhs,
        address rhs
    ) public pure{
        /// isNotNull(lhs, "addressesNotEqual: lhs argument can not be null");
        /// isNotNull(rhs, "addressesNotEqual: rhs argument can not be null");
        
        //(lhs != NULL && rhs != NULL).requireTrue("address is null");
        require(lhs != NULL && rhs != NULL, "address null");
        notEqual(lhs, rhs);
    }
    function notMsgSender(
        address account
    ) public view{
        notEqualAndNotNull(msg.sender, account);
    }
    function notThisAndNotNull(
        address self,
        address account
    ) public pure{
        isNotNull(account);
        notEqual(self, account);
    }
    function addressesNotThisAndNotNull(
        address self,
        address lhs,
        address rhs
    ) public pure{
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