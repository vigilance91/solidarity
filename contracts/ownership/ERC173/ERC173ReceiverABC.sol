// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/ERC173/iERC173Receiver.sol";
import "https://github.com/vigilance91/solidarity/contracts/ownership/ERC173/eventsERC173Receiver.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/ERC173/ERC173ReceiverConstraintsABC.sol";
///
/// @title ERC173 Receiver Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
///
abstract contract ERC173ReceiverABC is ERC173ReceiverConstraintsABC,
    iERC173Receiver
{
    using eventsERC173Receiver for address;
    
    bytes4 internal constant _ERC173_RECEIVED = iERC173Receiver.onERC173Received.selector;
    
    constructor(
    )internal
        ERC173ReceiverConstraintsABC()
    {
    }
    /// called on a transfer of ownership to an implementing contract
    function onERC173Received(
        address from
    )public virtual override returns(
        bytes4
    ){
        address(this).emitReceivedERC173(from);
        
        return _ERC173_RECEIVED;
    }
    function canReceiveERC173(
    )external view virtual override returns(
        bool
    ){
        return true;
    }
}