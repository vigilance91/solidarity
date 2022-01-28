// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "./iEncoderTokenIdentifier.sol";
///
/// @dev Interface for encoding ERC20 payloads
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/4/2021, All Rights Reserved
///
interface iEncoderERC20 is iEncoderTokenIdentifier
    ////iTokenIdentifier
{
    /// @return {uint256} amount of tokens in existence
    //function totalSupply(
    //)external pure returns(
        //bytes memory
    //);
    /// @return {uint256} amount of tokens owned by `account`
    function balanceOf(
        address account
    )external pure returns(
        bytes memory
    );
    ///
    /// @dev Moves `amount` tokens from the caller's account to `recipient`
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    /// Emits a {Transfer} event
    ///
    function transfer(
        address recipient,
        uint256 amount
    )external pure returns(
        bytes memory
    );
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
    /// IMPORTANT: Beware that changing an allowance with this method brings the risk
    /// that someone may use both the old and the new allowance by unfortunate transaction ordering.
    /// One possible solution to mitigate this race condition is to first reduce the spender's allowance to 0 and set the
    /// desired value afterwards:
    ///     https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
    ///
    /// Emits an {Approval} event
    ///
    function approve(
        address spender,
        uint256 amount
    )external pure returns(
        bytes memory
    );
    ///
    /// @dev Moves `amount` tokens from `sender` to `recipient` using the allowance mechanism.
    /// `amount` is then deducted from the caller's allowance.
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    /// Emits a {Transfer} event
    ///
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    )external pure returns(
        bytes memory
    );
}