// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/ERC173/ERC173Ownable.sol";

import "https://github.com/vigilance91/solidarity/contracts/ContractConstraints.sol";
///
/// @title Ownable Contract Constraints Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev provides Contract Constraints functionality in addition to ERC-173 Ownership and ERC-165 Interface Support,
/// with ERC-173 specific contraints for the owner of a contract
///
abstract contract OwnableContractConstraintsABC is ERC173Ownable,
    ContractConstraintsABC
{
    constructor(
    )internal ERC173Ownable(),
        ContractConstraintsABC()
    {
    }
    //revert if owner is NOT null
    function _requireOwnerNull(
    )internal view
    {
        _requireNull(owner());
    }
    //revert if Owner is null
    function _requireOwnerNotNull(
    )internal view
    {
        _requireIsNotNull(owner());
    }
    //revert on self ownership
    function _requireOwnerNotThis(
    )internal view
    {
        _requireNotThis(owner());
    }
    //revert if owner is self or null
    function _requireOwnerNotThisAndNotNull(
    )internal view
    {
        _requireNotThisAndNotNull(owner());
    }
    //enforce self ownership of contract
    /**
    function _requireOwnerIsThisAndNotNull(
    )internal view
    {
        address O = owner();
        
        O.requireIsNotNull();
        
        _this.requireEqual(O);
    }
    */
}