// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/supplyCap/iStaticSupplyCap.sol";
///
/// @title iERC20MutableSupplyCap
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 23/4/2021, All Rights Reserved
///
interface iMutableSupplyCap is iStaticSupplyCap
{
    /// @dev decrease cap by `amountBy`
    function setCap(
        uint256 newCap
    )external returns(
        uint256
    );
    /// @dev increase supply cap by `amountBy`
    function increaseCapBy(
        uint256 amountBy
    )external returns(
        uint256
    );
    /// @dev decrease supply cap by `amountBy`
    function decreaseCapBy(
        uint256 amountBy
    )external returns(
        uint256
    );
}