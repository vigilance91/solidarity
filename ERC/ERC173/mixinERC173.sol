// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";
import "https://github.com/vigilance91/solidarity/ERC/ERC173/eventsERC173.sol";

///
/// @title ERC173 Mixin Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
///
library mixinERC173
{
    using addressConstraints for address;
    
    using eventsERC173 for address;
    
    struct ERC173Storage {
        //bytes32 hash;
        address owner;
    }
    string private constant _NAME = " - mixinERC173: ";
    //error message when it's required that owner must not be null
    string private constant _ERR_OWNER_IS_NULL = string(
        abi.encodePacked(
            _NAME,
            "owner is NULL"
        )
    );
    //error message when it's required that owner must be null
    string private constant _ERR_OWNER_NOT_NULL = string(
        abi.encodePacked(
            _NAME,
            "owner is not NULL"
        )
    );
    //error message when caller/msg.sender of a transaction is not owner
    string private constant _ERR_CALLER_NOT_OWNER = string(
        abi.encodePacked(
            _NAME,
            "caller not owner"
        )
    );
    
    bytes32 private constant _TYPE_HASH = keccak256(
        "ERC173Storage(bytes32 hash,uint256 chainid,bytes32 slot,address owner)"
    );
    
    bytes32 internal constant STORAGE_SLOT = bytes32(uint256(
        keccak256("erc173.mixin.STORAGE_SLOT")
    ) - 1);
    
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
    //function encodeDefaultStorageERC173(
        //ERC173Storage storage self
    //)internal pure returns(
        //bytes memory
    //){
        //cid = chainId();
        
        //return abi.encodePacked(
            //keccak256(
                //abi.encodePacked(
                    //_TYPE_HASH,
                    //cid,
                    //STORAGE_SLOT,
                    //self.owner
                //)
            //),
            //_TYPE_HASH,
            //cid,
            //STORAGE_SLOT,
            //self.owner
        //);   
    //}
    function encodeERC173(
        uint256 chainId,
        bytes32 slot,
        address owner
    )internal pure returns(
        bytes memory
    ){  
        return abi.encodePacked(
            keccak256(
                abi.encodePacked(
                    _TYPE_HASH,
                    chainId,
                    slot,
                    owner
                )
            ),
            _TYPE_HASH,
            chainId,
            slot,
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
            slot,
            owner(slot)
        );
    }
    function encodeDefaultStorageERC173(
    )internal pure returns(
        bytes memory
    ){
        return encodeERC173(
            mixinChainId.chainId(),
            STORAGE_SLOT,
            owner(STORAGE_SLOT)
        );
    }
    /// @return {address} `data` decoded as an ERC173 owner
    function decodeERC173(
        bytes memory data
    )internal pure returns(
        address owner
    ){
        bytes32 dataHash;
        bytes32 typeHash;
        uint256 chainid;
        bytes32 slot;
        
        (
            dataHash,
            typeHash,
            chainid,
            slot,
            owner
        ) = abi.decode(
            data,
            (bytes32, bytes32, uint256, bytes32, address)
        );
        
        //mixinChainId.requireEqual(chainid);
        //typeHash.requireEqual(_TYPE_HASH);
        //dataHash.requireEqual(
            //keccak256(
                //abi.encodePacked(typehash, chainid, slot, owner)
            //)
        //);
    }
    
    /// @return {address} `data` decoded as an ERC173 owner
    function decodeDefaultStorageERC173(
        bytes memory data
    )internal pure returns(
        address owner
    ){
        bytes32 dataHash;
        bytes32 typeHash;
        uint256 chainid;
        bytes32 slot;
        
        (
            dataHash,
            typeHash,
            chainid,
            slot,
            owner
        ) = abi.decode(
            data,
            (bytes32, bytes32, uint256, bytes32, address)
        );
        
        //slot.requireEqual(
            //STORAGE_SLOT
            ////string(abi.encodePacked(
                ////'invalid storage slot:', slot
                ////"expected: ",
                ////STORAGE_SLOT
            ////))
        //);
        //mixinChainId.requireEqual(
            //chainid
            //////string(abi.encodePacked('invalid chainId:', chainid))
        //);
        //typeHash.requireEqual(
            //_TYPE_HASH
            ////string(abi.encodePacked(
                ////'invalid type hash:',
                ////typeHash,
                ////"expected: ",
                ////_TYPE_HASH
            ////))
        //);
        //dataHash.requireEqual(
            //keccak256(
                //abi.encodePacked(typeHash, chainid, slot, owner)
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
            //_ERR_OWNER_IS_NULL
        );
        return payable(O);
    }
    function requireOwner(
        bytes32 slot,
        address sender
    )internal view
    {
        address O = owner(slot);
        
        O.requireNotNull(
            //_ERR_OWNER_IS_NULL
        );
        O.requireEqual(
            sender
            //_ERR_CALLER_NOT_OWNER
        );
    }
    function requireOwnerIsNull(
        bytes32 slot
    )internal view
    {
        owner(slot).requireIsNull();
    }
    ///
    ///mutable interface
    ///
    function initialize(
        bytes32 slot,
        address owner
    )internal
    {
        requireOwnerIsNull(slot);
        
        storageERC173(slot).owner = owner;
    }
    function dealloc(
        bytes32 slot
    )internal
    {
        //_requireInitialized(slot);
        
        delete storageERC173(slot).owner;
    }
    function transferOwnership(
        bytes32 slot,
        //uint256 chainId,
        address newOwner
    )internal
    {
        //_requireInitialized(slot);
        
        //prevent assignment to owner if account is already owner
        address O = owner(slot);
        
        O.requireNotEqual(newOwner);
        
        //storageERC173 storage so = storageERC173(slot);
        
        //so.chainId.requireEqual(chainId);
        storageERC173(slot).owner = newOwner;
        //so.hash = keccak256(
            //abi.encodePacked(
                ////_TYPE_HASH,
                //chainId,
                //slot,
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
            addressLogic.NULL
        );
    }
    
    //function _requireInitialized(
        //bytes32 slot
    //)internal view
    //{
        //storageERC173(slot).owner.requireNotNull(
            //_ERR_OWNER_IS_NULL
        //);
    //}
    
    //function _requireNotInitialized(
        //bytes32 slot
    //)internal view
    //{
        //storageERC173(slot).owner.requireNull(
            //_ERR_OWNER_NOT_NULL
        //);
    //}
    
    //transfer state from storage slot `from` to storage slot `to`,
    //removing the previous state of storage slot `from`
    //function transferStateERC173(
        //bytes32 from,
        //bytes32 to
    //)internal
    //{
        //_requireInitialized(from);
        ////_requireNotInitialized(to);
        
        //ERC173Storage storage s = storageERC173(from);
        
        //s.owner.requireNotNull(
            //_ERR_OWNER_IS_NULL
        //);
        
        //transferOwnership(to, s.owner);
        
        //renounceOwnership(from);
        //dealloc(from);
    //}
    
    //transfer without removing the previous state at storage slot `from`
    //function copyStateERC173(
        //bytes32 from,
        //bytes32 to
    //)internal
    //{
        //_requireInitialized(from);
        ////_requireNotInitialized(to);
        
        //ERC173Storage storage s = storageERC173(from);
        
        //s.owner.requireNotNull(
            //_ERR_OWNER_IS_NULL
        //);
        
        //transferOwnership(to, s.owner);
    //}
    
    ////function swapStateERC173(
        ////bytes32 lhs,
        ////bytes32 rhs
    ////)internal
    ////{
        //ERC173Storage storage sl 
        //address LO = storageERC173(lhs).owner;
        
        //ERC173Storage storage sr = 
        //address RO = storageERC173(rhs).owner;
        
        //transferOwnership(
            //lhs,
            //RO
        //);
        //transferOwnership(
            //rhs,
            //LO
        //);
    ////}
}