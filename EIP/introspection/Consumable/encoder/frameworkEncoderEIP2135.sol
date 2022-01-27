// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/EIP/introspection/Consumable/encoder/iEncoderEIP2135.sol";
///
/// @title EIP-2135 Consumable Transaction Encoder Framework Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
/// @dev Ethereum Improvments Proposal: Consumable Interface: https://eips.ethereum.org/EIPS/eip-2135
/// consideration of ERC-721 was given when drafting this EIP and is backwards compatible with ERC-721
/// one example would be a ticket which is consumed to gain entry to an event
/// another would be a consumable, like a potion being used in a game
/// this EIP can also integrate with EIP1753, to create Consumable Licences
///
library frameworkEncoderEIP2135
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    bytes4 private constant _INTERFACE_ID = type(iEncoderEIP2135).interfaceId;
    
    function _requireSupportsInterface(
        address encoder
    )private
    {
        encoder.requireNotNull();
        encoder.isContract().requireTrue(
            'address not a contract'
        );
        
        encoder.supportsInterface(_INTERFACE_ID).requireTrue(
            'contract does not implement iEncoderEIP2135'
        );
    }
    
    function isConsumable(
        address encoder,
        uint256 assetId
    )public view override returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP2135(encoder).isConsumable(
            assetId
        );
    }
    
    function consume(
        address encoder,
        uint256 assetId
    )public virtual override returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP2135(encoder).consume(
            assetId
        );
    }
}