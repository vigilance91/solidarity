// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "./uint256Logic.sol";
/// 
/// @title Utilities for gas
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 27/4/2021, All Rights Reserved
/// @notice specialized uint256 logic operations for block.timestamps, not provided natively by Solidity
/// 
library blockGasLogic
{
    using uint256Logic for uint;
    /**
    assembly instructions
        * gas() - gas still available to execution
        * gasprice() - gas price of the transaction
        * gaslimit() -  block gas limit of the current block
    */
    /**
    function gasLeftEqual(
        uint rhs
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := eq(gas(),rhs)
        }
    }
    function gasLeftNotEqual(
        uint rhs
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := not(eq(gas(),rhs))
        }
    }
    */
    function gasLeftGreaterThan(
        uint rhs
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := gt(gas(),rhs)
        }
    }
    function gasLeftGreaterThanOrEqual(
        uint rhs
    )internal pure returns(
        bool ret
    ){
        assembly{
            let G := gas()
            ret := or(gt(G,rhs), eq(G,rhs))
        }
    }
    function gasLeftLessThan(
        uint rhs
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := lt(gas(),rhs))
        }
    }
    function gasLeftLessThanOrEqual(
        uint rhs
    )internal pure returns(
        bool ret
    ){
        assembly{
            let G := gas()
            ret := or(lt(G,rhs), eq(G,rhs))
        }
    }
    function gasLeftGreaterThanZero(
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := not(iszero(gas()))
        }
    }
    /// @dev trivial and redundant
    function transactionPriceGreaterThanZero(
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := not(iszero(gasprice()))
        }
    }
    /// @dev trivial and redundant
    function gasLimitGreaterThanZero(
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := not(iszero(gaslimit()))
        }
    }
    /// @dev price of transaction should always be less than the block gas limit
    function gasPriceLessThanGasLimit(
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := lt(gasprice(), gaslimit())
        }
    }
    function gasLeftLessThanGasLimit(
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := lt(gas(), gaslimit())
        }
    }
    /// gas remaining is in range [0, gaslimt()], exclusively
    function gasLeftInBoundsExclusive(
    )internal pure returns(
        bool ret
    ){
        assembly{
            let G := gas()
            ret := and(lt(G, gaslimit()), not(iszero(G)))
        }
    }
    //
    //gas limited by transaction cost
    //
    //probably will be the most used function in the library, along with `gasLeftGreaterThanOrEqualTransactionPrice`
    function gasLeftGreaterThanTransactionPrice(
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := gt(gas(),gasprice())
        }
    }
    function gasLeftGreaterThanOrEqualTransactionPrice(
    )internal pure returns(
        bool ret
    ){
        assembly{
            let G := gas()
            let GP := gasprice()
            ret := or(gt(G,GP), eq(G,GP))
        }
    }
    function gasLeftLessThanTransactionPrice(
    )internal pure returns(
        bool ret
    ){
        assembly{
            ret := lt(gas(),gasprice())
        }
    }
    function gasLeftLessThanOrEqualTransactionPrice(
    )internal pure returns(
        bool ret
    ){
        assembly{
            let G := gas()
            GP = gasprice()
            ret := or(lt(G,GP), eq(G,GP))
        }
    }
    // trivial
    //function gasLeftInBoundsInclusive(
    //)internal pure returns(
        //bool ret
    //){
        //assembly{
            //let G := gas()
            //ret := and(lt(G, gaslimit()), not(iszero(G)))
        //}
    //}
    //function gasLeftInBoundsInclusive(
    //)internal pure returns(
        //bool ret
    //){
        //assembly{
            //let G := gas()
            //ret := and(lt(G, gasprice()), not(iszero(G)))
        //}
    //}
}