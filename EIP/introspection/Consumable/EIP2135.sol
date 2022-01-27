// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/access/AccessControl.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "./iEIP2135.sol";
import "./eventsEIP2135.sol";
import "./mixinEIP2135.sol";
///
/// @title EIP-2135 Consumable Standard Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
/// @dev Ethereum Improvments Proposal: Consumable Interface: https://eips.ethereum.org/EIPS/eip-2135
///consideration of ERC-721 was given when drafting this EIP and is backwards compatible with ERC-721
///one example would be a ticket which is consumed to gain entry to an event
///another would be a consumable, like a potion being used in a game
///this EIP can also integrate with EIP1753, to create Consumable Licences
///
abstract contract EIP2135 is iEIP2135
{
    using logicConstraints for bool;
    using eventsEIP2135 for uint256;
    
    constructor(
        //mapping(uint256=>bool)
    )internal
    {
        //for(){
            //uint256 assetId = [i];
            //
            //mixinEIP2135.initialize(
                //assetId,
                //consumable
            //);
        //}
        //
    }
    function _mutableConsumableItems(
    )private returns(
        //mixinEIP2135.DataStorage
        mapping(uint256=>bool) storage
    ){
        return mixinEIP2135.dataStore().items;
    }
    function _readOnlyConsumableItems(
    )private view returns(
        //mixinEIP2135.DataStorage
        mapping(uint256=>bool) storage
    ){
        return mixinEIP2135.items();
    }
    function _isConsumable(
        uint256 assetId
    )internal view returns(
        bool
    ){
        return mixinEIP2135.isConsumable(assetId);
    }
    function _requireIsConsumable(
        uint256 assetId
    )internal view
    {
        //mixinEIP2135.requireIsConsumable(assetId);
        
        _readOnlyConsumableItems()[assetId].requireTrue(
            "item not consumable"
        );
    }
    //modifier consumable(
        //uint256 asset
    //){
        //_requireIsConsumable(assetId);
        //_;
    //}
    ///
    ///public Interface
    ///
    function isConsumable(
        uint256 assetId
    )public view override returns(
        bool
    ){
        return _isConsumable(assetId);
    }
    ///override this function in deriving classes
    function consume(
        uint256 assetId
    )public virtual override returns(
        bool
    ){
        assetId.emitOnConsumption();
        return true;
    }
}