// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Logic.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";
/// 
/// @title Address Balance Logic Utilities
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// @notice trivial library for logical or bitwise operations on the balances of addresses, not provided natively by Solidity.
/// 
library addressBalanceLogic
{
    using uint256Logic for uint256;
    
    using addressConstraints for address;
    /**
     * compare addresses and address related logic/binary/bitwise operations
    */
    /**
    modifier _notNull(
        address lhs
    )internal
    {
        lhs.requireNotNull();
        _;
    }
    modifier _notNull(
        address lhs,
        address rhs
    )internal
    {
        lhs.requireNotNull();
        rhs.requireNotNull();
        _;
    }
    modifier _isNull(
        address lhs
    )internal
    {
        lhs.requireIsNull();
        _;
    }
    modifier _isNull(
        address lhs,
        address rhs
    )internal
    {
        lhs.requireIsNull();
        rhs.requireIsNull();
        _;
    }
    */
    // lhs.balance == rhs.balance
    function balanceEqual(
        address lhs,
        address rhs
    )internal view returns(
        bool ret
    ){
        lhs.requireNotNull();
        rhs.requireNotNull();
        //return lhs.balance ^ rhs.balance == 0;
        assembly{
            ret := eq(balance(lhs),balance(rhs))
        }
    }
    // lhs.balance != rhs.balance
    function balanceNotEqual(
        address lhs,
        address rhs
    )internal view returns(
        bool ret
    ){
        lhs.requireNotNull();
        rhs.requireNotNull();
        //return lhs.balance ^ rhs.balance != 0;
        //return lhs.balance.notEqual(rhs.balance);
        assembly{
            ret := not(eq(balance(lhs),balance(rhs)))
        }
    }
    
    // lhs.balance == 0
    function balanceIsZero(
        address lhs
    )internal view returns(
        bool ret
    ){
        lhs.requireNotNull();
        //return lhs.balance.equalsZero();
        assembly{
            ret := iszero(balance(lhs))
        }
    }
    /**
    *RHS operatnd type address
    */
    function balanceGreaterThan(
        address lhs,
        address rhs
    )internal view returns(
        bool ret
    ){
        lhs.requireNotNull();
        rhs.requireNotNull();
        //return lhs.balance.greaterThan(rhs.balance);
        assembly{
            ret := gt(balance(lhs),balance(rhs))
        }
    }
    function balanceGreaterThanOrEqual(
        address lhs,
        address rhs
    )internal view returns(
        bool ret
    ){
        lhs.requireNotNull();
        rhs.requireNotNull();
        //return lhs.balance.greaterThanOrEqual(rhs.balance);
        assembly{
            let lhsBal := balance(lhs)
            let rhsBal := balance(rhs)
            
            ret := or(gt(lhsBal,rhsBal),eq(lhsBal,rhsBal))
        }
    }
    function balanceLessThan(
        address lhs,
        address rhs
    )internal view returns(
        bool ret
    ){
        lhs.requireNotNull();
        rhs.requireNotNull();
        //return lhs.balance.lessThan(rhs.balance);
        assembly{
            ret := lt(balance(lhs),balance(rhs))
        }
    }
    function balanceLessThanOrEqual(
        address lhs,
        address rhs
    )internal view returns(
        bool ret
    ){
        lhs.requireNotNull();
        rhs.requireNotNull();
        //return lhs.balance.lessThanOrEqual(rhs.balance);
        assembly{
            let lhsBal := balance(lhs)
            let rhsBal := balance(rhs)
            
            ret := or(lt(lhsBal,rhsBal),eq(lhsBal,rhsBal))
        }
    }
    // lhs.balance > 0
    function balanceGreaterThanZero(
        address lhs
    )internal view returns(
        bool ret
    ){
        //lhs.requireNotNull();
        //return lhs.balance.greaterThanZero();
        //assembly{
            //ret := not(iszero(balance(lhs)))
        //}
        return lhs.balance > uint256Logic.ZERO;
    }
    
    //function balanceIsZero(
        //address lhs
    //)internal view returns(
        //bool
    //){
        //lhs.requireNotNull();
        //return lhs.balance.greaterThanZero();
        //assembly{
            //ret := not(iszero(balance(lhs)))
        //}
        //return lhs.balance == uint256Logic.ZERO;
    //}
    
    // lhs > 0 && rhs > 0 && lhs == rhs
    function balanceGreaterThanZeroAndEqual(
        address lhs,
        address rhs
    )internal view returns(
        bool
    ){
        lhs.requireNotNull();
        rhs.requireNotNull();
        
        //assembly{
            //let lBal = balance(lhs)
            //let rBal := balance(rhs)
            //ret := and(
                //and(not(iszero(lBal),not(iszero(rBal)),
                //eq(lBal,rBal)
            //)
        //}
        
        uint256 lBal = lhs.balance;
        uint256 rBal = rhs.balance;
        
        return lBal.greaterThanZero() &&
            rBal.greaterThanZero() &&
            lBal.equal(rBal);
    }
    function balanceGreaterThanZeroAndEqual(
        address lhs,
        uint256 rhs
    )internal view returns(
        bool
    ){
        lhs.requireNotNull();
        
        //assembly{
            //let lBal = balance(lhs)
            //ret := and(
                //and(not(iszero(lBal),not(iszero(rhs)),
                //eq(lBal,rhs)
            //)
        //}
        
        uint256 lBal = lhs.balance;
        
        return lBal.greaterThanZero() &&
            rhs.greaterThanZero() &&
            lBal.equal(rhs);
    }
    // lhs > 0 && rhs > 0 && lhs != rhs
    function balanceGreaterThanZeroAndNotEqual(
        address lhs,
        address rhs
    )internal view returns(
        bool
    ){
        lhs.requireNotNull();
        rhs.requireNotNull();
        
        //assembly{
            //let lBal = balance(lhs)
            //let rBal := balance(rhs)
            //ret := and(
                //and(not(iszero(lBal),not(iszero(rBal)),
                //not(eq(lBal,rBal))
            //)
        //}
        
        uint256 lBal = lhs.balance;
        uint256 rBal = rhs.balance;
        
        return lBal.greaterThanZero() &&
            rBal.greaterThanZero() &&
            lBal.notEqual(rBal);
    }
    function balanceGreaterThanZeroAndNotEqual(
        address lhs,
        uint256 rhs
    )internal view returns(
        bool
    ){  
        //assembly{
            //let lBal = balance(lhs)
            //ret := and(
                //and(not(iszero(lBal),not(iszero(rhs)),
                //not(eq(lBal,rhs))
            //)
        //}
        
        uint256 lBal = lhs.balance;
        
        return lBal.greaterThanZero() &&
            rhs.greaterThanZero() &&
            lBal.notEqual(rhs);
    }
    /*
    function balanceRatio(
        address lhs,
        address rhs
    )internal view returns(
        uint256 numerator,
        uint256 denominator
    ){
        lhs.requireNotNull();
        rhs.requireNotNull();
        
        return (
            lhs.balance,
            rhs.balance
        );
    }
    */
    /**
    *RHS operatnd type uint256
    */
    function balanceEqual(
        address lhs,
        uint256 amount
    )internal view returns(
        bool
    ){
        lhs.requireNotNull();
        return lhs.balance.equal(amount);
        //assembly{
            //ret := eq(balance(lhs),amount)
        //}
    }
    // lhs.balance != rhs.balance
    function balanceNotEqual(
        address lhs,
        uint256 amount
    )internal view returns(
        bool
    ){
        lhs.requireNotNull();
        //return lhs.balance ^ rhs.balance != 0;
        return lhs.balance.notEqual(amount);
        //assembly{
            //ret := not(eq(balance(lhs),amount))
        //}
    }
    function balanceGreaterThan(
        address lhs,
        uint256 rhs
    )internal view returns(
        bool ret
    ){
        lhs.requireNotNull();
        //return lhs.balance.greaterThan(rhs);
        assembly{
            ret := gt(balance(lhs),rhs)
        }
    }
    function balanceGreaterThanOrEqual(
        address lhs,
        uint256 rhs
    )internal view returns(
        bool ret
    ){
        lhs.requireNotNull();
        //return lhs.balance.greaterThanOrEqual(rhs);
        assembly{
            let bal := balance(lhs)
            ret := or(gt(bal,rhs),eq(bal,rhs))
        }
    }
    
    function balanceLessThan(
        address lhs,
        uint256 rhs
    )internal view returns(
        bool ret
    ){
        lhs.requireNotNull();
        //return lhs.balance.lessThan(rhs);
        assembly{
            ret := lt(balance(lhs),rhs)
        }
    }
    function balanceLessThanOrEqual(
        address lhs,
        uint256 rhs
    )internal view returns(
        bool ret
    ){
        lhs.requireNotNull();
        //return lhs.balance.lessThanOrEqual(rhs);
        assembly{
            let bal := balance(lhs)
            ret := or(lt(bal,rhs),eq(bal,rhs))
        }
    }
}