// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/safeERC173/frameworkSafeERC173.sol";
///
/// @title ERC173 Receiver Constraints Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
/// @dev contrain the state of the EVM based on compliance with a contract receiving ERC-173 ownership transfers,
/// reverting if a contract does not support receiving ERC173 ownership or the contract explicitly returns false from `onERC173Received`
///
abstract contract ERC173ReceiverConstraintsABC
{
    using logicConstraints for bool;
    //using addressConstraints for address;
    using frameworkSafeERC173 for address;
    
    string private _NAME = ' ERC173ReceiverConstraintsABC: ';
    
    string private constant _TRANSFER_FAILED = string(
        abi.encodePacked(
            _NAME,
            'address cannot receive ERC173 transfers'
        )
    );
    
    constructor(
    )internal
    {
    }
    /// @dev require `recipient` to implement ERC-173 ownership or be an EOA
    function _requireCanReceiveERC173(
        address recipient
    )internal view
    {
        recipient.canReceiveERC173().requireTrue(
            _TRANSFER_FAILED
        );
    }
    /// @dev require `recipient` to have received ownership from `from`
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