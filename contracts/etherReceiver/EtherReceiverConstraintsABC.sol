// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/frameworkEtherReceiver.sol";
//import "./frameworkEtherReceiver.sol";

//import "https://github.com/vigilance91/solidarity/contracts/msg/value/MsgValueConstraints.sol";
///
/// @title Ether Receiver Constraints Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
///
abstract contract EtherReceiverConstraintsABC
{
    using logicConstraints for bool;
    //using addressConstraints for address;
    using frameworkEtherReceiver for address;
    
    string private constant _NAME = ' EtherReceiverConstraintsABC: ';
    
    string private constant _TRANSFER_FAILED = string(
        abi.encodePacked(
            _NAME,
            "can not receive Ether transfers"
        )
    );
    
    constructor(
    )internal
    {
    }
    
    function _requireBalanceGreaterThanOrEqual(
        uint256 amount
    )internal view
    {
        require(
            address(this).balance >= amount,
            'insufficient contract balance'
        );
    }
    
    function _requireCanReceiveEther(
        address recipient
    )internal view
    {
        recipient.canReceiveEther().requireTrue(
            _TRANSFER_FAILED
        );
    }
    function _requireOnEtherReceived(
        address recipient,
        address from,
        uint256 amount
    )internal
    {
        recipient.onEtherReceived(
            from,
            amount
        ).requireTrue(
            _TRANSFER_FAILED
        );
    }
}