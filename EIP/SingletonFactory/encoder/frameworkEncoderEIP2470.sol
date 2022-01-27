// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.7.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/EIP/SingletonFactory/encoder/iEncoderEIP2470.sol";

//import "../TokenIdentifier/iTokenIdentifier.sol";
///
/// @dev EIP-2470 Transaction Encoder Framework Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
///
library frameworkEncoderEIP2470
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    bytes4 private constant _INTERFACE_ID = type(iEncoderEIP2470).interfaceId;
    
    function _requireSupportsInterface(
        address encoder
    )private
    {
        encoder.requireNotNull();
        encoder.isContract().requireTrue(
            'address not a contract'
        );
        
        encoder.supportsInterface(_INTERFACE_ID).requireTrue(
            'contract does not implement iEncoderEIP2470'
        );
    }
    ///
    /// read-only interface
    ///
    function deploy(
        bytes memory byteCode,
        bytes32 salt
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP2470(encoder).deploy(
            byteCode,
            salt
        );
    }
    
    function deployPayable(
        bytes memory byteCode,
        bytes32 salt
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP2470(encoder).deployPayable(
            byteCode,
            salt
        );
    }
}