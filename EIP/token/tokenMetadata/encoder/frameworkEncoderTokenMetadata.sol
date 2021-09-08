// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/apoptosis/encoder/iEncoderApoptosis.sol";
///
/// @title EIP-1046 ABI Transaction Encoder Framework Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 8/9/2021, All Rights Reserved
///
library frameworkEncoderTokenMetadata
{
    //string private constant _NAME = ' frameworkEncoderTokenMetadata: ';
    //
    using LogicConstraints for bool;
    using AddressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    bytes4 private constant _INTERFACE_ID = type(iEncoderEIP1049).interfaceId;
    
    function _requireSupportsInterface(
        address encoder
    )private
    {
        encoder.requireNotNull();
        encoder.isContract().requireTrue(
            'address not a contract'
        );
        
        encoder.supportsInterface(_INTERFACE_ID).requireTrue(
            'contract does not implement iEncoderTokenMetadata'
        );
    }
    ///  
    /// @return {bytes} signature used for a call to a external address or proxy which support the TokenIdentifier interface
    /// 
    function tokenURI(
        address encoder
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncodertokenMetadata(encoder).tokenURI();
    }
}