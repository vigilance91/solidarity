// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/supplyCap/iERC20StaticSupplyCap.sol";
///
/// @title iERC20MutableSupplyCap
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 23/4/2021, All Rights Reserved
///
interface iERC20MutableSupplyCap //is iERC20StaticSupplyCap
{
    /// @dev return the cap on the token's total supply
    //function cap(
    //)external view returns(
        //uint256
    //);
    
    function setCap(
        uint256 newCap
    )external view returns(
        uint256
    );
    
    function increaseCapBy(
        uint256 amountBy
    )external view returns(
        uint256
    );
    function decreaseCapBy(
        uint256 amountBy
    )exteranl view returns(
        uint256
    );
}