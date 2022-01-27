// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-1066 Status Codes Governance Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/3/2021, All Rights Reserved
/// 0x1* Permission & Control, used for common state machine/access control actions
library permissionCodes
{
    string internal constant DISALLOWED = "0x10";
    string internal constant ALLOWED = "0x11";
    string internal constant AWAITING_OTHERS_PERMISSION = "0x12";
    string internal constant PERMISSION_REQUESTED = "0x13";
    string internal constant INSECURE = "0x14";
    string internal constant REQUIRES_PERMISSION_FOR_CONTINUATION = "0x15";
    string internal constant REVOKED = "0x16";
    //string internal constant reserved = "0x17	[reserved]
    string internal constant NOT_APPLICABLE = "0x18";
    //string internal constant reserved = "0x19	[reserved]
    //string internal constant reserved = "0x1A	[reserved]
    //string internal constant reserved = "0x1B	[reserved]
    //string internal constant reserved = "0x1C	[reserved]
    //string internal constant reserved = "0x1D	[reserved]
    //string internal constant reserved = "0x1E	[reserved]
    string internal constant METADATA = "0x1F";
}