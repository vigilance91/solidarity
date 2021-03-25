// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

/// @title General Status Code Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/3/2021, All Rights Reserved
///@notice based on EIP-1066: Status Codes (Draft)
///0x0* general codes, these double as bare “reasons” for things happening in the systemLanguage
library generalCodes
{
    string public constant SUCCESS = "0x01";	
    string public constant AWAITING_OTHERS = "0x02";
    string public constant ACCEPTED = "0x03";
    string public constant LOWER_LIMIT = "0x04";
    string public constant RECEIVER_ACTION_REQUESTED = "0x05";
    string public constant UPPER_LIMIT = "0x06";
    //string public constant [reserved] = "0x07";
    string public constant NOT_APPLICABLE = "0x08";
    //string public constant [reserved] = "0x09";
    //string public constant [reserved] = "0x0A";
    //string public constant [reserved] = "0x0B";
    //string public constant [reserved] = "0x0C";
    //string public constant [reserved] = "0x0D";
    //string public constant [reserved] = "0x0E";
    string public constant METADATA = "0x0F";
}