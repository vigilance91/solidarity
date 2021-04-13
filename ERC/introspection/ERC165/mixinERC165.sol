// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/eventsERC165.sol";
///
/// @title Mixin for the ERC-165 Interface Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 24/3/2021, All Rights Reserved
///
library mixinERC165
{
    //using LogicConstraints for bool;
    using eventsERC165 for bytes4;
    
    bytes32 internal constant STORAGE_SLOT = keccak256("ERC-165.mixin.storage");
    //string internal constant _LIB_NAME = ' mixinERC165: ';
    
    struct ERC165Storage {
        mapping(bytes4=>bool) supportedInterfaces;
    }
    ///
    ///getters
    ///
    function storageERC165(
    )internal pure returns(
        ERC165Storage storage ret
    ){
        bytes32 position = STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
    function supportedInterfaces(
    )internal view returns(
        mapping(bytes4=>bool) storage
    ){
        return storageERC165().supportedInterfaces;
    }
    function supportsInterface(
        bytes4 interfaceId
    )internal view returns(
        bool
    ){
        return supportedInterfaces()[interfaceId];
        //return storageERC165().supportedInterfaces[interfaceId];
    }
    ///
    ///setters
    ///
    function setSupportsInterface(
        bytes4 interfaceId,
        bool supported
    )internal
    {
        require(
            interfaceId != 0xffffffff,  //&& interfaceId != 0x00000000
            "invalid interface id"
        );
        storageERC165().supportedInterfaces[interfaceId] = supported;
        
        //interfaceId.emitInterfaceSupported(supported);
        //return supportedInterfaces()[interfaceId];
    }
}