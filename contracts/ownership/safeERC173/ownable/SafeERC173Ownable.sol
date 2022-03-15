// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/ERC/ERC173/ERC173Ownable.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/ERC173/ERC173ReceiverConstraintsABC.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/safeERC173/frameworkSafeERC173.sol";
///
/// @title Safe ERC173 Implementation
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 22/4/2021, All Rights Reserved
/// @dev ERC-165 and EIP-173 support, as well,
/// since by default, ERC173 contracts do not care if tokens are transfered to a wallet address or a contract address,
/// this non-standard ERC173 implementation enforces contraints requiring contracts which are transfered tokens to implement iERC173Reciever,
/// as well as provide custom implementation logic for handeling out transfers from the implementing contract,
/// otherwise, by default, any ownership transfers to an arbitrary contract would be locked forever (this was a horrible design choice by default),
/// since that contract (most likely) does not implement any mechanism to transfer ownership, or interact with ERC173 compliant contracts by default
/// 
/// This entire class of bugs can be easily avoided simply by having a token contract implement SafeERC173Token,
/// instead of the standard ERC173Ownable contract (which this contract derives from),
/// found under solidarity/ERC/ERC173/
///
/// By default, this contract will revert if an ERC173 ownership transfer is made to this contract
///
/// If the implementing contract desires to accept ERC173 ownerhsip transfers,
/// simply inhert from both SafeERC173Ownable and ERC173ReceiverABC and ensure:
/// ```
/// _registerInterface(type(iERC173Reciever).interfaceId);
/// ```
/// is called from the derived contract's constructor, which is required for introspection support
///
abstract contract SafeERC173Ownable is ERC173Ownable,
    ERC173ReceiverConstraintsABC
{
    using logicConstraints for bool;
    
    using Address for address;
    
    using addressLogic for address;
    using addressConstraints for address;
    
    using frameworkERC165 for address;
    using frameworkSafeERC173 for address;
    
    constructor(
    )internal
        ERC173Ownable()
        ERC173ReceiverConstraintsABC()
    {
        //_registerInterface(type(iERC173Receiver).interfaceId);
        //_registerInterface(type(iSafeERC173Ownable).interfaceId);
    }
    //function _requireSupportsInterfaceSafeERC173(
        //address recipient
    //)private
    //{
        //recipient.supportsInterfaceSafeERC173Ownable(
            //'SafeERC173Ownable: contract is not ERC173 compliant'
        //);
    //}
    /// @dev this contract supports ownership transfers to some other address
    function _safeTransferOwnership(
        address newOwner
    )internal
    {
        //_requireSupportsInterfaceSafeERC173(recipient);
        address O = owner();
        address t = address(this);

        O.requireNotEqualAndNotNull(
            t
            //'invalid owner'
        );
        
        //revert transaction if this contract is already owner of ownable,
        //don't waste ether on redundant call
        t.requireNotEqualAndNotNull(newOwner);
        
        _requireCanReceiveERC173(newOwner);
        
        _transferOwnership(newOwner);
        
        _requireOnERC173Received(O, newOwner);
    }
    /*
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
    /// @dev like _safeTransferOwnership but exclusively transfers ownership of `ownable` contract address to this contract's owner,
    ///
    /// Requirements:
    ///     * this contract's owner must not be null, otherwise call _safeRenounceOwnership
    ///     * `ownable` must not already be this contract's owner
    ///
    function _safeTransferOwnershipToThisOwner(
        address ownable
    )internal virtual
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
    */
}