// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/ReentrancyGuard.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/ERC173/iERC173.sol";
import "https://github.com/vigilance91/solidarity/ERC/ERC173/mixinERC173.sol";

import "https://github.com/vigilance91/solidarity/ERC/ERC173/ERC173ViewABC.sol";
///
/// @title ERC-173 compliant Ownership Mutable Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/3/2021, All Rights Reserved
/// 
/// @dev Contract providing access control mechanism to an exclusive an account with access to specific functions
/// The owning account is the deployers of the contract by default,
/// which can change by calling {transferOwnership}
///
/// NOTE:
///     Although non-standard, for convenience and security this implementation of ERC173
///     also implementats ReentrancyGuard to protect external ownership transfer functions
///     from reentrancy attacks using the modifier {nonReentrant}. which can easily be utilized
///     optionally by all derived contracts.
///
/// NOTE:
///     using {nonReentrant} modifier prevents Proxying,
///     since proxies resolve delegatecalls on public functions ONLY,
///     since a contract's {fallback()} function calls functions internally,
///     this is NOT allowed with functions marked as {nonReentrant} and will cause the transaction to revert
///
abstract contract ERC173MutableABC is Context,
    ERC173ViewABC,
    //VersionedDomain,
    iERC173Mutable
{
    using addressConstraints for address;
    
    using mixinERC173 for bytes32;
    
    string private constant _NAME = ' - ERC173MutableABC: ';
    
    string private constant _ERR_OWNER_IS_NULL = string(
        abi.encodePacked(
            _NAME,
            "owner is NULL"
        )
    );
    
    string private constant _ERR_OWNER_NOT_NULL = string(
        abi.encodePacked(
            _NAME,
            "owner is not NULL"
        )
    );
    
    bytes32 private _storageSlotERC173;
    
    /// @dev Initializes the contract setting the deployer as the initial owner
    constructor(
        bytes32 storageSlot
    )internal
        Context()
        //ContractConstraintsABC()
    {
        _storageSlotERC173 = storageSlot;
        
        //_storageSlotERC173.set(_msgSender());
        _storageSlotERC173.transferOwnership(_msgSender());
    }
    ///
    /// @dev Leaves the contract without owner. It will not be possible to call
    /// `onlyOwner` functions anymore. Can only be called by the current owner.
    ///
    /// NOTE: Renouncing ownership will leave the contract without an owner,
    /// thereby removing any functionality that is only available to the owner.
    function _renounceOwnership(
    )internal
    {
        _storageSlotERC173.renounceOwnership();
    }
    ///
    /// @dev Transfer ownership of this contract to a new address (`newOwner`),
    /// can only be called by the current owner
    /// NOTICE newOwner can be either a wallet address OR a contract
    /// if newOwner is a contract which does NOT support ERC173 and/or
    /// is NOT programmed to transfer ownership, ownership is lost forever!
    ///
    function _transferOwnership(
        address newOwner
    )internal
    {
        newOwner.requireNotNull(
            //_"transferOwnership"
        );
        //contract can not own itself
        _requireNotThis(newOwner);
        
        _storageSlotERC173.transferOwnership(newOwner);
    }
}