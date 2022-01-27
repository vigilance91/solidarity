// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";
/// 
/// @title Safe Transaction Library
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @dev library for performing financial transactions with pre and post logic checks to ensure state
/// 
library SafeTransaction
{
    using SafeMath for uint256;
    //using uint256SafeMath for uint256;
    using uint256Constraints for uint256;
    
    using logicConstraints for bool;
    
    //modifier _requireNonzero(
        //uint256 value
    //)internal
    //{
        //value.requireGreaterThanZero();
    //}
    
    //modifier _requireNonzero(
        //uint256 amount
    //){
        //amount.requireGreaterThanZero();
    //}
    /// @dev inert, returns the resulting balance of a withdraw of arg amount from arg from
    function withdraw(
        uint256 accountBalance,
        uint256 amount
    )internal pure returns(
        uint256 res
    ) //_requireNonzero(amount)
    {
        amount.requireGreaterThanZero();
        
        accountBalance.requireGreaterThanZero();
        //require(accountBalance >= amount,"insufficient funds");
        //accountBalance.requireGreaterThanOrEqual(amount);
        
        res = accountBalance.sub(amount);
        //new balance must be less than previous
        res.requireLessThan(accountBalance);
    }
    /// @dev inert, return the resulting balance after a despoit of arg amount is made to arg to balance
    function deposit(
        uint256 accountBalance,
        uint256 amount
    )internal pure returns(
        uint256 res
    ) //_requireNonzero(amount)
    {
        amount.requireGreaterThanZero();
        
        res = accountBalance.add(amount);
        //new balance must be greater than previous balance
        res.requireGreaterThan(accountBalance);
        
        //automatically returns res;
    }
    /// @dev inert, calculates amount moved from fromBalance to toBalance, with sanity checks,
    // such as in common transactions, where value is withdrawn from one account and deposited into another
    function transact(
        uint256 fromBalance,
        uint256 toBalance,
        uint256 amount
    )internal pure returns(
        bool
    ){
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
    )internal pure
    {
        transact(
            fromBalance,
            toBalance,
            amount
        ).requireTrue(
            //'txn failed'
        );
    }
    
    //function requireTransactionSuccessful(
        //uint256[] memory fromBalances,
        //uint256[] memory toBalances,
        //uint256[] memory amounts
    //)internal pure
    //{
        //require(fromBalance.length == toBalances.length);
        //require(fromBalance.length == amounts.length);
        
        //uint L = fromBalances.length;
        
        //for(uint i; i < L; i++){
            //transact(
                //fromBalances[i],
                //toBalances[i],
                //amounts[i]
            //).requireTrue(
                ////'txn failed'
            //);
        //}
    //}
    /**
    /// @dev remove amount from all entries in array,
    /// such as when poker players all contribute a blind to a pot
    function parallelWithdraw(
        uint256[] memory balances,
        uint256 amount
    )internal pure returns(
        bool
    ){
        withdraw(fromBalance, amount);
        deposit(toBalance, amount);
        
        return true;
    }
    /// @dev deposit an amount into all entries in array,
    /// such as when paying out equal proportions of some value,
    function parallelDeposit(
        uint256[] memory balances,
        uint256 amount
    )internal pure returns(
        bool
    ){
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
    )internal pure returns(
        uint256 newBalance0,
        uint256 newBalance1
    ){
        return (
            withdraw(balance0, amount),
            withdraw(balance1, amount)
        );
    }
    //function parallelWithdraw(
        //uint256 from,
        //uint256[] memory to,
        //uint256 amount
    //)internal pure returns(
        //uint256 newBalance0,
        //uint256[] memory newBalances
    //){
        //uint256[] results = new uint256[](to.length);
        
        //for(uint i; i < to.length) i++){
            //results[i] = withdraw(from, amount);
        //}
        
        //return results;
    //}
    //function parallelWithdraw(
        //uint256[] memory from,
        //uint256 amount
    //)internal pure returns(
        //uint256[] memory balances,
    //){
        //uint256[] balances = new uint256[](from.length);
        
        //for(uint i; i < from.length; i++){
            //results[i] = withdraw(from[i], amount);
        //}
        
        //return results;
    //}
    /// @dev attemp sanity checks for carrying out two deposits in serial to two separate account balances, typicall one is a personal balance, the other is a total balance for all accounts
    function parallelDeposit(
        uint256 balance0,
        uint256 balance1,
        uint256 amount
    )internal pure returns(
        uint256 newBalance0,
        uint256 newBalance1
    ){
        return (
            deposit(balance0, amount),
            deposit(balance1, amount)
        );
    }
    //function parallelDeposit(
        //uint256 from,
        //uint256[] memory to,
        //uint256 amount
    //)internal pure returns(
        //uint256 newBalance0,
        //uint256[] memory newBalances
    //){
        //uint256[] balances = new uint256[](to.length);
        
        //for(uint i; i < to.length) i++){
            //balances[i] = deposit(from, amount);
            //from = from.sub(amount);
        //}
        
        //return balances;
    //}
    //function parallelDeposit(
        //uint256[] memory to,
        //uint256 amount
    //)internal pure returns(
        //uint256[] memory balances,
    //){
        //uint256[] balances = new uint256[](to.length);
        
        //for(uint i; i < to.length; i++){
            //balances[i] = deposit(to[i], amount);
        //}
        
        //return results;
    //}
    /**
    function parallelTransact(
        uint256 balance0,
        uint256 balance1,
        uint256 amount
    )internal pure returns(
        uint256 newBalance0,
        uint256 newBalance1
    ){
        return (
            transact(balances.payer0, balance.recipient0, amount),
            transact(balances.payer1, balances.recipient1, amount)
        );
    }
    function requireParallelTransactionSuccessful(
        uint256 balance0,
        uint256 balance1,
        uint256 amount
    )internal pure returns(
        uint256 newBalance0,
        uint256 newBalance1
    ){
        require(
            transact(balances.payer0, balance.recipient0, amount) &&
            transact(balances.payer1, balances.recipient1, amount)
        );
    }
    */
}