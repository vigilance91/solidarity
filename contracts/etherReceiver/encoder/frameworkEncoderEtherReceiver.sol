// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/encoder/iEncoderEtherReceiver.sol";
///
/// @title Ether Receiver Transaction Encoder Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
/// @dev Any contract capable of receiving Ether transfers should inherit and implement this interface
///
library frameworkEncoderEtherReceiver
{
    //string private constant _NAME = ' frameworkEncoderEtherReceiver: ';
    //
    using LogicConstraints for bool;
    using AddressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    bytes4 private constant _INTERFACE_ID = type(iEncoderEtherReceiver).interfaceId;
    
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
    ///
    /// @return {bytes}
    ///
    function onEtherReceived(
        address encoder,
        address from,
        uint256 amount
    )external pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return aiEncoderEtherReceiver(encoder).onEtherReceiver(
            from,
            amount
        );
    }
}