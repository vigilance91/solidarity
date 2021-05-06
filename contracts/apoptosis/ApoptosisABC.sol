// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/etherReceiver/EtherReceiverConstraintsABC.sol";

//library mixinApoptosis
//{
    //struct Apoptosis
        //uint tsTermination;
        //uint deathBlock;
    //}
//}

///
/// @title Apoptosis Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 6/5/2021, All Rights Reserved
/// @dev abstract base contract capable of selfdestruct'ing, otherwise known as apoptosis in biology, or programmed cell death,
/// in this context, apoptosis refers to a contract capable of programmed contract death, either killing itself baed on some internal logic,
/// or by being executed externally, typically by being called by the derived contract's owner,
/// such applications include upgrading a contract, where the previous version is no longer needed or contains known bugs and should no longer operate/exist
/// another use is in trustless payment contracts, where the recipient of a transfer can receiver their payout after the contract has closed/no longer needed
/// and is then killed to signal the finality of the transaction, resulting in the recipeint being paid and the contract self-destructing

abstract contract ApoptosisABC is EtherReceiverConstraintsABC
{
    using AddressLogic for address;
    using AddressConstraints for address;
    
    using eventsApoptosis for address;
    
    using SafeMath for uint256;
    
    constructor(
        //address _payableFallback
    )internal
    {
    }
    /// @dev derived contracts add sqecific code here to be executed upon call to apoptosis
    //function _die(
    //)internal virtual
    //{
        //_tsTermination = block.timestamp;
        //_deathBlock = block.number;
    //}
    /// @dev programmed contract death!
    function _apoptosis(
        address receiver
    )internal virtual
    {
        //ETH receiver can not be null
        receiver.requireNotNull();
        //can not send ETH to itself, this would otherwise cause the contract to break
        address(this).requireNotEqual(receiver);
        
        _requireCanReceiverETH(receiver);
        
        //_die();
        _this.emitApoptosis(
            receiver
        );

        //if owner is not null, pay this contract's balance to owner
        selfdestruct(
            payable(receiver)
        );
    }
}