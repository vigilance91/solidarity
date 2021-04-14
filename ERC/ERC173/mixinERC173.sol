// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";
import "https://github.com/vigilance91/solidarity/ERC/ERC173/eventsERC173.sol";
///
/// @title ERC173 Mixin Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
///
library mixinERC173
{
    using AddressConstraints for address;
    using eventsERC173 for address;
    
    struct ERC173Storage {
        address owner;
    }
    
    bytes32 public constant STORAGE_SLOT = keccak256("ERC-173.mixin.storage");
    
    function storageERC173(
    )internal pure returns(
        ERC173Storage storage ret
    ){
        bytes32 position = STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
    ///
    ///read-only interface
    ///
    function owner(
    )internal view returns(
        address
    ){
        return storageERC173().owner;
    }
    function ownerPayable(
    )internal view returns(
        address payable
    ){
        address O = storageERC173().owner;
        
        O.requireNotNull(
            ///"owner can not be NULL"
        );
        return payable(O);
    }
    function requireOwner(
        address sender
    )internal view
    {
        address O = owner();
        
        O.requireNotNull(
            ///"owner can not be NULL"
        );
        O.requireEqual(
            sender
            ///"caller not owner"
        );
    }
    ///
    ///mutable interface
    ///
    function transferOwnership(
        address newOwner
    )internal
    {
        //prevent assignment to owner if account is already owner
        address owner O = owner();
        
        O.requireNotEqual(newOwner);
        O.emitTransferOwnership(newOwner);
        
        storageERC173().owner = newOwner;
    }
    function renounceOwnership(
    )internal
    {
        transferOwnership(AddressLogic.NULL);
    }
}