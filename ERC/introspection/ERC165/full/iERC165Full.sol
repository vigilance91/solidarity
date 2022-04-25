// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/iERC165.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/batched/iERC165Batched.sol";
///
/// @title ERC-165 Full Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 25/3/2022, All Rights Reserved
///
interface iERC165Full is iERC165,
    iERC165Batched
{
}