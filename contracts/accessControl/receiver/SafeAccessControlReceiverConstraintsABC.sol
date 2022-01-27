// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/frameworkSafeAccessControl.sol";
///
/// @title Safe Access Control Receiver Constraints Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 9/12/2021, All Rights Reserved
///
abstract contract SafeAccessControlReceiverConstraintsABC //is ContractConstraintsABC
{
    using logicConstraints for bool;
    //using addressConstraints for address;
    using frameworkSafeAccessControl for address;
    
    string private constant _TRANSFER_FAILED = " SafeAccessControlReceiverConstraintsABC: contract can not receive Access Control transfers";
    
    constructor(
    )internal{
    }
    
    function _requireCanReceiveAccessControl(
        address recipient
    )internal view
    {
        recipient.canReceiveAccessControl().requireTrue(
            _TRANSFER_FAILED
        );
    }
    function _requireOnAccessControlReceived(
        address recipient,
        address assigner,
        bytes32 role
    )internal
    {
        recipient.onAccessControlReceived(
            assigner,
            role
        ).requireTrue(
            _TRANSFER_FAILED
        );
    }
}