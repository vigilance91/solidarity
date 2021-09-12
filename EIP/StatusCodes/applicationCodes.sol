// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-1066: Status Codes Application Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/3/2021, All Rights Reserved
/// 0x6* TBD - Currently unspecified. (Full range reserved)
/// 0x7* TBD -Currently unspecifie. (Full range reserved)
/// 0x8* TBD - Currently unspecified. (Full range reserved)
/// 0x9* TBD - Currently unspecified. (Full range reserved)

/// 0xA* Application-Specific Codes, contracts may have special states that they need to signal
/// This proposal only outlines the broadest meanings, but implementers may have very specific meanings for each,
/// as long as they are coherent with the broader definition.
library applicationCodes
{
    string internal constant FAILURE = "0xA0";
    string internal constant SUCCESS = "0xA1";
    string internal constant AWAITING_OTHERS = "0xA2";
    string internal constant ACCEPTANCE = "0xA3";
    string internal constant BELOW_CONDITION = "0xA4";
    string internal constant RECEIVER_ACTION_REQUIRED = "0xA5";
    string internal constant TIMEOUT_REACHED = "0xA6";
    //string internal constant [reserved] = "0xA7";
    string internal constant INAPPLICABLE = " 0xA8";
    //string internal constant [reserved] = "0xA9";
    //string internal constant [reserved] = "0xAA";
    //string internal constant [reserved] = "0xAB";
    //string internal constant [reserved] = "0xAC";
    //string internal constant [reserved] = "0xAD";
    //string internal constant [reserved] = "0xAE";
    string internal constant METADATA = "0xAF";
}
/// 0xB* TBD - Currently unspecified. (Full range reserved)
/// 0xC* TBD - Currently unspecified. (Full range reserved)
/// 0xD* TBD - Currently unspecified. (Full range reserved)