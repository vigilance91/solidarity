// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/frameworkSafeERC20.sol";
///
/// @title ERC20 Receiver Constraints Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
///
abstract contract ERC20ReceiverConstraintsABC //is ContractConstraintsABC
{
    //using externalConstraints for bool;
    using logicConstraints for bool;
    //using addressConstraints for address;
    using frameworkSafeERC20 for address;
    
    string private constant _TRANSFER_FAILED = " ERC20ReceiverConstraintsABC: contract can not receive ERC20 transfers";
    
    constructor(
    )internal{
    }
    
    function _requireCanReceiveERC20(
        address recipient
    )internal view
    {
        recipient.canReceiveERC20().requireTrue(
            _TRANSFER_FAILED
        );
    }
    function _requireOnERC20Received(
        address recipient,
        address from,
        uint256 amount
    )internal
    {
        recipient.onERC20Received(
            from,
            amount
        ).requireTrue(
            _TRANSFER_FAILED
        );
    }
}