// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Logic.sol";
//import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";

//import "https://github.com/vigilance91/solidarity/libraries/address/addressBalanceLogic.sol";
import "./addressBalanceLogic.sol";
/// 
/// @title This (contract delegate context) Balance Logic Utilities
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// @notice trivial library for logical or bitwise operations on the balances of a contract, not provided natively by Solidity.
/// 
library thisBalanceLogic
{
    //using AddressConstraints for address;
    using addressBalanceLogic for address;
    //
    //check balance of this calling contract context vs balance of address `rhs`
    //
    function thisBalanceEqual(
        address rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceEqual(rhs);
    }
    // lhs.balance != rhs.balance
    function thisBalanceNotEqual(
        address rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceNotEqual(rhs);
    }
    function thisBalanceGreaterThanZeroAndEqual(
        address rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceGreaterThanZeroAndEqual(
            rhs
        );
    }
    function thisBalanceGreaterThanZeroAndNotEqual(
        address rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceGreaterThanZeroAndNotEqual(
            rhs
        );
    }
    function thisBalanceGreaterThan(
        address rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceGreaterThan(
            rhs
        );
    }
    function thisBalanceGreaterThanOrEqual(
        address rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceGreaterThanOrEqual(
            rhs
        );
    }
    
    function thisBalanceLessThan(
        address rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceLessThan(
            rhs
        );
    }
    function thisBalanceLessThanOrEqual(
        address rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceLessThanOrEqual(
            rhs
        );
    }
    //
    //check balance of this calling contract context vs balance of address `rhs`
    //
    function thisBalanceIsZero(
    )internal view returns(
        bool
    ){
        return address(this).balanceIsZero();
    }
    function thisBalanceGreaterThanZero(
    )internal view returns(
        bool
    ){
        return address(this).balanceGreaterThanZero(
        );
    }
    function thisBalanceEqual(
        uint256 rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceEqual(
            rhs
        );
    }
    // lhs.balance != rhs.balance
    function thisBalanceNotEqual(
        uint256 rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceNotEqual(
            rhs
        );
    }
    function thisBalanceGreaterThan(
        uint256 rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceGreaterThan(
            rhs
        );
    }
    function thisBalanceGreaterThanOrEqual(
        uint256 rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceGreaterThanOrEqual(
            rhs
        );
    }
    
    function thisBalanceLessThan(
        uint256 rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceLessThan(
            rhs
        );
    }
    function thisBalanceLessThanOrEqual(
        uint256 rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceLessThanOrEqual(
            rhs
        );
    }
    //
    function thisBalanceGreaterThanZeroAndEqual(
        uint256 rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceGreaterThanZeroAndEqual(
            rhs
        );
    }
    function thisBalanceGreaterThanZeroAndNotEqual(
        uint256 rhs
    )internal view returns(
        bool
    ){
        return address(this).balanceGreaterThanZeroAndNotEqual(
            rhs
        );
    }
}