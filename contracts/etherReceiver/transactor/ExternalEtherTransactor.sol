// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/EtherTransactorABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/iEtherTransactor.sol";

import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/EIP801Canary.sol";

//import "https://github.com/vigilance91/solidarity/libraries/msg/value/msgValueConstraints.sol";
///
/// @title External Ether Transactor Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev Fully realized External extension of EtherTransactorABC which provides safe ETH transfer functionality,
/// similar to ERC20 tokens but for ETH and can be easily implemented in other dApps or be used as a stand alone contract
///
contract ExternalEtherTransactor is EIP801Canary,
    EtherTransactorABC,
    iEtherTransactor
{
    using SafeMath for uint256;
    
    using LogicConstraints for bool;
    
    using AddressConstraints for address;
    using AddressConstraints for address payable;
    
    //using uint256Constraints for uint256;
    
    using frameworkEtherReceiver for address;
    
    string private constant _NAME = ' ExternalEtherTransactor: ';
    //string private constant _TRANSFER_FAILED = _NAME.concatenate('transfer failed');
    
    //enable proxying to execute optional callback when making an ETH transfer?
    //fallback()external payable{
        //LogicConstraints.alwaysRevert(
            //'fallback() '.concatenate(ContractErrors.FUNCTION_DELETED)
        //);
    //}
    
    constructor(
    )public
        EIP801Canary()
        EtherTransactorABC()
    {
        _registerInterface(type(iEtherReceiver).interfaceId);
        _registerInterface(type(iEtherTransactor).interfaceId);
    }
    /// @dev convenience wrapper to transfer ETH from msg.sender to contract's owner
    function ethTransferToOwner(
    )external payable virtual nonReentrant
    {
        address O = owner();
        
        //_requireNotThisAndNotNull(O, sender);   //prevent self ownership, this contract does not support ERC-173
        _msgSender().requireNotEqualAndNotNull(O);
        //_requireCanReceiveEther(sender);
        
        //_requireMsgValueGreatherThanZero();
        require(msg.value > 0, 'msg.value must be non-zero');
        //note, this contract becomes the new msg.sender in the receiver() function
        (bool success, ) = payable(O).call{value:msg.value}("");
        
        success.requireTrue('ethTransferToOwner failed');
    }
    /// @dev transfer ETH from this contract to recipient
    function ethThisTransferTo(
        address recipient,
        uint256 amount
    )external virtual override onlyOwner nonReentrant
    {
        //_requireNotThisAndNotNull(recipient);
        recipient.requireNotEqualAndNotNull(owner());
        //_requireCanReceiveEther(recipient);
        
        //_requireTransact(_this(), recipient, amount);
        
        _requireBalanceGreaterThanOrEqual(amount);
        
        _ethThisTransferTo(recipient, amount);
    }
    /// @dev convenience wrapper to transfer ETH from this contract's balance to owner
    function ethThisTransferToOwner(
        uint256 amount
    )external virtual override onlyOwner nonReentrant
    {
        //_requireNotThisAndNotNull(O);
        //_requireCanReceiveEther(O);
        //_requireTransact(_this(), O, amount);
        _requireBalanceGreaterThanOrEqual(amount);
        
        _ethThisTransferTo(owner(), amount);
    }
    function ethTransferToThis(
    )external virtual override payable nonReentrant
    {
        //_requireMsgValueGreatherThanZero();
        
        require(msg.value > 0, 'msg.value must be non-zero');
        //note, this contract becomes the new msg.sender in the receiver() function
        (bool success, ) = payable(address(this)).call{value:msg.value}("");
        
        success.requireTrue('ethTtransferToThis failed');
    }
}