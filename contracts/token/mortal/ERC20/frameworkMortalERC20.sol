// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/iERC20Receiver.sol";
///
/// @title framework for ERC20 Safe Transfer Introspection
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 6/5/2021, All Rights Reserved
///
library frameworkMortalERC20
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    //using frameworkERC173 for address;
    
    //string private constant _NAME = ' frameworkSafeERC20: ';
    
    bytes private constant _ERC20_RECEIVE_SIGNATURE = abi.encodeWithSignature('canReceiveERC20()');
    bytes private constant _APOPTOSIS_SIGNATURE = abi.encodeWithSignature('apoptosis()');
    
    bytes4 private constant _iERC20_RECEIVER_ID = type(iERC20Receiver).interfaceId;
    bytes4 public constant _ERC20_RECEIVED = iERC20Receiver.onERC20Received.selector;
    
    function _requireSupportsInterface(
        address target
    )private view
    {
        target.supportsInterface(_iERC20_RECEIVER_ID).requireTrue(
            'contract does not implement iERC20Receiver'
        );
    }
    function canReceiveERC20(
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
            _ERC20_RECEIVE_SIGNATURE
        );
        success.requireTrue('staticcall failed');
        
        (ret) = abi.decode(result, (bool));
    }
    
    function onERC20Received(
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
        
        (bool success, bytes memory result) = recipient.call(
            abi.encodeWithSignature(
                'onERC20Received(address,uint256)',
                from,
                amount
            )
        );
        
        success.requireTrue('onERC20Received: call failed');
        
        (bytes4 retval) = abi.decode(result, (bytes4));
        
        return (retval == _ERC20_RECEIVED);
    }
    /// @dev the contract (calling context) which calls this function 
    function apoptosis(
        address target
    )public
    {
        traget.requireNotNull();
        
        target.isContract().requireTrue(
            'apoptosis target must be a contract'
        );
        
        _requireSupportsInterfaceApoptosis(target);
        
        (bool success, ) = recipient.call(
            _APOPTOSIS_SIGNATURE
        );
        
        success.requireTrue('apoptosis: external call failed');
    }
}