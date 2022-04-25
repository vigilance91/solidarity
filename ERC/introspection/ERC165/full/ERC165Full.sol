// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/full/iERC165Full.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/batched/ERC165Batched.sol";
///
/// @title ERC-165 Compliant Interface Support Introspection Contract Implementation
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 25/3/2022, All Rights Reserved
///
abstract contract ERC165Full is iERC165Full,
    ERC165,
    ERC165Batched
{
    //using mixinERC165 for bytes32;
    
    bytes4 internal constant _IID_ERC165_FULL = type(iERC165Full).interfaceId;

    constructor(
    )internal
        ERC165()
        ERC165Batched()
    {
        _registerInterface(_IID_ERC165_FULL);
    }
    
}