// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";

import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/EIP801Canary.sol";

//import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/iEtherReceiver.sol";
//import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/eventsEtherReceiver.sol";
import "./iEtherReceiver.sol";
import "./eventsEtherReceiver.sol";

import "./BalanceConstraints.sol";

//interface iCanaryEtherReceiver is iEIP801Canary,
//    iEtherReceiver
//{
//    
//}
///
/// @title Ether Reciever Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
///
abstract contract EtherReceiverABC is EIP801Canary, //SafeEIP801Canary,
    ThisUint256Balance,
    iEtherReceiver
{
    using eventsEtherReceiver for address;
    
    bytes4 internal constant _ETHER_RECEIVED = iEtherReceiver.onEtherReceived.selector;
    
    //receive(
    //)external virtual payable nonReentrant
    //{
        //_this.emitEtherReceived(
            //_msgSender(),
            //_msgValue(),
            //_balance()
        //);
    //}
    
    constructor(
    )internal 
        EIP801Canary()
        ThisUint256Balance()
    {
        _registerInterface(type(iEtherReceiver).interfaceId);
        //_registerInterface(type(iCanaryEtherReceiver).interfaceId);
    }
    /// @dev must be public, so it can be called from a contracts {receive()} function
    function onEtherReceived(
        address from,
        uint256 amount
    )public virtual override returns(
        bytes4
    ){
        //require(amount > 0, 'insufficient funds');
        address(this).emitReceivedEther(from, amount);
        
        return _ETHER_RECEIVED;
    }
    function canReceiveEther(
    )external view virtual override returns(    //nonReentrant
        bool
    ){
        return true;
    }
}