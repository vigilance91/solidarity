// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//0x6* TBD - Currently unspecified. (Full range reserved)
//0x7* TBD -Currently unspecifie. (Full range reserved)
//0x8* TBD - Currently unspecified. (Full range reserved)
//0x9* TBD - Currently unspecified. (Full range reserved)

/// @title Application Specific Error Code Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 25/3/2021, All Rights Reserved
/// 0xA* Application-Specific Codes, contracts may have special states that they need to signal.
/// This proposal only outlines the broadest meanings, but implementers may have very specific meanings for each,
/// as long as they are coherent with the broader definition.
library applicationCodes
{
    string public constant FAILURE = "0xA0";
    string public constant SUCCESS = "0xA1";
    string public constant AWAITING_OTHERS = "0xA2";
    string public constant ACCEPTANCE = "0xA3";
    string public constant BELOW_CONDITION = "0xA4";
    string public constant RECEIVER_ACTION_REQUIRED = "0xA5";
    string public constant TIMEOUT_REACHED = "0xA6";
    //string public constant [reserved] = "0xA7";
    string public constant INAPPLICABLE = " 0xA8";
    //string public constant [reserved] = "0xA9";
    //string public constant [reserved] = "0xAA";
    //string public constant [reserved] = "0xAB";
    //string public constant [reserved] = "0xAC";
    //string public constant [reserved] = "0xAD";
    //string public constant [reserved] = "0xAE";
    string public constant METADATA = "0xAF";
}