// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/tokeb/ERC20/receiver/iERC20Receiver.sol";
///
/// @title framework for ERC20 Transfer Support Introspection of Contracts
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
///
library frameworkERC20Receiver
{
    //using externalConstraints for *;
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    string private constant _NAME = ' frameworkERC20Receiver: ';
    //string private constant _STUB_ON_ERC20_RECEIVED = 'onERC20Received(address,address,uint256)';
    
    bytes private constant _ERC20_RECEIVE_SIGNATURE = abi.encodeWithSignature('canReceiveERC20()');
    
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
    )internal view returns(
        bool ret
    ){
        target.requireNotNull();
        
        if(!target.isContract()){
            return true;
        }
        
        _requireSupportsInterface(target);
        
        (ret) = abi.decode(
            target.functionStaticCall(
                _ERC20_RECEIVE_SIGNATURE
            ),
            (bool)
        );
    }
    
    function onERC20Received(
        address token,
        address recipient,
        address from,
        uint256 amount
    )internal returns(
        bool
    ){
        //token.requireNotNull();
        token.requireIsContract();
        
        recipient.requireNotNull();
        
        if(!recipient.isContract()){
            return true;
        }
        
        _requireSupportsInterface(recipient);
        
        (bytes4 retval) = abi.decode(
            recipient.functionCall(
                abi.encodeWithSignature(
                    'onERC20Received(address,address,uint256)',
                    token,
                    from,
                    amount
                )
            ),
            (bytes4)
        );
        
        return (retval == _ERC20_RECEIVED);
    }
    /*
    function requireThisSupportsERC20Receiver(
    )internal view
    {
        _requireSupportsInterface(address(this));
    }
    function canThisReceiveERC20(
    )internal view returns(
        bool
    ){
        return canReceiveERC20(address(this));
    }
    
    function onThisERC20Received(
        //address token,
        address from,
        uint256 amount
    )internal returns(
        bool
    ){
        return onERC20Received(
            token,
            address(this),
            from,
            amount
        );
    }
    */
}