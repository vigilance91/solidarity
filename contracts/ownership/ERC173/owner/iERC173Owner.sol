// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";
///
/// @title ERC173 Owner Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/1/2021, All Rights Reserved
///
interface iERC173Owner  //is iERC165
{
    function externalOwner(
        address ownable
    )external view returns(
        address
    );
    //
    //safe functions
    //
    function externalTransferOwnership(
        address ownable,
        address newOwner
    )external;
    /// 
    /// @dev this contract renounces ownership of `ownable`, only if this contract is `ownable`s owner,
    /// otherwise transaction will revert
    /// 
    function externalRenounceOwnership(
        address ownable
    )external;
}