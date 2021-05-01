// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "../TokenIdentifier/iTokenIdentifier.sol";
///
/// @dev Allowance Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
///
interface iAllowance
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
    )external view returns(
        uint256
    );
    ///
    /// @dev Sets `amount` as the allowance of `spender` over the caller's tokens
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    /// IMPORTANT:
    ///     Beware that there is a well known exploit with ERC20 style allowances, known as a double spend attack,
    ///     by changing an allowance with approve, there is a risk
    ///     that someone may use both the old and the new allowance by unfortunate transaction ordering,
    ///     by the attacker supplying more gas and having their spend mined before the approve change,
    ///     or by intentionally front-running.
    ///
    ///     One possible solution to mitigate this race condition is to first revoke the spender's allowance (setting it to 0),
    ///     then, in a subsequent transaction, set the desired value:
    ///         https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
    ///
    ///     This implementation, however, minimizes such a risk to some extent,
    ///     due to the fact that the implementation checks to see if
    ///     an allowance is already zero before calling approve,
    ///     so if the attacker spends their allowance before the approve is mined,
    ///     the approval with fail and revert, keeping the allowance at 0
    ///
    function approve(
        address spender,
        uint256 amount
    )external returns(
        bool
    );
    function revokeAllowance(
        address spender
    )external;
}