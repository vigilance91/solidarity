// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-801 Canary Events Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev ligi, "EIP-801: ERC-801 Canary Standard [DRAFT]," Ethereum Improvement Proposals, no. 801, December 2017. [Online serial].
/// Available: https://eips.ethereum.org/EIPS/eip-801
/// 
library eventsEIP801
{
    event _created(
        address self,
        address owner,
        uint256 balance,    //balance this contract holds upon creation
        uint time,          //timestamp of contract construction
        uint blockNumber
    );
    //event eInitialize(
        //address self,       //contract being initialized
        //address owner,      //owner of contract
        //address sender,     //sender of call to init, should be same as owner
        //uint time           //timestamp of contract construction
        //uint blockNumber
    //);
   
    function emitCreated(
        address self,
        address owner
    )internal
    {
        emit _created(
            self,
            owner,
            self.balance,
            block.timestamp,
            block.number
        );
    }
    //function _emitInitialized(
        //address self,
        //address owner
    //)internal
    //{
        //emit eInitialized(
            //self,
            //owner,
            //msg.sender,
            //block.timestamp,
            //block.number
        //);
    //}
    
    event _apoptosis(
        address self,
        address owner,
        uint256 balance,    //balance transfered to owner upon selfdestruct
        uint time,          //timestamp of apoptosis/selfdestruct call
        uint blockNumber
    );
    
    function emitApoptosis(
        address self,
        address owner
    )internal
    {
        emit _apoptosis(
            self,
            owner,
            self.balance,
            block.timestamp,
            block.number
        );
    }
}