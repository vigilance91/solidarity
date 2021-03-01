// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.2 <0.8.0;

import "https://github.com/vigilance91/solidarity/utils/uint256Logic.sol";
import "https://github.com/vigilance91/solidarity/utils/AddressConstraints.sol";

/// @title Address Balance Logic Utilities
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// @notice trivial library for logical or bitwise operations on the balances of addresses, not provided natively by Solidity.
library AddressBalanceLogic
{
    using uint256Logic for uint256;
    using AddressConstraints for address;
    /**
     * compare addresses and address related logic/binary/bitwise operations
    */
    // lhs.balance == rhs.balance
    function balanceEqual(
        address lhs,
        address rhs
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        rhs.isNotNull();
        //return lhs.balance ^ rhs.balance == 0;
        return lhs.balance.equal(rhs.balance);
    }
    // lhs.balance != rhs.balance
    function balanceNotEqual(
        address lhs,
        address rhs
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        rhs.isNotNull();
        //return lhs.balance ^ rhs.balance != 0;
        return lhs.balance.notEqual(rhs.balance);
    }
    
    // lhs.balance == 0
    function balanceEqualsZero(
        address lhs
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        
        return lhs.balance.equalsZero();
    }
    /**
    *RHS operatnd type address
    */
    function balanceGreaterThan(
        address lhs,
        address rhs
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        rhs.isNotNull();
        
        return lhs.balance.greaterThan(rhs.balance);
    }
    function balanceGreaterThanOrEqual(
        address lhs,
        address rhs
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        rhs.isNotNull();
        
        return lhs.balance.greaterThanOrEqual(rhs.balance);
    }
    
    function balanceLessThan(
        address lhs,
        address rhs
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        rhs.isNotNull();
        
        return lhs.balance.lessThan(rhs.balance);
    }
    function balanceLessThanOrEqual(
        address lhs,
        address rhs
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        rhs.isNotNull();
        
        return lhs.balance.lessThanOrEqual(rhs.balance);
    }
    // lhs.balance > 0
    function balanceGreaterThanZero(
        address lhs
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        
        return lhs.balance.greaterThanZero();
    }
    
    //function isNotZero(
        //address lhs
    //)public pure 
        //eturns(bool)
    //{
        //return lhs.isNotZero();
    //}
    
    // lhs > 0 && rhs > 0 && lhs == rhs
    function balanceGreaterThanZeroAndEqual(
        address lhs,
        address rhs
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        rhs.isNotNull();
        
        uint256 lBal = lhs.balance;
        uint256 rBal = rhs.balance;
        
        return lBal.greaterThanZero() &&
            rBal.greaterThanZero() &&
            lBal.equal(rBal);
    }
    // lhs > 0 && rhs > 0 && lhs != rhs
    function balanceGreaterThanZeroAndNotEqual(
        address lhs,
        address rhs
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        rhs.isNotNull();
        
        uint256 lBal = lhs.balance;
        uint256 rBal = rhs.balance;
        
        return lBal.greaterThanZero() &&
            rBal.greaterThanZero() &&
            lBal.notEqual(rBal);
    }
    /**
    *RHS operatnd type uint256
    */
    function balanceEqual(
        address lhs,
        uint256 amount
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        
        return lhs.balance.equal(amount);
    }
    // lhs.balance != rhs.balance
    function balanceNotEqual(
        address lhs,
        uint256 amount
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        //return lhs.balance ^ rhs.balance != 0;
        return lhs.balance.notEqual(amount);
    }
    function balanceGreaterThan(
        address lhs,
        uint256 rhs
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        
        return lhs.balance.greaterThan(rhs);
    }
    function balanceGreaterThanOrEqual(
        address lhs,
        uint256 rhs
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        
        return lhs.balance.greaterThanOrEqual(rhs);
    }
    
    function balanceLessThan(
        address lhs,
        uint256 rhs
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        
        return lhs.balance.lessThan(rhs);
    }
    function balanceLessThanOrEqual(
        address lhs,
        uint256 rhs
    )public pure
        returns(bool)
    {
        lhs.isNotNull();
        
        return lhs.balance.lessThanOrEqual(rhs);
    }
}