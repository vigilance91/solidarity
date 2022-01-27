// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/encoder/abiEncoderEtherTransactor.sol";
import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/encoder/iEncoderEtherTransactor.sol";
///
/// @title Ether Transactor Transaction Encoder Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
///
abstract contract EncoderEtherTransactorABC
{
    constructor(
    )internal
    {
    }
    
    function ethTransferToThis(
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEtherTransactor.SIG_ETH_TRANSFER_TO_THIS;
    }
    
    function ethThisTransferTo(
        address recipient,
        uint256 amount
    ))public pure override returns(
        bytes memory
    ){
        return abiEncoderEtherTransactor.ethThisTransferTo(
            recipient,
            amount
        );
    }
    /// @dev convenience wrapper to transfer ETH from this contract's balance to owner
    function ethThisTransferToOwner(
        uint256 amount
    ))public pure override returns(
        bytes memory
    ){
        return abiEncoderEtherTransactor.ethThisTransferToOwner(
            amount
        );
    }
}