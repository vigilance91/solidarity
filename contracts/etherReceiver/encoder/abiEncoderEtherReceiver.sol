// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Ether Receiver Transaction Encoder Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
/// @dev Any contract capable of receiving Ether transfers should inherit and implement this interface
///
library abiEncoderEtherReceiver
{
    string private constant STUB_ON_ETHER_RECEIVED = 'onEtherReceived(address,uint256)';
    
    bytes internal constant SIG_CAN_RECEIVE_ETHER = abi.encodeWithSignature('canReceiveEther()');
    ///
    /// @return {bytes}
    ///
    function onEtherReceived(
        address from,
        uint256 amount
    )external pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_ON_ETHER_RECEIVED,
            from,
            amount
        );
    }
}