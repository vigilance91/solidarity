// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/encoder/iEncoderEtherTransactor.sol";
///
/// @title Ether Allowance Transactor Transaction Encoder Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
///
interface iEncoderEtherAllowanceTransactor is iEncoderEtherTransactor
{
    ///
    /// @return {bytes}
    ///
    function ethTransferFrom(
        address from,
        address recipient,
        uint256 amount
    )external pure returns(
        bytes memory
    );
    ///
    /// @return {bytes}
    ///
    function ethTransferFromToCaller(
        address from,
        uint256 amount
    )external pure returns(
        bytes memory
    );
    ///
    /// @return {bytes}
    ///
    function ethTransferFromThis(
        address recipient,
        uint256 amount
    )external pure returns(
        bytes memory
    );
    ///
    /// @return {bytes}
    ///
    function ethTransferFromThisToOwner(
        uint256 amount
    )external pure returns(
        bytes memory
    );
    ///
    /// @return {bytes}
    ///
    function ethTransferFromToThis(
        address owner,
        uint256 amount
    )external pure returns(
        bytes memory
    );
    //
    // approve/revoke allowance functions
    //
    ///
    /// @return {bytes}
    ///
    function approve(
        address spender
    )external pure returns(
        bytes memory
    );
    ///
    /// @return {bytes}
    ///
    function ethThisApproveAllowanceFor(
        address spender,
        uint256 amount
    )external pure returns(
        bytes memory
    );
    ///
    /// @return {bytes}
    ///
    function ethThisRevokeAllowance(
        address spender
    )external pure returns(
        bytes memory
    );
    ///
    /// @return {bytes}
    ///
    function ethRevokeAllowanceForThis(
    )external pure returns(
        bytes memory
    );
}