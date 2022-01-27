// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/ERC173/iERC173Ownable.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/ERC173/owner/iERC173Owner.sol";
///
/// @title ERC173 Ownable Owner Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/1/2021, All Rights Reserved
///
interface iERC173OwnableOwner is iERC173Ownable,
    iERC173Owner
{
    function transferOwnershipToThisOwner(
        address ownable
    )external;
}