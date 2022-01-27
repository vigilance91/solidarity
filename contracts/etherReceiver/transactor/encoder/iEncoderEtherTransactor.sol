// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/encoder/iEncoderEtherReceiver.sol";
///
/// @title Ether Transactor Encoder Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
/// @dev Any contract capable of receiving Ether transfers should inherit and implement this interface
///
interface iEncoderEtherTransactor is iEncoderEtherReceiver
{
    /// @dev transfer ETH from this contract to recipient
    function ethThisTransferTo(
        address recipient,
        uint256 amount
    )external pure returns(
        bytes memory
    );
    /// @dev convenience wrapper to transfer ETH from this contract's balance to owner
    function ethThisTransferToOwner(
        uint256 amount
    )external pure returns(
        bytes memory
    );
    
    function ethTransferToThis(
    )external pure returns(
        bytes memory
    );
}