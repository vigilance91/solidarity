// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Apoptosis Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev Programmed contract death external interface
/// 
interface iApoptosis
{
    function apoptosis(
    )external payable;
    
    //function deathTimestamp(
    //)external view returns(
        //uint
    //);
    //function deathBlock(
    //)external view returns(
        //uint
    //);
    //function blockAdjustedTimeOfDeath(
    //)external view returns(
        //uint
    //);
    //get block hash at time of death
    //function deathTimeHash(
    //)external view returns(
        //uint
    //);
    //get block hash at death block
    //function deathBlockHash(
    //)external view returns(
        //uint
    //);
    
    
    //function timeSinceDeath(
    //)external view returns(
        //uint
    //);
    //function blocksSinceDeath(
    //)external view returns(
        //uint
    //);
    
    //function blockAdjustedTimeSinceDeath(
    //)external view returns(
        //uint
    //);
}