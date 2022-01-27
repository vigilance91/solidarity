// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

///
/// @dev Allowance Transaction Encoder Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
///
interface iEncoderAllowance
{
    ///
    /// @dev return {uint256} remaining number of tokens `spender` will be
    /// allowed to spend on behalf of `owner` through {transferFrom}
    ///
    /// @notice this value is zero by default,
    /// and changes when {approve} or {transferFrom} are called
    ///
    function allowance(
        address owner,
        address spender
    )external pure returns(
        bytes memory
    );
    ///
    /// @dev Sets `amount` as the allowance of `spender` over the caller's tokens
    /// @return {bool} true if the operation succeeded, otherwise false
    /// 
    function approve(
        address spender
    )external pure returns(
        bytes memory
    );
    function revokeAllowance(
        address spender
    )external pure returns(
        bytes memory
    );
}