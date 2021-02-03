// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.2 <0.8.0;

/// @title Logic Contraints
/// @author Tyler R. Drury - 3/1/2021, ALl Rights Reserved
/// @dev trivial utilities for constraining the state of the EVM (using require),
/// for logical operations, reverting EVM state on failure.
library LogicConstraints
{
    function requireTrue(bool b) public pure{
        require(b); //'must be true'
    }
    function requireFalse(bool b) public pure{
        require(!b);    //"must be false"
    }
    function requireTrue(bool b, string memory message) public pure{
        require(b, message);
    }
    function requireFalse(bool b, string memory message) public pure{
        require(!b, message);
    }
    function alwaysRevert()public pure{
        require(false);
    }
    function alwaysRevert(string memory message)public pure{
        require(false, message);
    }
}