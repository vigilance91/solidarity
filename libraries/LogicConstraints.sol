// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/StatusCodes/generalCodes.sol";
import "https://github.com/vigilance91/solidarity/EIP/StatusCodes/logicCodes.sol";
/// 
/// @title Logic Contraints Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require) for logical/boolean operations,
/// reverting EVM state on failure
/// 
library LogicConstraints
{
    //bool internal constant TRUE = true;
    //bool internal constant FALSE = false;
    
    //using stringUtilities fro string;
    
    // todo change LogicConstraints to Logic
    // b must be true
    function assertTrue(
        bool b
    )internal pure
    {
        assert(b);
    }
    // b must be false
    function assertFalse(
        bool b
    )internal pure
    {
        assert(!b);
    }
    //using statusMessage for string;
    //using stringUtilities for string;
    
    function requireTrue(
        bool b
    )internal pure
    {
        //assembly{
            //if(!b){
                //revert(0,0);
            //}
        //}
        require(
            b,
            logicCodes.NOT_EQUAL //logicCodes.FALSE.concatenate(message)
        );
    }
    function requireFalse(
        bool b
    )internal pure
    {
        //assembly{
            //if(b){
                //revert(0,0);
            //}
        //}
        require(
            !b,
            logicCodes.NOT_EQUAL    //logicCodes.TRUE.concatenate(message)
        );
    }
    //overload for error reporting string
    function requireTrue(
        bool b,
        string memory message
    )internal pure
    {
        require(
            b,
            message //logicCodes.FALSE.concatenate(message)
        );
    }
    function requireFalse(
        bool b,
        string memory message
    )internal pure
    {
        require(
            !b,
            message //logicCodes.TRUE.concatenate(message)
        );
    }
    function alwaysRevert(
    )internal pure
    {
        //assembly{
            //revert(0,0);
        //}
        require(
            false,
            generalCodes.INAPPLICABLE
        );
    }
    function alwaysRevert(
        string memory message
    )internal pure
    {
        require(
            false,
            message     //generalCodes.INAPPLICABLE.concatenate(message);
        );
    }
}