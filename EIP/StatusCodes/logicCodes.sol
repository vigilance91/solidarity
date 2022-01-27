// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-1066 Status Codes Logic Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/3/2021, All Rights Reserved
/// 0x2* Find, Inequalities & Range, broadly intended for finding and matching
/// Data lookups and order matching are two common use cases
library logicCodes
{
    string internal constant NOT_EQUAL = "0x20";
    string internal constant EQUAL = "0x21";
    string internal constant AWAITING_MATCH = "0x22";
    string internal constant MATCH_REQUEST_SENT = "0x23";
    string internal constant UNDERFLOW = "0x24";
    string internal constant REQUEST_FOR_MATCH = "0x25";
    string internal constant OVERFLOW = "0x26";
    //string internal constant Metadata = "0x27";
    string internal constant COLLISION = "0x28";
    //string internal constant OUT_OF_BOUNDS = "0x29";
    //string internal constant IN_RANGE = "0x2A";
    //string internal constant reserved = "0x2B";
    //string internal constant reserved = "0x2C";
    //string internal constant reserved = "0x2D";
    //string internal constant reserved = "0x2E";
    string internal constant METADATA = "0x2F";
}