// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-1066 Status Codes Governance Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/3/2021, All Rights Reserved
/// 0x4* Availability & Time, service or action availability.
library availabilityCodes
{
    string internal constant UNAVAILABLE = "0x40";
    string internal constant AVAILABLE = "0x41";
    string internal constant PAUSED = "0x42";
    string internal constant QUEUED = "0x43";
    string internal constant NOT_AVAILABLE = "0x44";
    string internal constant AWAITING_AVAILABILITY = "0x45";
    string internal constant EXPIRED = "0x46";
    //string internal constant [reserved] = "0x47";
    string internal constant ALREADY_DONE = "0x48";
    //string internal constant [reserved] = "0x49";
    //string internal constant [reserved] = "0x4A";
    //string internal constant [reserved] = "0x4B";
    //string internal constant [reserved] = "0x4C";
    //string internal constant [reserved] = "0x4D";
    //string internal constant [reserved] = "0x4E";
    string internal constant INFO = "0x4F";
}