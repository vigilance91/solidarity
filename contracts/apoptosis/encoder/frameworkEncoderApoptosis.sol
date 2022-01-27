// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/apoptosis/encoder/iEncoderApoptosis.sol";
///
/// @title Apoptosis ABI Transaction Encoder Framework Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
/// convenience library for creating encoded signatures for low-level address call operations on external contracts or proxies
///
library frameworkEncoderApoptosis
{
    string private constant _NAME = ' frameworkEncoderApoptosis: ';
    
    string private constant _STR_ADRS = ' address: ';
    
    string private constant _ERR_IS_NOT_CONTRACT = string(
        abi.encodePacked(
            _NAME,
            'is not contract',
            _STR_ADRS
        )
    );
    string private constant _ERR_INTERFACE_NOT_SUPPORTED = string(
        abi.encodePacked(
            _NAME,
            'iEncoderApoptosis not implemented at',
            _STR_ADRS
        )
    );
    //
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    bytes4 private constant _INTERFACE_ID = type(iEncoderApoptosis).interfaceId;
    
    function _requireSupportsInterface(
        address encoder
    )private
    {
        encoder.requireNotNull();
        encoder.isContract().requireTrue(
            string(
                abi.encodePacked(
                    _ERR_INTERFACE_NOT_SUPPORTED,
                    encoder
                )
            )
        );
        
        encoder.supportsInterface(_INTERFACE_ID).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_INTERFACE_NOT_SUPPORTED,
                    encoder
                )
            )
        );
    }
    function castEncoderApoptosis(
        address encoder
    )internal view returns(
        iEncoderApoptosis
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderApoptosis(encoder);
    }
    function castThisEncoderApoptosis(
    )internal view returns(
        iEncoderApoptosis
    ){
        return iEncoderApoptosis(address(this));
    }
    ///  
    /// @return {bytes} signature used for a call to a external address or proxy which support the TokenIdentifier interface
    /// 
    function apoptosis(
        address encoder
    )internal pure returns(
        bytes memory
    ){
        return castEncoderApoptosis(encoder).apoptosis();
    }
}