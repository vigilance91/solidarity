// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/iERC20Receiver.sol";
///
/// @title ERC20 Transactor Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev Any contract capable of receiving ERC20 transfers should inherit and implement this interface
///
interface iERC20Transactor is iERC20Receiver
{
    /// @dev transfer ETH from this contract to recipient
    function erc20ThisTransferTo(
        address recipient,
        uint256 amount
    )external;
    
    /// @dev convenience wrapper to transfer ETH from this contract's balance to owner
    function erc20ThisTransferToOwner(
        uint256 amount
    )external;
    
    function erc20TransferToThis(
    )external;
}