// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/encoder/iEncoderEtherReceiver.sol";
///
/// @title Ether Transactor Encoder Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
/// @dev Any contract capable of receiving Ether transfers should inherit and implement this interface
///
library iEncoderEtherTransactor
{
    //string private constant _NAME = ' frameworkEncoderEtherTransactor: ';
    //
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    bytes4 private constant _INTERFACE_ID = type(iEncoderEtherTransactor).interfaceId;
    
    function _requireSupportsInterface(
        address encoder
    )private
    {
        encoder.requireNotNull();
        encoder.isContract().requireTrue(
            'address not a contract'
        );
        
        encoder.supportsInterface(_INTERFACE_ID).requireTrue(
            'contract does not implement iEncoderEtherReceiver'
        );
    }
    
    /// @dev transfer ETH from this contract to recipient
    function ethThisTransferTo(
        address encoder,
        address recipient,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEtherTransactor(encoder).ethThisTransferTo(
            recipient,
            amount
        );
    }
    /// @dev convenience wrapper to transfer ETH from this contract's balance to owner
    function ethThisTransferToOwner(
        address encoder,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEtherTransactor(encoder).ethThisTransferToOwner(
            amount
        );
    }
}