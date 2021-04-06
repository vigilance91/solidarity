// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-1066 Status Codes Governance Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/3/2021, All Rights Reserved
/// 0x1* Permission & Control, used for common state machine/access control actions
library permissionCodes
{
    string public constant DISALLOWED = "0x10";
    string public constant ALLOWED = "0x11";
    string public constant AWAITING_OTHERS_PERMISSION = "0x12";
    string public constant PERMISSION_REQUESTED = "0x13";
    string public constant INSECURE = "0x14";
    string public constant REQUIRES_PERMISSION_FOR_CONTINUATION = "0x15";
    string public constant REVOKED = "0x16";
    //string public constant reserved = "0x17	[reserved]
    string public constant NOT_APPLICABLE = "0x18";
    //string public constant reserved = "0x19	[reserved]
    //string public constant reserved = "0x1A	[reserved]
    //string public constant reserved = "0x1B	[reserved]
    //string public constant reserved = "0x1C	[reserved]
    //string public constant reserved = "0x1D	[reserved]
    //string public constant reserved = "0x1E	[reserved]
    string public constant METADATA = "0x1F";
}