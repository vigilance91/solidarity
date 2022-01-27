// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressLogic.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Address.sol";
/// 
/// @title Address Contraints Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @notice trivial utilities for constraining the state of the EVM (using require) for address types, reverting on failure
///
library addressConstraints
{
    using logicConstraints for bool;
    
    using Address for address;
    
    using addressLogic for address;
    
    //using stringUtilities for string;
    //using statusMessage for string;
    
    string private constant _NAME = " - addressConstraints: ";
    
    string private constant _ERR_STR_LHS = ", lhs: ";
    string private constant _ERR_STR_RHS = ", rhs: ";
    //string private constant _ERR_STR_VALUE = ", value: ";
    
    string private constant _ERR_EQUAL = string(
        abi.encodePacked(
            _NAME,
            '=='
        )
    );
    
    string private constant _ERR_NOT_EQUAL = string(
        abi.encodePacked(
            _NAME,
            '!='
        )
    );
    
    string private constant _ERR_IS_NULL = string(
        abi.encodePacked(
            _NAME,
            'is null'
        )
    );
    
    string private constant _ERR_IS_NOT_NULL = string(
        abi.encodePacked(
            _NAME,
            'is not null'
        )
    );
    
    string private constant _ERR_IS_CONTRACT = string(
        abi.encodePacked(
            _NAME,
            'is contract, address: '
        )
    );
    
    string private constant _ERR_IS_NOT_CONTRACT = string(
        abi.encodePacked(
            _NAME,
            'is not contract, address: '
        )
    );
    
    function requireEqual(
        address lhs,
        address rhs
    )public pure
    {
        lhs.equal(rhs).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_NOT_EQUAL,
                    _ERR_STR_LHS,
                    lhs,
                    _ERR_STR_RHS,
                    rhs
                )
            )
        );
    }
    function requireNotEqual(
        address lhs,
        address rhs
    )public pure
    {
        lhs.equal(rhs).requireFalse(
            string(
                abi.encodePacked(
                    _ERR_EQUAL,
                    _ERR_STR_LHS,
                    lhs,
                    _ERR_STR_RHS,
                    rhs
                )
            )
        );
    }
    
    function requireIsNull(
        address account
    )public pure
    {
        account.isNull().requireTrue(
            string(
                abi.encodePacked(
                    _ERR_IS_NOT_NULL,
                    account
                )
            )
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
            _ERR_IS_NULL
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
            string(
                abi.encodePacked(
                    _ERR_IS_NOT_CONTRACT,
                    account
                )
            )
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
            string(
                abi.encodePacked(
                    _ERR_IS_CONTRACT,
                    account
                )
            )
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
        requireNotNull(self);   //address(this)
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
        //address T = address(this);
        
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
        //address T = address(this);
        
        //for(uint256 i = 0; i < container.length; i++){
            //address rhs = container[i];
            //isNotThisAndNotNull(self, rhs);
            //notEqual(self, rhs);
        //}
    //}
}