// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/ERC173/frameworkSafeERC173.sol";
///
/// @title ERC173 Receiver Constraints Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
///
abstract contract ERC173ReceiverConstraintsABC //is ContractConstraintsABC
{
    using LogicConstraints for bool;
    //using AddressConstraints for address;
    using frameworkSafeERC173 for address;
    
    string private _NAME = ' ERC173ReceiverConstraintsABC: ';
    string private constant _TRANSFER_FAILED = ' ERC173ReceiverConstraintsABC: address cannot receive ERC173 transfers';
    
    constructor(
    )internal{
    }
    
    function _requireCanReceiveERC173(
        address recipient
    )internal view
    {
        recipient.canReceiveERC173().requireTrue(
            _TRANSFER_FAILED
        );
    }
    function _requireOnERC173Received(
        address recipient,
        address from
    )internal
    {
        recipient.onERC173Received(
            from
        ).requireTrue(
            _TRANSFER_FAILED
        );
    }
}