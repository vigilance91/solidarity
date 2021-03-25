// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

/// @title Availability & Time Error Code Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 25/3/2021, All Rights Reserved
library availabilityCodes
{
    string public constant UNAVAILABLE = "0x40";
    string public constant AVAILABLE = "0x41";
    string public constant PAUSED = "0x42";
    string public constant QUEUED = "0x43";
    string public constant NOT_AVAILABLE = "0x44";
    string public constant AWAITING_AVAILABILITY = "0x45";
    string public constant EXPIRED = "0x46";
    //string public constant [reserved] = "0x47";
    string public constant ALREADY_DONE = "0x48";
    //string public constant [reserved] = "0x49";
    //string public constant [reserved] = "0x4A";
    //string public constant [reserved] = "0x4B";
    //string public constant [reserved] = "0x4C";
    //string public constant [reserved] = "0x4D";
    //string public constant [reserved] = "0x4E";
    string public constant INFO = "0x4F";
}