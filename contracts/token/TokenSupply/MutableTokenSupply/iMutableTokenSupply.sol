// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/iStaticTokenSupply.sol";
///
/// @title Mutable Token Supply Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev interface for a mutable token supply, providing external increase and decrease methods
///
interface iMutableTokenSupply is iStaticTokenSupply
{
    function increaseTotalSupply(
        uint256 amountBy
    )external;
    
    function decreaseTotalSupply(
        uint256 amountBy
    )external;
}