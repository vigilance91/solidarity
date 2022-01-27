// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;


import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/encoder/iEncoderERC165.sol";
///
/// @dev ERC-165 Interface Support Transaction Encoder Framework Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
///
library frameworkEncoderERC165
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    bytes4 private constant _INTERFACE_ID = type(iEncoderERC165).interfaceId;
    
    function _requireSupportsInterface(
        address encoder
    )private
    {
        encoder.requireNotNull();
        encoder.isContract().requireTrue(
            'address not a contract'
        );
        
        encoder.supportsInterface(_INTERFACE_ID).requireTrue(
            'contract does not implement iEncoderERC165'
        );
    }
    
    function supportsInterface(
        address encoder,
        bytes4 interfaceId
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoder165(encoder).supportsInterface(
            interfaceId
        );
    }
}