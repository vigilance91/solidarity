// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Access Control receiver interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 9/12/2021, All Rights Reserved
/// @dev Any contract capable of receiving Access Control transfers should inherit from and implement this interface
///
interface iAccessControlReceiver
{
    ///
    /// @return {bytes4} function selector of `iAccessControl.onAccessControlReceived`, used to confirm token transfer
    /// @dev used as a callback and post-check, if any value other than the function selector is returned or the interface is not implemented by the recipient,
    /// revert the transfer
    ///
    function onAccessControlReceived(
        address assigner,
        bytes32 role
    )external returns(
        bytes4
    );
    ///@return {bool} true if the implementing contract accepts Access Control transfers, used as a pre-check
    function canReceiveAccessControl(
    )external view returns(
        bool
    );
}