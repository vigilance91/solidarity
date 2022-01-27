// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";
import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/eventsEIP801.sol";
///
/// @title Mixin Library for EIP-801 Canary Standard
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev ligi, "EIP-801: ERC-801 Canary Standard [DRAFT]," Ethereum Improvement Proposals, no. 801, December 2017. [Online serial].
/// Available: https://eips.ethereum.org/EIPS/eip-801
/// 
library mixinEIP801
{
    using logicConstraints for bool;
    
    using SafeMath for uint;
    
    //using nowLogic for uint;
    //using nowMath for uint;
    
    using eventsEIP801 for address;
    
    struct EIP801Storage {
        uint createdTimestamp;
        uint createdBlock;
        //bytes32 createdHash;
        
        //alive and initialized cause this struct to be imporperly packed,
        //leading to invalid values for the struct's other variables
        bool alive;
        bool initialized;
        //address self;
        //address owner
    }
    
    bytes32 internal constant STORAGE_SLOT = keccak256("EIP-801.canary.storage");
    
    function canaryStorage(
    )internal pure returns(
        EIP801Storage storage ret
    ){
        bytes32 position = STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
     
    function requireAlive(
    )internal view
    {
        canaryStorage().alive.requireTrue(
            'dead'
        );
    }
    function requireDead(
    )internal view
    {
        canaryStorage().alive.requireFalse(
            'alive'
        );
    }
    //function requireInitialized(
    //)internal view
    //{
        //canaryStorage().initialized.requireTrue(
            //'not initialized'
        //);
    //}
    function age(
    )internal view returns(
        uint
    ){
        //mixinEIP801.Store storage self = _readOnlyCanaryStorage();
        
        //if(!self.alive){
            //return self.deathTimestamp.sub(self.createdTimestamp);
        //}
        
        //return self.createdTimestamp.nowSub();
        return block.timestamp.sub(
            canaryStorage().createdTimestamp
        );
    }
    //function requireAgeGreaterThan(
        //Store storage self
    //)public view returns(
        //uint
    //){
        //age().requireGreaterThan(
            //value
        //);
    //}
    //function requireAgeLessThan(
        //Store storage self
    //)public view returns(
        //uint
    //){
        //age().requireLessThan(
            //value
        //);
    //}
    function blockAge(
    )internal view returns(
        uint
    ){
        //mixinEIP801.Store storage self = _readOnlyCanaryStorage();
        
        //if(!self.alive){
            //return self.deathBlock.sub(self.createdBlock);
        //}
        
        //return self.createdBlock.blockNumberSub();
        return block.number.sub(
            canaryStorage().createdBlock
        );
    }
    //function die(
    //)public
    //{
        //mixinEIP801.Store storage self = _readOnlyCanaryStorage();
        
        //if(self.alive){
            //self.alive = false;
            ////self.deathTimestamp = now;    //block.timestamp;
            ////self.deathBlock = block.number;    //block.timestamp;
        //}
    //}
    function initialize(
    )internal
    {
        EIP801Storage storage cs = canaryStorage();
        //
        //logicConstraints.requireTrue(
            //ls.initialized == false && ls.alive == false
        //);
        
        cs.createdTimestamp = now;
        cs.createdBlock = block.number;
        //cs.createdHash = block.hash(block.number);
        cs.alive = true;
        cs.initialized = true;
    }
}