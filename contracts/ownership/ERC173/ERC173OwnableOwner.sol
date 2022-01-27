// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/ERC173/ERC173Ownable.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/ERC173/owner/ERC173Owner.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/ERC173/iERC173OwnableOwner.sol";
///
/// @title ERC173 Ownable Owner Implementation
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/1/2021, All Rights Reserved
/// @dev the inheriting contract can both own other contracts and is itself owned either by
/// an externally owned account (EOA/wallet) or another contract
/// 
/// this contract is not safe (contract ownership may be lost forever) and is not recommended for use
///
contract ERC173OwnableOwner is ERC173Ownable,
    ERC173Owner,
    iERC173OwnableOwner
{
    bytes4 private constant _IID_ERC173_OWNER = type(iERC173Owner).interfaceId;
    bytes4 private constant _IID_ERC173_OWNABLE_OWNER = type(iERC173OwnableOwner).interfaceId;
    
    contract(
    )public
        ERC173Ownable()
        ERC173Owner()
    {
        _registerInterface(_IID_ERC173_OWNER);
        _registerInterface(_IID_ERC173_OWNABLE_OWNER);
    }
    /// 
    /// @dev override for _safeTransferOwnership but exclusively transfers ownership of `ownable` contract address to this contract's owner,
    ///
    /// Requirements:
    ///     * this contract's owner must not be null, otherwise call _safeRenounceOwnership
    ///     * `ownable` must not already be this contract's owner
    ///
    function _transferOwnershipToThisOwner(
        address ownable
    )internal
    {
        //_requireIsContract(ownable);
        ownable.isContract().requireTrue(
            'ownable must be a contract'
        );
        
        address O = ownable.owner();
        
        O.requireNotNull();
        O.requireEqual(
            address(this)
            //'this contract is not owner, cannot transfer ownership'
        );
        
        address thisOwner = owner();
        //this is for external ownership transfers
        //thisOwner.requireNotEqualAndNotNull(O);
        //ensure contract doesn't own itself
        thisOwner.requireNotNull(
            //'owner is null, cannot transfer ownership'
        );
        //address(this).requireNotEqual(
            //thisOwner
            ////'contract cannot own itself'
        //);
        
        _transferOwnership(ownable, thisOwner);
        
        //ownable.owner().requireEqual(
            //thisOwner
        //);
    }
    /// 
    /// @dev like _safeTransferOwnership but exclusively transfers ownership of `ownable` contract address to this contract's owner,
    ///
    /// Requirements:
    ///     * this contract's owner must not be null, otherwise call _safeRenounceOwnership
    ///     * `ownable` must not already be this contract's owner
    ///
    function transferOwnershipToThisOwner(
        address ownable
    )external override onlyOwner nonReentrant
    {
        _transferOwnershipToThisOwner(ownable);
    }
}