// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/TokenIdentifier/encoder/iEncoderTokenIdentifier.sol";
///
/// @title Token Identifier Transaction ABI Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
/// convenience library for creating encoded signatures for low-level address call operations
///
library frameworkEncoderTokenIdentifier
{
    //string private constant _NAME = ' frameworkEncoderTokenIdentifier: ';
    //
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    //string private constant _NAME = ' frameworkERC20: ';
    
    //bytes private constant _ERC20_RECEIVE_SIGNATURE = abi.encodeWithSignature('canReceiveERC20()');
    
    bytes4 private constant _INTERFACE_ID = type(iEncoderTokenIdentifier).interfaceId;
    //bytes4 private constant _iSTATIC_TOKEN_SUPPLY_ID = type(iStaticTokenSupply).interfaceId;
    //bytes4 private constant _iTOKEN_IDENTIFIER_ID = type(iTokenIdentifier).interfaceId;
    
    function _requireSupportsInterface(
        address encoder
    )private
    {
        encoder.requireNotNull();
        encoder.isContract().requireTrue(
            'address not a contract'
        );
        
        encoder.supportsInterface(_INTERFACE_ID).requireTrue(
            'contract does not implement iEncoderTokenIdentifier'
        );
    }
    ///  
    /// @return {bytes} signature used for a call to a external address or proxy which support the TokenIdentifier interface
    /// 
    function name(
        address encoder
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderTokenIdentifier(encoder).name();
    }
    ///
    /// @return {bytes} signature used for a call to a external address or proxy which support the TokenIdentifier interface
    ///
    function symbol(
        address encoder
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderTokenIdentifier(encoder).symbol();
    }
}