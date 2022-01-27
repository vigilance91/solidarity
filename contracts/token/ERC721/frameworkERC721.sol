// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/ERC721/iERC721Receiver.sol";
///
/// @title framework for ERC721 Transfer Introspection
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 20/4/2021, All Rights Reserved
///
library frameworkERC721
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    //using frameworkERC173 for address;
    
    bytes private constant _ERC721_RECEIVE_SIGNATURE = abi.encodeWithSignature('canReceiveERC721()');
    
    bytes4 private constant _iERC721_RECEIVER_ID = type(iERC721Receiver).interfaceId;
    bytes4 public constant _ERC721_RECEIVED = iERC721Receiver.onERC721Received.selector;
    
    function _requireSupportsInterface(
        address recipient
    )private
    {
        recipient.supportsInterface(_iERC721_RECEIVER_ID).requireTrue(
            'contract does not implement iERC721Receiver'
        );
    }
    
    function canReceiveERC721(
        address target
    )public view returns(
        bool ret
    ){
        target.requireNotNull(
        );
        
        if(!target.isContract()){
            return true;
        }
        
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _ERC721_RECEIVE_SIGNATURE
        );
        success.requireTrue(
            'staticcall failed'
        );
        
        (ret) = abi.decode(result, (bool));
    }
    
    function onERC721Received(
        address recipient,
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    )public returns(
        bool
    ){
        recipient.requireNotNull();
        
        if(!recipient.isContract()){
            return true;
        }
        
        _requireSupportsInterface(recipient);
        
        (bool success, bytes memory result) = recipient.call(
            abi.encodeWithSignature(
                'onERC721Received(address,address,uint256,bytes)',
                operator,
                from,
                tokenId,
                data
            )
        );
        
        success.requireTrue('onERC721Received: call failed');
        
        (bytes4 retval) = abi.decode(result, (bytes4));
        
        return (retval == _ERC721_RECEIVED);
    }
    /**
    //transfer `amount` of tokens from this contract to Owner
    function safeTransferToOwner(
        address target,
        uint256 amount
    )public returns(
        bool
    ){
        //target.supportsInterface(_iERC173_ID).requireTrue(
            //'contract does not implement ERC173'
        //);
        
        address O = target.owner();
        
        _requireCanReceiveERC721(O);
        
        target.transfer(
            address(this),
            O,
            amount
        );
        
        return true;
    }
    */
}