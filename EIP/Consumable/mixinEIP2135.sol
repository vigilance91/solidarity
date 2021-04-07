// SPDX-License-Identifier: Apache 2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Mixin Library for EIP-2135 Consumable Standard
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
///
library mixinEIP2135
{
    bytes32 internal constant STORAGE_SLOT = keccak256("EIP-2135.mixin.consumable.storage.slot");
    
    struct DataStorage{
        mapping(uint256=>bool) items;
    }
    
    function dataStore(
    )internal pure returns(
        DataStorage storage ret
    ){
        bytes32 position = STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
    function initialize(
        uint256 assetId,
        bool consumable
    )internal
    {
        dataStore().items[assetId] = consumable;
    }
    function isConsumable(
        uint256 assetId
    )internal view returns(
        bool
    ){
        return dataStore().items[assetId];
    }
}