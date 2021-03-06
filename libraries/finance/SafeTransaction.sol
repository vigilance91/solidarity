// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";

/// @title Safe Transaction Library
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @dev library for performing financial transactions with pre and post logic checks to ensure state
library SafeTransaction
{
    using SafeMath for uint256;
    using uint256Constraints for uint256;
    
    using LogicConstraints for bool;
    
    //modifier _requireNonzero(
        //uint256 value
    //)internal
    //{
        //value.requireGreaterThanZero();
    //}
    /// @dev inert, returns the resulting balance of a withdraw of arg amount from arg from
    function withdraw(
        uint256 accountBalance,
        uint256 amount
    ) public pure
        //_requireNonzero(amount)
        returns(uint256 res)
    {
        amount.requireGreaterThanZero();
        
        accountBalance.requireGreaterThanZero();
        //require(accountBalance >= amount,"insufficient funds");
        accountBalance.requireGreaterThanOrEqual(amount);
        
        res = accountBalance.sub(amount);
        
        res.requireLessThan(accountBalance);
        //require(res < accountBalance, "new balance must be less than previous");
        
        //autmatically returns res
        //return res;
    }
    /// @dev inert, return the resulting balance after a despoit of arg amount is made to arg to balance
    function deposit(
        uint256 accountBalance,
        uint256 amount
    ) public pure
        //_requireNonzero(amount)
        returns(uint256 res)
    {
        amount.requireGreaterThanZero();
        
        res = accountBalance.add(amount);
        //require(res > accountBalance,"new balance must be greater than previous balance");
        res.requireGreaterThan(accountBalance);
        
        //automatically returns res;
    }
    /// @dev inert, calculates amount moved from fromBalance to toBalance, with sanity checks,
    // such as in common transactions, where value is withdrawn from one account and deposited into another
    function transact(
        uint256 fromBalance,
        uint256 toBalance,
        uint256 amount
    ) public pure
        returns(bool)
    {
        withdraw(fromBalance, amount);
        deposit(toBalance, amount);
        return true;
        
        //return (
            //withdraw(fromBalance, amount),
            //deposit(toBalance, amount)
        //);
    }
    function requireTransactionSuccessful(
        uint256 fromBalance,
        uint256 toBalance,
        uint256 amount
    ) public pure
    {
        transact(
            fromBalance,
            toBalance,
            amount
        ).requireTrue(
            //'txn failed'
        );
    }
    /**
    /// @dev remove amount from all entries in array,
    /// such as when poker players all contribute a blind to a pot
    function withdrawArray(
        uint256[] memory balances,
        uint256 amount
    )internal pure
        returns(bool)
    {
        withdraw(fromBalance, amount);
        deposit(toBalance, amount);
        
        return true;
    }
    /// @dev deposit an amount into all entries in array,
    /// such as when paying out equal proportions of some value,
    function depositArray(
        uint256[] memory balances,
        uint256 amount
    )internal pure
        returns(bool)
    {
        /// for(){
            deposit(toBalance, amount);
        /// }
        
        return true;
    }
    */
    function parallelWithdraw(
        uint256 balance0,
        uint256 balance1,
        uint256 amount
    ) public pure
        returns(uint256 newBalance0, uint256 newBalance1)
    {
        return (
            withdraw(balance0, amount),
            withdraw(balance1, amount)
        );
    }
    /// @dev attemp sanity checks for carrying out two deposits in serial to two separate account balances, typicall one is a personal balance, the other is a total balance for all accounts
    function parallelDeposit(
        uint256 balance0,
        uint256 balance1,
        uint256 amount
    ) public pure
        returns(uint256 newBalance0, uint256 newBalance1)
    {
        return (
            deposit(balance0, amount),
            deposit(balance1, amount)
        );
    }
    /**
    function parallelTransact(
        uint256 balance0,
        uint256 balance1,
        uint256 amount
    ) public pure
        returns(uint256 newBalance0, uint256 newBalance1)
    {
        return (
            transact(balances.payer0, balance.recipient0, amount),
            transact(balances.payer1, balances.recipient1, amount)
        );
    }
    function requireParallelTransactionSuccessful(
        uint256 balance0,
        uint256 balance1,
        uint256 amount
    ) public pure
        returns(uint256 newBalance0, uint256 newBalance1)
    {
        require(
            transact(balances.payer0, balance.recipient0, amount) &&
            transact(balances.payer1, balances.recipient1, amount)
        );
    }
    */
}