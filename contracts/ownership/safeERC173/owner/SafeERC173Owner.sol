// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/ERC/ERC173/ERC173Ownable.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/ERC173/owner/ERC173Owner.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/safeERC173/frameworkSafeERC173.sol";
///
/// @title Safe ERC173 Owner Implementation
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 22/4/2021, All Rights Reserved
/// @dev ERC-165 as well, since ERC173 contracts do not care if tokens are transfered to a wallet address or a contract address,
/// this non-standard ERC173 implementation enforces contraints requiring contracts which are transfered tokens to implement iERC173Reciever,
/// as well as provide custom implementation logic for handeling out transfers from the implementing contract,
/// otherwise, by default, any ownership transfers to an arbitrary contract would be locked forever (this was a horrible design choice by default),
/// since that contract (most likely) does not implement any mechanism to transfer ownership, or interact with ERC173 compliant contracts by default
/// 
/// This contract itself does not natively have an owner and mean to be autonomous.
/// If the contract is intended to own other contracts and also is itself owned by another ERC173 compliant contract,
/// please inherit from `SafeERC173OwnableOwner`
///
abstract contract SafeERC173OwnerABC is ERC173Owner
{
    using logicConstraints for bool;
    
    using Address for address;
    
    using addressLogic for address;
    using addressConstraints for address;
    
    using frameworkERC165 for address;
    using frameworkSafeERC173 for address;
    
    constructor(
    )internal
        ERC173Owner()
    {
    }
    /// @dev this contract supports ownership transfers to some other address
    function _safeTransferOwnership(
        address ownable,
        address newOwner
    )internal
    {
        //_requireSupportsInterface(recipient);
        address O = ownable.owner();
        
        O.requireNotNull();
        O.requireEqual(
            address(this)
            //'invalid owner'
        );
        
        //revert transaction if this contract is already owner of ownable,
        //don't waste ether on redundant call
        address(this).requireNotEqualAndNotNull(newOwner);
        
        _requireCanReceiveERC173(newOwner);
        
        address(this).transferOwnership(ownable, newOwner);
        
        _requireOnERC173Received(newOwner, address(this));
    }
    function _safeRenounceOwnership(
        address ownable
    )internal
    {
        address O = ownable.owner();
        
        O.requireNotNull();
        O.requireEqual(
            address(this)
            //'invalid owner'
        );
        
        address(this).renounceOwnership(ownable);
        
        //_requireOnERC173Received(addressLogic.NULL, address(this));
        
        //assert(ownable.owner().equal(addressLogic.NULL));
    }
}

interface iSafeERC173Owner is iERC173Owner
{
    function externalOwner(
        address ownable
    )external pure returns(       //virtual override
        address
    );
    //
    //safe functions
    //
    function externalSafeTransferOwnership(
        address ownable,
        address newOwner
    )external;
    // 
    // @dev this contract renounces ownership of `ownable`, only if this contract is `ownable`s owner,
    // otherwise transaction will revert
    // 
    function externalSafeRenounceOwnership(
        address ownable
    )external;
}

abstract contract SafeERC173Owner is SafeERC173OwnerABC,
    iSafeERC173Owner
{
    using frameworkSafeERC173 for address;
    
    bytes4 private constant _IID_SAFE_ERC173_OWNER = type(iSafeERC173Owner).interfaceId;
    
    contract(
    )internal
        SafeERC173OwnerABC()
    {
        _registerInterface(_IID_SAFE_ERC173_OWNER);  //type(iSafeERC173Owner).interfaceId);
    }
    function externalOwner(
        address ownable
    )public pure override returns(   //virtual override
        address
    ){
        return ownable.owner();
    }
    /// 
    /// @dev if this contract owns `ownable`, transfer ownership to `newOwner`,
    /// only if `newOwner` is either a wallet or an implementer of iSafeERC173Owner
    ///
    /// Requirements:
    ///     * `ownable` cannot be null, this contract nor this contract's owner
    ///     * `newOwner` cannot be null and if a contract address, must implement iERC173Owner
    ///     * `newOwner` cannot be this contract, prevent redundant transaction
    ///
    function externalSafeTransferOwnership(
        address ownable,
        address newOwner
    )external override onlyOwner nonReentrant
    {
        _safeTransferOwnership(ownable, newOwner);
    }
    /// 
    /// @dev this contract renounces ownership of `ownable`, only if this contract is `ownable`s owner,
    /// otherwise transaction will revert
    /// 
    function externalSafeRenounceOwnership(
        address ownable
    )external override onlyOwner nonReentrant
    {
        _safeRenounceOwnership(ownable);
    }
}

interface iSafeERC173OwnableOwner is iSafeERC173Ownable,
    iSafeERC173Owner
{
}

contract SafeERC173OwnableOwner is SafeERC173Ownable,
    SafeERC173Owner,
    iSafeERC173OwnableOwner
{
    //bytes4 public constant IID_SAFE_ERC173_OWNABLE = type(iSafeERC173Ownable).interfaceId;
    bytes4 private constant _IID_SAFE_ERC173_OWNABLE_OWNER = type(iSafeERC173OwnableOwner).interfaceId;
    
    contract(
    )public
        SafeERC173Ownable()
        SafeERC173Owner()
    {
        //_registerInterface(IID_SAFE_ERC173_OWNABLE);
        _registerInterface(_IID_SAFE_ERC173_OWNABLE_OWNER);
    }
    /// 
    /// @dev override for _safeTransferOwnership but exclusively transfers ownership of `ownable` contract address to this contract's owner,
    ///
    /// Requirements:
    ///     * this contract's owner must not be null, otherwise call _safeRenounceOwnership
    ///     * `ownable` must not already be this contract's owner
    ///
    function _safeTransferOwnershipToThisOwner(
        address ownable
    )internal
    {
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
        
        _safeTransferOwnership(ownable, thisOwner);
        
        //ownable.owner().requireEqual(
            //thisOwner
        //);
    }
    // note: not safe, not recommended for use
    //function transferOwnershipToThisOwner(
        //address ownable
    //)external onlyOwner nonReentrant
    //{
        //_transferOwnershipToThisOwner(ownable);
    //}
    /// 
    /// @dev like _safeTransferOwnership but exclusively transfers ownership of `ownable` contract address to this contract's owner,
    ///
    /// Requirements:
    ///     * this contract's owner must not be null, otherwise call _safeRenounceOwnership
    ///     * `ownable` must not already be this contract's owner
    ///
    function safeTransferOwnershipToThisOwner(
        address ownable
    )external override onlyOwner nonReentrant
    {
        _safeTransferOwnershipToThisOwner(ownable);
    }
}