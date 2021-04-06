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
    string public constant NOT_EQUAL = "0x20";
    string public constant EQUAL = "0x21";
    string public constant AWAITING_MATCH = "0x22";
    string public constant MATCH_REQUEST_SENT = "0x23";
    string public constant UNDERFLOW = "0x24";
    string public constant REQUEST_FOR_MATCH = "0x25";
    string public constant OVERFLOW = "0x26";
    //string public constant Metadata = "0x27";
    string public constant COLLISION = "0x28";
    //string public constant OUT_OF_BOUNDS = "0x29";
    //string public constant IN_RANGE = "0x2A";
    //string public constant reserved = "0x2B";
    //string public constant reserved = "0x2C";
    //string public constant reserved = "0x2D";
    //string public constant reserved = "0x2E";
    string public constant METADATA = "0x2F";
}