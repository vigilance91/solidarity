// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/ERC/ERC173/encoder/iEncoderERC173.sol";
///
/// @title ERC-173 Ownership Transaction Encoder Framework Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
///
library frameworkEncoderERC173
{
    bytes internal constant SIG_OWNER = abi.encodeWithSignature('owner()');
    bytes internal constant SIG_RENOUNCE_OWNERSHIP = abi.encodeWithSignature('renounceOwnership()');
    
    string internal constant STUB_TRANSFER_OWNERSHIP = 'transferOwnership(address)';
    
    using LogicConstraints for bool;
    using AddressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    bytes4 private constant _INTERFACE_ID = type(iEncoderERC173).interfaceId;
    
    function _requireSupportsInterface(
        address encoder
    )private
    {
        encoder.requireNotNull();
        encoder.isContract().requireTrue(
            'address not a contract'
        );
        
        encoder.supportsInterface(_INTERFACE_ID).requireTrue(
            'contract does not implement iEncoderERC173'
        );
    }
    function owner(
        address encoder
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderERC173(encoder).owner();
    }
    function renounceOwnership(
        address encoder
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderERC173(encoder).renounceOwnership();
    }
    function transferOwnership(
        address encoder,
        address newOwner
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderERC173(encoder).transferOwnership(
            newOwner
        );
    }
}