// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressSafeTransaction.sol";

/// @title This Safe Transaction Library for the contract which is the calling context of this library
/// @author Tyler R. Drury - 20/12/2021, All Rights Reserved
/// @dev NOTICE:
///     only performs sanity checks for transactions of value,
///     these functions do NOT move the actual funds
///
library thisSafeTransaction
{
    using addressSafeTransaction for address;
    //using addressSafeTransaction for address payable;
    
    using LogicConstraints for bool;
    
    //function _balanceGreaterThanOrEqual(
        //uint256 amount
    //)internal pure returns(
        //bool
    //){
        //address(this).balance.requireGreaterThanOrEqual(amount).requireTrue(
        //);
    //}
    
    /// @dev result of a withdraw of arg `amount` of wei from msg.sender
    function thisWithdraw(
        uint256 amount
    )internal pure returns(
        uint256
    ){
        return address(this).withdraw(amount);
    }
    /// @dev result after a despoit of `amount` wei is made by msg.sender to this address
    function thisDeposit(
        uint256 amount
    )internal pure returns(
        uint256
    ){
        return address(this).deposit(amount);
    }
    function requireThisTransactTo(
        address to,
        uint256 amount
    )internal pure
    {
        address(this).requireTransactionSuccessful(
            to,
            amount
        );
    }
    function requireFromTransactThis(
        address from,
        uint256 amount
    )internal pure
    {
        from.requireTransactionSuccessful(
            address(this),
            amount
        );
    }
    /**
    //todo put in contract
    /// @dev remove amount from all entries in array,
    /// such as when poker players all contribute a blind to a pot
    function parallelWithdraw(
        address[] calldata accounts,
        uint256 amount
    )external pure returns(
        bool
    ){
        return address(this).parallelWithdraw(accounts, amount);
    }
    /// @dev deposit an amount into all entries in array,
    /// such as when paying out equal proportions of some value,
    function parallelDeposit(
        address[] calldata balances,
        uint256 amount
    )external pure returns(
        bool
    ){
        return address(this).parallelDeposit(accounts, amount);
    }
    */
    /// @dev attempt sanity checks for if `amount` can be withdrawn from both this contract and `rhs` simultaneously
    function thisParallelWithdraw(
        address rhs,
        uint256 amount
    )internal pure returns(
        uint256,
        uint256
    ){
        return address(this).parallelWithdraw(
            rhs,
            amount
        );
    }
    /// @dev attempt sanity checks for depositing, in serial, to the calling contract context and `rhs`
    function thisParallelDeposit(
        address rhs,
        uint256 amount
    )internal pure returns(
        uint256,
        uint256
    ){
        return address(this).parallelDeposit(
            rhs,
            amount
        );
    }
    /*
    function thisParallelWithdraw(
        address[] calldata from,
        uint256 amount
    )external pure returns(
        uint256[] memory results
    ){
        uint L = from.length;
        
        L.requireGreaterThanZero();
        
        address T = address(this);
        
        results = new uint256[](L);
        
        for(uint i; i < L; i++){
            results[i] = T.withdraw(from[i], amount);
        }
    }
    function thisParallelWithdraw(
        address[] calldata from,
        uint256[] calldata amounts
    )external pure returns(
        uint256[] memory results
    ){
        uint L = from.length;
        
        L.requireGreaterThanZero();
        L.requireEqual(amounts.length);
        
        address T = address(this);
        
        results = new uint256[](L);
        
        for(uint i; i < L; i++){
            results[i] = T.withdraw(from[i], amounts[i]);
        }
    }
    function thisParallelDeposit(
        address[] calldata to,
        uint256 amount
    )external pure returns(
        uint256[] memory
    ){
        uint L = to.length;
        
        L.requireGreaterThanZero();
        
        address T = address(this);
        
        results = new uint256[](L);
        
        for(uint i; i < L; i++){
            results[i] = T.deposit(to[i], amount);
        }
    }
    function thisParallelDeposit(
        address[] calldata to,
        uint256[] calldata amounts
    )external pure returns(
        uint256[] memory
    ){
        uint L = to.length;
        
        L.requireGreaterThanZero();
        L.requireEqual(amounts.length);
        
        address T = address(this);
        
        results = new uint256[](L);
        
        for(uint i; i < L; i++){
            results[i] = T.deposit(to[i], amounts[i]);
        }
    }
    */
    /**
    function thisParallelTransact(
        address rhs,
        uint256 amount
    )internal pure returns(
        uint256,
        uint256
    ){
        return address(this).parallelTransact(rhs, amount);
    }
    function thisParallelTransact(
        address[] calldata from,
        address[] calldata to,
        uint256 amount
    )external pure returns(
        uint256[] memory
    ){
        return address(this).parallelTransact(from, to, amount);
    }
    function thisParallelTransact(
        address[] calldata from,
        address[] calldata to,
        uint256[] calldata amounts
    )external pure returns(
        uint256[] memory
    ){
        return address(this).parallelTransact(from, to, amounts);
    }
    function requireThisParallelTransactionSuccessful(
        address lhs,
        address rhs,
        uint256 amount
    )internal pure returns(
        uint256 newBalance0,
        uint256 newBalance1
    ){
        
    }
    */
}