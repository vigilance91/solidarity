// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/StatusCodes/generalCodes.sol";
import "https://github.com/vigilance91/solidarity/EIP/StatusCodes/logicCodes.sol";
import "https://github.com/vigilance91/solidarity/libraries/string/statusMessage.sol";
/// 
/// @title Logic Contraints Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require) for logical/boolean operations,
/// reverting EVM state on failure
/// 
library LogicConstraints
{
    //using statusMessage for string;
    //using stringUtilities for string;
    
    function requireTrue(
        bool b
    ) public pure
    {
        if(!b){
            require(b, logicCodes.NOT_EQUAL);   //logicCodes.FALSE.concatenate(message));
        }
    }
    function requireFalse(
        bool b
    ) public pure
    {
        if(b){
            require(!b, logicCodes.NOT_EQUAL);  //logicCodes.TRUE.concatenate(message));
        }
    }
    //overload for error reporting string
    function requireTrue(
        bool b,
        string memory message
    ) public pure
    {
        if(!b){
            require(b, message);    //logicCodes.FALSE.concatenate(message));
        }
    }
    function requireFalse(
        bool b,
        string memory message
    ) public pure
    {
        if(b){
            require(!b, message);   //logicCodes.TRUE.concatenate(message));
        }
    }
    function alwaysRevert(
    )public pure
    {
        require(false, generalCodes.INAPPLICABLE);
    }
    function alwaysRevert(
        string memory message
    )public pure
    {
        require(false, message);    //generalCodes.INAPPLICABLE.concatenate(message);
    }
}