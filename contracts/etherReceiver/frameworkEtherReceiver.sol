// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/iEtherReceiver.sol";
///
/// @title framework for Ether Transfer Support Introspection of Contracts
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
///
library frameworkEtherReceiver
{
    using LogicConstraints for bool;
    using AddressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    //string private constant _NAME = ' frameworkEtherReceiver ';
    
    bytes private constant _ETHER_RECEIVE_SIGNATURE = abi.encodeWithSignature('canReceiveEther()');
    
    bytes4 private constant _iETHER_RECEIVER_ID = type(iEtherReceiver).interfaceId;
    bytes4 public constant _ETHER_RECEIVED = iEtherReceiver.onEtherReceived.selector;
    
    function _requireSupportsInterface(
        address target
    )private view
    {
        target.supportsInterface(_iETHER_RECEIVER_ID).requireTrue(
            'contract is not iEtherReceiver implementer'
        );
    }
    function canReceiveEther(
        address target
    )public returns(
        bool ret
    ){
        target.requireNotNull();
        
        if(!target.isContract()){
            return true;
        }
        
        _requireSupportsInterface(target);
        
        (ret) = abi.decode(
            target.functionStaticCall(
                _ETHER_RECEIVE_SIGNATURE
            ),
            (bool)
        );
    }
    
    function onEtherReceived(
        address recipient,
        address from,
        uint256 amount
    )public returns(
        bool
    ){
        recipient.requireNotNull();
        
        if(!recipient.isContract()){
            return true;
        }
        
        _requireSupportsInterface(recipient);
        
        (bytes4 retval) = abi.decode(
            recipient.functionCall(
                abi.encodeWithSignature(
                    'onEtherReceived(address,uint256)',
                    from,
                    amount
                )
            ),
            (bytes4)
        );
        
        return (retval == _ETHER_RECEIVED);
    }
}