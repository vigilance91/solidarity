// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/addressBalanceLogic.sol";

/// @title Address Balance Contraints
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// @notice trivial utilities for constraining the state of the EVM (using require)
/// for address types, reverting on failure.
library addressBalanceConstraints
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using AddressBalanceLogic for address;
    //using stringUtilities for string;
    
    //string private constant LIB_NAME = 'AddressBalanceConstraints: ';
    
    //function requireBalanceEqual(
        //address lhs,
        //address rhs
    //) internal pure
    //{
        //lhs.equal(rhs).requireTrue(
            //"lhs.balance != rhs.balance"
        //);
    //}
    //function requireBalanceEqual(
        //address lhs,
        //address rhs
    //)public pure
    //{
        ////lhs.isNotNullAndNotEqual(rhs);
        
        //lhs.balanceEqual(rhs).requireTrue(
            ////_NAME.concatenate("lhs == rhs")
        //);
    //}
    function requireBalanceNotEqual(
        address lhs,
        address rhs
    )public pure
    {
        //lhs.isNotNullAndNotEqual(rhs);
        
        lhs.balanceNotEqual(rhs).requireTrue(
            //LIB_NAME.concatenate("lhs == rhs")
        );
    }
    // >
    function requireBalanceGreaterThan(
        address lhs,
        address rhs
    )public pure
    {
        lhs.balanceGreaterThan(rhs).requireTrue(
            //LIB_NAME.concatenate('not >')
        );
    }
    // >=
    function requireBalanceGreaterThanOrEqual(
        address lhs,
        address rhs
    )public pure
    {
        lhs.balanceGreaterThanOrEqual(rhs).requireTrue(
            //LIB_NAME.concatenate('not >=')
        );
    }
    // <
    function requireBalanceLessThan(
        address lhs,
        address rhs
    )public pure
    {
        lhs.balanceLessThan(rhs).requireTrue(
            //LIB_NAME.concatenate('not <')
        );
    }
    // <=
    function requireBalanceLessThanOrEqual(
        address lhs,
        address rhs
    )public pure
    {
        lhs.balanceLessThanOrEqual(rhs).requireTrue(
            //LIB_NAME.concatenate('not <=');
        );
    }
    
    function requireBalanceGreaterThanZero(
        address lhs
    )public pure
    {
        lhs.balanceGreaterThanZero().requireTrue(
            //LIB_NAME.concatenate('balance == 0')
        );
    }
    //function isNotZero(
        //address account
    //) public pure
    //{
        //account.isNotZero().requireTrue(
            //"balance must not be 0"
        //);
    //}
    function requireBalanceGreaterThanZeroAndEqual(
        address lhs,
        address rhs
    )public pure
    {
        lhs.balanceGreaterThanZero().requireTrue();
        rhs.balanceGreaterThanZero().requireTrue();
        
        lhs.balanceEqual(rhs).requireTrue();
    }
    function requireBalanceGreaterThanZeroAndNotEqual(
        address lhs,
        address rhs
    )public pure
    {
        lhs.balanceGreaterThanZeroAndNotEqual(rhs).requireTrue(
            //LIB_NAME.concatenate('balance not > 0 or not > rhs'
        );
    }
    /**
    *array functions
    */
    //function requireBalanceGreaterThanZeroAndNotEqualArray(
        //address self,
        //address[] memory container
    //)public pure
    //{
        ////logicConstraints.requireTrue(
            ////container.length > 0
        ////);
        
        //for(uint256 i = 0; i < container.length; i++){
            //address rhs = container[i];
            ////self.balanceGreaterThanZeroAndNotEqual(rhs).requireTrue();
            ////self.balanceNotEqual(rhs).requireTrue();
        //}
    //}
    
    //
    //amounts, rhs of type uint256
    //
    function balanceEqual(
        address lhs,
        uint256 amount
    )internal pure returns(
        bool ret
    ){
        lhs.requireNotNull();
        //return lhs.balance.equal(amount);
        assembly{
            ret := eq(balance(lhs),amount)
        }
    }
    // lhs.balance != rhs.balance
    function balanceNotEqual(
        address lhs,
        uint256 amount
    )internal pure returns(
        bool ret
    ){
        lhs.requireNotNull();
        //return lhs.balance ^ rhs.balance != 0;
        //return lhs.balance.notEqual(amount);
        assembly{
            ret := not(eq(balance(lhs),amount))
        }
    }
    function balanceIsZero(
        address lhs
    )internal pure returns(
        bool ret
    ){
        return balanceEqual(lhs, 0);
    }
    function balanceGreaterThan(
        address lhs,
        uint256 rhs
    )internal pure returns(
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
    )internal pure returns(
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
    )internal pure returns(
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
    )internal pure returns(
        bool ret
    ){
        lhs.requireNotNull();
        //return lhs.balance.lessThanOrEqual(rhs);
        assembly{
            let bal := balance(lhs)
            ret := or(lt(bal,rhs),eq(bal,rhs))
        }
    }
    /*
    //calling contract context
    //
    function thisBalanceEqual(
        uint256 amount
    )internal pure returns(
        bool
    ){
        return balanceEqual(
            address(this)
        );
    }
    // lhs.balance != rhs.balance
    function thisBalanceNotEqual(
        uint256 amount
    )internal pure returns(
        bool
    ){
        return balanceLessThanOrEqual(
            address(this)
        );
    }
    function balanceGreaterThan(
        uint256 rhs
    )internal pure returns(
        bool
    ){
        return balanceGreaterThanOrEqual(
            address(this)
        );
    }
    function thisBalanceGreaterThanOrEqual(
        uint256 rhs
    )internal pure returns(
        bool
    ){
        return balanceGreaterThanOrEqual(
            address(this)
        );
    }
    
    function thisBalanceLessThan(
        uint256 rhs
    )internal pure returns(
        bool
    ){
        return balanceLessThan(
            address(this)
        );
    }
    function thisBalanceLessThanOrEqual(
        uint256 rhs
    )internal pure returns(
        bool
    ){
        return balanceLessThanOrEqual(
            address(this)
        );
    }
    //
    //check calling contract's balance against address `rhs`
    //
    function thisBalanceEqual(
        address rhs
    )internal pure returns(
        bool
    ){
        return balanceEqual(
            rhs.balance
        );
    }
    // lhs.balance != rhs.balance
    function thisBalanceNotEqual(
        address rhs
    )internal pure returns(
        bool
    ){
        return balanceLessThanOrEqual(
            rhs.balance
        );
    }
    function balanceGreaterThan(
        address rhs
    )internal pure returns(
        bool
    ){
        return balanceGreaterThanOrEqual(
            rhs.balance
        );
    }
    function thisBalanceGreaterThanOrEqual(
        address rhs
    )internal pure returns(
        bool
    ){
        return thisBalanceGreaterThanOrEqual(
            rhs.balance
        );
    }
    
    function thisBalanceLessThan(
        address rhs
    )internal pure returns(
        bool
    ){
        return thisBalanceLessThan(
            rhs.balance;
        );
    }
    function thisBalanceLessThanOrEqual(
        address rhs
    )internal pure returns(
        bool
    ){
        return thisBalanceLessThanOrEqual(
            rhs.balance;
        );
    }
    */
}