// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/EIP801Canary.sol";

import "https://github.com/vigilance91/solidarity/contracts/apoptosis/ApoptosisABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/apoptosis/iApoptosis.sol";

//interface iMortalCanary is iCanary,
//    iApoptosis
//{
//}

///
/// @title Apoptosis Extension for EIP-801 Canary
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 6/5/2021, All Rights Reserved
/// @dev EIP-801 Canary Standard with apoptosis support for programmed contract death,
/// tranfering this contract's balance to its owner upon death,
/// if the contract does not have an owner it can not be killed since its funds can not be transfered to a null address,
/// nor can apoptosis be externally executed if the owner is null
/// 
contract MortalCanary is EIP801Canary,
    ApoptosisABC,
    iApoptosis
{
    using eventsEIP801 for address;
    
    constructor(
    )public
        EIP801Canary()
        ApoptosisABC()
    {
        _registerInterface(type(iApoptosis).interfaceId);
        //_registerInterface(type(iMortalCanary).interfaceId);
    }
    
    //function deathTimestamp(
    //)public view returns(
        //uint
    //){
        //require(store.deathTimestamp > 0, 'not dead');
        //return _readOnlyMortalStorage().deathTimestamp;
    //}
    //function deathBlock(
    //)public view returns(
        //uint
    //){
        //require(store.deathBlock > 0, 'not dead');
        //return _readOnlyMortalStorage().deathBlock;
    //}
    //function setApoptosisTimestamp(
        //uint timestamp
    //) external onlyOwner
    //{
        //_tsTermination = timestamp;
        //_deathBlock = _approximateBlockNumberForTimestamp(timestamp, 15);
    //}
    
    function apoptosis(
    )external payable virtual override
        onlyOwner
        nonReentrant
    {
        //_requireAlive();
        _apoptosis(owner());
    }
}