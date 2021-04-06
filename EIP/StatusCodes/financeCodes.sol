// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title uint256 Logic Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/3/2021, All Rights Reserved
/// @dev EIP-1066: Status Codes (Draft)
/// 0x5* Tokens, Funds & Finance, special token and financial concepts. Many related concepts are included in other ranges
library financeCodes
{
    string public constant TRANSFER_FAILED = "0x50";
    string public constant TRANSFER_SUCCESSFUL = "0x51";
    string public constant AWAITING_PAYMENT_FROM_OTHERS = "0x52";
    string public constant ESCROWED_FUNDS = "0x53";
    string public constant INSUFFICIENT_FUNDS = "0x54";
    string public constant FUNDS_REQUESTED = "0x55";
    string public constant TRANSFER_VOLUME_eXCEEDED = "0x56";
    //string public constant [reserved] = "0x57";
    string public constant FUNDS_NOT_REQUIRED = "0x58";
    //string public constant [reserved] = "0x59";
    //string public constant [reserved] = "0x5A";
    //string public constant [reserved] = "0x5B";
    //string public constant [reserved] = "0x5C";
    //string public constant [reserved] = "0x5D";
    //string public constant [reserved] = "0x5E";
    string public constant TOKEN_INFORMATION = "0x5F";
}

/// 0x6* TBD - Currently unspecified. (Full range reserved)
/// 0x7* TBD -Currently unspecifie. (Full range reserved)
/// 0x8* TBD - Currently unspecified. (Full range reserved)
/// 0x9* TBD - Currently unspecified. (Full range reserved)