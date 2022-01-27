// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/iAccessControlReceiver.sol";
///
/// @title framework for AccessControl Safe Transfer Introspection
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 9/12/2021, All Rights Reserved
///
library frameworkSafeAccessControl
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using Address for address;
    
    //using abiDecode for bytes;
    
    using frameworkERC165 for address;
    
    //string private constant _NAME = ' frameworkSafeAccessControl: ';
    
    bytes private constant _CAN_RECEIVE_ACCESS_CONTROL_SIGNATURE = abi.encodeWithSignature('canReceiveAccessControl()');
    //
    bytes4 private constant _iACCESS_CONTROL_RECEIVER_ID = type(iAccessControlReceiver).interfaceId;
    //
    bytes4 internal constant _ACCESS_CONTROL_RECEIVED = iAccessControlReceiver.onAcessControlReceived.selector;
    
    string internal constant _ON_ACCESS_CONTROL_RECEIVED_STUB = 'onAccessControlReceived(address,bytes32)';
    
    function _requireSupportsInterface(
        address recipient
    )private view
    {
        recipient.supportsInterface(_iACCESS_CONTROL_RECEIVER_ID).requireTrue(
            'contract does not implement iAccessControlReceiver'
        );
    }
    function canReceiveAccessControl(
        address recipient
    )internal view returns(
        bool ret
    ){
        recipient.requireNotNull(
        );
        
        if(!recipient.isContract()){
            return true;
        }
        
        _requireSupportsInterface(recipient);
        
        (bool success, bytes memory result) = recipient.staticcall(
            _CAN_RECEIVE_ACCESS_CONTROL_SIGNATURE
        );
        success.requireTrue('staticcall failed');
        
        //ret = result.decodeBool();
        (ret) = abi.decode(result, (bool));
    }
    
    function onAccessControlReceived(
        address recipient,
        address assigner,
        byes32 role
    )internal returns(
        bool
    ){
        recipient.requireNotNull();
        //assigner.requireNotNull();
        
        if(!recipient.isContract()){
            return true;
        }
        
        _requireSupportsInterface(recipient);
        
        (bool success, bytes memory result) = recipient.call(
            abi.encodeWithSignature(
                _ON_ACCESS_CONTROL_RECEIVED_STUB,
                assigner,
                role
            )
        );
        
        success.requireTrue('onAccessControlReceived: call failed');
        
        //bytes4 retval = result.decodeBytes4();
        (bytes4 retval) = abi.decode(result, (bytes4));
        
        return (retval == _ACCESS_CONTROL_RECEIVED);
    }
}