// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/ownership/ERC173/iERC173Receiver.sol";

//import "https://github.com/vigilance91/solidarity/contracts/ownership/ERC173/ERC173ReceiverConstraintsABC.sol";
///
/// @title ERC173 Non-Receivable Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
/// @dev inherit from this contract is the derived contract explicitly cannot receive ERC-173 Ownership of another contract
///
abstract contract ERC173NonReceivableABC is //ERC173ReceiverConstraintsABC,
    iERC173Receiver
{
    bytes4 internal constant _ERC173_DENIED = bytes4(0);    //bytesLogic.bytes4Zero;
    
    constructor(
    )internal
        //ERC173ReceiverConstraintsABC()
    {
    }
    /// called on a transfer of ownership to an implementing contract
    function onERC173Received(
        address from
    )public override returns(
        bytes4
    ){
        return _ERC173_DENIED;
    }
    function canReceiveERC173(
    )external view override returns(
        bool
    ){
        return false;
    }
}