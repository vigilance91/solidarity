// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Address.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";
//import "./iEIP801.sol";
import "./ERC173Ownable.sol";

/*
interface iEIP801Death
{
    function apoptosis(
    )external payable;
    
    //function deathTimestamp(
    //)external view returns(uint);
    
    //function deathBlock(
    //)external view returns(uint);
    
    //function timeSinceDeath(
    //)external view returns(uint);
    
    //function blocksSinceDeath(
    //)external view returns(uint);
    
    //function blockAdjustedTimeSinceDeath(
    //)external view returns(uint);
    
    //function deathHash(
    //)external view returns(uint);
}
*/
///
/// @title Framework Library for EIP-801 Canary Standard
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// 
//library frameworkEIP801
//{
    //
//}