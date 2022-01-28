// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Token Balance Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
///
interface iTokenBalance
{
    /// @return {uint256} amount of `owner`'s tokens
    function balanceOf(
        address account
    )external view returns(
        uint256
    );
}