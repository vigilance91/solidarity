// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Static Token Supply Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev immutable (view/read-only) token supply interface
///
interface iStaticTokenSupply
{
    /// @return {uint256} amount of tokens in existence
    function totalSupply(
    )external view returns(
        uint256
    );
}

//interface iInitializableStaticTokenSupply
//{
    //function initilaize(bytes calldata data) external;
//}