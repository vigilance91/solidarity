// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/string/stringConstraints.sol";
///
/// @title Mixin Library for EIP-1046 ERC20 Token Metadata Extension
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 7/4/2021, All Rights Reserved
/// @dev https://eips.ethereum.org/EIPS/eip-1046 by: Tommy Nicholas, Matt Russo, John Zettler, Matt Condon
///
library mixinEIP1046
{
    //using stringConstraints for string;
    ////using stringUtilities for string;
    
    struct EIP1046Storage {
        string tokenURI;
    }
    
    bytes32 internal constant _STORAGE_SLOT = keccak256("EIP-1046.token.metadata.storage");
    //string internal constant _NAME = " mixinEIP1046: ";
    
    function metadataStorage(
    )internal pure returns(
        EIP1046Storage storage ret
    ){
        bytes32 position = _STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
     
    function tokenURI(
    )internal view returns(
        string memory
    ){
        return metadataStorage().tokenURI;
    }
    //function requireInitialized(
    //)internal view
    //{
        //metadataStorage().tokenURI.requireNotEmpty(
            //'not initialized'
        //);
    //}
    //function requireNotInitialized(
    //)internal view
    //{
        //metadataStorage().tokenURI.requireEmpty(
            //'already initialized'
        //);
    //}
    function initialize(
        string memory externalTokenURI
    )internal //returns(Store storage)
    {
        //requireNotInitialized();
        //EIP1046Storage storage cs = metadataStorage();
        metadataStorage().tokenURI = externalTokenURI;
    }
}