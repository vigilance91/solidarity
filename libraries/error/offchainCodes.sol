// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

/// @title 
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 25/3/2021, All Rights Reserved
//0xF* Off-Chain, for off-chain actions. Much like th 0x0*: Generic range, 0xF* is very general, and does little to modify the reason.
//Among other things, the meta code 0xFF may be used to describe what the off-chain process is.
library offchainCodes
{
    string public constant OFF_CHAIN_FAILURE = "0xF0";
    string public constant OFF_CHAIN_SUCCESS = "0xF1";
    string public constant AWAITING_OFF_CHAIN_PROCESS = "0xF2";
    string public constant OFF_CHAIN_PROCESS_STRATED = "0xF3";
    string public constant OFF_CHAIN_SERVICE_UNREACHABLE = "0xF4";
    string public constant OFF_CHAIN_ACTION_REQUIRED = "0xF5";
    string public constant OFF_CHAIN_TIMEOUT_REACHED = "0xF6";
    //string public constant [reserved] = "0xF7";
    string public constant DUPLICATE_OFF_CHAIN_REQUEST = "0xF8";
    //string public constant [reserved] = "0xF9";
    //string public constant [reserved] = "0xFA";
    //string public constant [reserved] = "0xFB";
    //string public constant [reserved] = "0xFC";
    //string public constant [reserved] = "0xFD";
    //string public constant [reserved] = "0xFE";
    string public constant METADATA = "0xFF";
}