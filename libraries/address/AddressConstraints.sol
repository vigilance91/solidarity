// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/AddressLogic.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Address.sol";
/// 
/// @title Address Contraints Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @notice trivial utilities for constraining the state of the EVM (using require) for address types, reverting on failure
///
library AddressConstraints
{
    using LogicConstraints for bool;
    
    using Address for address;
    
    using AddressLogic for address;
    
    //using stringUtilities for string;
    //using statusMessage for string;
    
    //string private constant _NAME = " - addressConstraints: ";
    
    function requireEqual(
        address lhs,
        address rhs
    )public pure
    {
        lhs.equal(rhs).requireTrue(
            //_NAME.concatenate('lhs != rhs')
        );
    }
    function requireNotEqual(
        address lhs,
        address rhs
    )public pure
    {
        lhs.equal(rhs).requireFalse(
            //_NAME.concatenate('lhs == rhs')
        );
    }
    
    function requireIsNull(
        address account
    )public pure
    {
        account.isNull().requireTrue(
            //_NAME.concatenate('lhs == 0x0')
        );
    }
    //function requireIsNull(
        //address[] memory accounts
    //)public pure
    //{
        //for(uint i; i < accounts.length; i++){
            //requireIsNull(accounts[i]);
        //}
    //}
    function requireNotNull(
        address account
    )public pure
    {
        account.isNotNull().requireTrue(
            //_NAME.concatenate('lhs != 0x0')
        );
    }
    
    //function requireNotNull(
        //address[] memory accounts
    //)public pure
    //{
        //for(uint i; i < accounts.length; i++){
            //requireNotNull(accounts[i]);
        //}
    //}
    //address `account` must be a contract and not NULL otherwise the transaction reverts
    function requireContract(
        address account
    )public view
        //_requireNotNull(account)
    {
        requireNotNull(account);
        account.isContract().requireTrue(
            //_NAME.concatenate('address must be a contract')
        );
    }
    //function requireContract(
        //address[] memory accounts
    //)public view
    //{
        //for(uint i; i < accounts.length; i++){
            //requireContract(accounts[i]);
        //}
    //}
    //address `account` must NOT a contract nor NULL, otherwise transaction reverts
    function requireNotContract(
        address account
    )public view
        //_requireNotNull(account)
    {
        requireNotNull(account);
        account.isContract().requireFalse(
            //_NAME.concatenate('address cannot be a contract')
        );
    }
    //function requireNotContract(
        //address[] memory accounts
    //)public view
    //{
        //for(uint i; i < accounts.length; i++){
            //requireNotContract(accounts[i]);
        //}
    //}
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
    )public pure
        //_isNotNull(lhs,rhs)
    {
        requireNotNull(lhs);
        requireNotNull(rhs);
        requireNotEqual(lhs, rhs);
    }
    //function requireNotMsgSender(
        //address rhs
    //)public view
        ////_isNotNull(rhs)
    //{
        //requireNotEqualAndNotNull(msg.sender, rhs);
    //}
    
    //function requireNotThisAndNotNull(
        //address rhs
    //)public pure
        ////_isNotNull(rhs)
    //{
        //address T = address(this);
        
        ////requireNotNull(T);
        //requireNotEqual(T, rhs);
    //}
    
    //deprecated, obsolete by method, notEqualAndNotNull
    function requireNotThisAndNotNull(
        address self,
        address rhs
    )public pure
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
    )public pure
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
    //)public pure
    //{
        //for(uint256 i = 0; i < container.length; i++){
            //address rhs = container[i];
            //isNotThisAndNotNull(self, rhs);
            //notEqual(self, rhs);
        //}
    //}
}