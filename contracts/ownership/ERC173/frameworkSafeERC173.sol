// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/ERC173/iERC173Receiver.sol";
import "https://github.com/vigilance91/solidarity/ERC/ERC173/iERC173.sol";
///
/// @title framework for ERC173 Safe Transfer Introspection
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
///
library frameworkSafeERC173
{
    using LogicConstraints for bool;
    using AddressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    //string private constant _NAME = ' frameworkSafeERC173: ';
    
    bytes private constant _ERC173_RECEIVE_SIGNATURE = abi.encodeWithSignature('canReceiveERC173()');
    bytes private constant _ERC173_OWNER_SIGNATURE = abi.encodeWithSignature('owner()');
    bytes private constant _ERC173_RENOUNCE_OWNERSHIP_SIGNATURE = abi.encodeWithSignature('renounceOwnership()');
    
    bytes4 private constant _iERC173_ID = type(iERC173).interfaceId;
    bytes4 private constant _iERC173_RECEIVER_ID = type(iERC173Receiver).interfaceId;
    
    bytes4 public constant _ERC173_RECEIVED = iERC173Receiver.onERC173Received.selector;
    
    /// @dev can target support ERC173 calls
    function _requireSupportsInterfaceERC173(
        address target
    )private view
    {
        target.supportsInterface(_iERC173_ID).requireTrue(
            'contract does not implement iERC173'
        );
    }
    /// @dev can target address accept ERC173 ownership transfers
    function _requireSupportsInterfaceERC173Receiver(
        address target
    )private view
    {
        if(target.isContract()){
            target.supportsInterface(_iERC173_RECEIVER_ID).requireTrue(
                'contract does not implement iERC173Receiver'
            );
        }
    }
    /// @dev pre-check to determine if an address is capable of accepting ERC173 ownership transfers
    function canReceiveERC173(
        address target
    )public view returns(
        bool ret
    ){
        target.requireNotNull(
        );
        
        if(!target.isContract()){
            return true;
        }
        
        _requireSupportsInterfaceERC173Receiver(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _ERC173_RECEIVE_SIGNATURE
        );
        success.requireTrue('staticcall failed');
        
        (ret) = abi.decode(result, (bool));
    }
    /// @dev post-check to determine if an address successfully accepted an ERC173 ownership transfer
    function onERC173Received(
        address recipient,
        address from
    )public returns(
        bool
    ){
        recipient.requireNotNull();
        
        if(!recipient.isContract()){
            return true;
        }
        
        _requireSupportsInterfaceERC173Receiver(recipient);
        
        (bool success, bytes memory result) = recipient.call(
            abi.encodeWithSignature(
                'onERC173Received(address)',
                from
            )
        );
        
        success.requireTrue('onERC173Received: call failed');
        
        (bytes4 retval) = abi.decode(result, (bytes4));
        
        return (retval == _ERC173_RECEIVED);
    }
    /// 
    /// @dev if address is an externally owned wallet address the null address is returned,
    /// since a person in the real world owns the address, not a contract,
    /// this behaviour is in line with ERC173's function owner(), which returns null if the address does not have an owner
    /// 
    function owner(
        address target
    )public view returns(
        address ret
    ){
        target.requireNotNull(
        );
        //if address is an externally owned wallet address,
        //returns NULL
        if(!target.isContract()){
            return AddressLogic.NULL;
        }
        
        _requireSupportsInterfaceERC173(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _ERC173_OWNER_SIGNATURE
        );
        success.requireTrue('staticcall failed');
        
        (ret) = abi.decode(result, (address));
    }
    /// 
    /// @dev the calling contract context transfers ownership of `target` to `newOwner`, only if the calling contract has ownership of `target`
    ///
    /// Requirements:
    ///     * the contract (the calling context) which calls this library function must be the owner of target
    ///     * `newOwner` cannot be null, call {revokeOwnership} to set owner to null
    ///
    function transferOwnership(
        address currentOwner,
        address target,
        address newOwner
    )public
    {
        address O = owner(target);
        
        //currentOwner.requireEqualAndNotNull(O);
        O.requireNotEqualAndNotNull(newOwner);
        //if address is an externally owned wallet address, ownership cannot be transfered
        target.isContract().requireTrue(
            'target must be a contract to transfer ownership'
        );
        
        _requireSupportsInterfaceERC173(target);
        
        canReceiveERC173(newOwner);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                'transferOwnership(address)',
                newOwner
            )
        );
        success.requireTrue(
            'frameworkSafeERC173: transferOwnerhip call failed'
        );
        
        onERC173Received(newOwner, address(this));
    }
    /// 
    /// @dev the calling contract context renounces ownership of target, if it has ownership
    ///
    /// Requirements:
    ///    * the contract (the calling context) which calls this library function must be the owner of target
    ///
    function renounceOwnership(
        address currentOwner,
        address target
    )public
    {
        address O = owner(target);
        
        O.requireNotNull();
        //O.requireEqualAndNotNull(currentOwner);
        require(O == currentOwner, 'invalid owner');
        //if address is an externally owned wallet address
        target.isContract().requireTrue(
            'target must be a contract to renounce ownership'
        );
        
        _requireSupportsInterfaceERC173(target);
        
        (bool success, ) = target.call(
            _ERC173_RENOUNCE_OWNERSHIP_SIGNATURE
        );
        
        success.requireTrue(
            'frameworkSafeERC173: renounceOwnerhip call failed'
        );
    }
}