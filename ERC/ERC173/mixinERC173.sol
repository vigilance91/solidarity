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
        //bytes32 hash;
        address owner;
    }
    
    bytes32 private constant _TYPE_HASH = keccak256(
        "ERC173Storage(uint256 chainid,bytes32 hash,address owner)"
    );
    
    bytes32 internal constant STORAGE_SLOT = keccak256("ERC-173.mixin.storage");
    
    function storageERC173(
        bytes32 slot
    )internal pure returns(
        ERC173Storage storage ret
    ){
        assembly {
            ret_slot := slot
        }
    }
    /*
    function encodeERC173(
        uint256 chainId,
        address owner
    )internal pure returns(
        bytes memory
    ){
        return abi.encodePacked(
            _TYPE_HASH,
            chainId,
            keccak256(
                abi.encodePacked(
                    chainId, 
                    owner
                )
            ),
            owner
        );
    }
    function encodeERC173(
        bytes32 slot,
        uint256 chainId
    )internal pure returns(
        bytes memory
    ){
        return encodeERC173(
            chainId,
            owner(slot)
        );
    }
    function decodeERC173(
        bytes memory data
    )internal pure returns(
        address owner
    ){
        bytes32 typeHash;
        uint256 chainid;
        bytes32 ownerHash;
        
        (
            typeHash,
            chainid,
            ownerHash,
            owner
        ) = abi.decode(
            data,
            (bytes32, uint256, bytes32, address)
        );
        
        //mixinChainId.requireEqual(chainid);
        //typeHash.requireEqual(_TYPE_HASH);
        //ownerHash.requireEqual(
            //keccak256(
                //abi.encodePacked(chainid, owner)
            //)
        //);
    }
    
    function structHashERC173(
        address account
    )internal pure returns(
        bytes32
    ){
        return keccak256(
            encodeERC173(account)
        );
    }
    */
    ///
    ///read-only interface
    ///
    function owner(
        bytes32 slot
    )internal view returns(
        address
    ){
        return storageERC173(slot).owner;
    }
    function ownerPayable(
        bytes32 slot
    )internal view returns(
        address payable
    ){
        address O = storageERC173(slot).owner;
        //prevent paying null address
        O.requireNotNull(
            ///"owner can not be NULL"
        );
        return payable(O);
    }
    function requireOwner(
        //bytes32 slot,
        address sender
    )internal view
    {
        address O = owner(slot);
        
        O.requireNotNull(
            ///"owner can not be NULL"
        );
        O.requireEqual(
            sender
            ///"caller not owner"
        );
    }
    //function requireOwnerIsNull(
        //bytes32 slot
    //)internal view
    //{
        //owner(slot).requireNull();
    //}
    ///
    ///mutable interface
    ///
    function transferOwnership(
        bytes32 slot,
        //uint256 chainId,
        address newOwner
    )internal
    {
        //prevent assignment to owner if account is already owner
        address O = owner(slot);
        
        O.requireNotEqual(newOwner);
        
        //storageERC173 storage so = storageERC173(slot);
        
        //so.chainId.requireEqual(chainId);
        storageERC173(slot).owner = newOwner;
        //so.hash = keccak256(
            //abi.encodePacked(
                //chainId,
                //newOwner
            //)
        //);
        
        O.emitTransferOwnership(newOwner);
    }
    function renounceOwnership(
        bytes32 slot
        //uint256 chainId
    )internal
    {
        transferOwnership(
            slot,
            //chainId,
            AddressLogic.NULL
        );
    }
}