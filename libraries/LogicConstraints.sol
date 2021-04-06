// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/StatusCodes/generalCodes.sol";
import "https://github.com/vigilance91/solidarity/EIP/StatusCodes/logicCodes.sol";

/// @title Logic Contraints Library
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require),
/// for logical operations, reverting EVM state on failure.
library LogicConstraints
{
    function requireTrue(
        bool b
    ) public pure
    {
        require(b, logicCodes.NOT_EQUAL);
    }
    function requireFalse(
        bool b
    ) public pure
    {
        require(!b, logicCodes.NOT_EQUAL);
    }
    //overload for error reporting string
    function requireTrue(
        bool b,
        string memory message
    ) public pure
    {
        require(b, message);
    }
    function requireFalse(
        bool b,
        string memory message
    ) public pure
    {
        require(!b, message);
    }
    function alwaysRevert(
    )public pure
    {
        require(false, generalCodes.NOT_APPLICABLE);
    }
    function alwaysRevert(
        string memory message
    )public pure
    {
        require(false, message);
    }
}