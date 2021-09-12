// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-1066 Status Codes Governance Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/3/2021, All Rights Reserved
/// 0x3* Negotiation & Governance, very broadly the flow of such transactions
/// Note that “other party” may be more than one actor (not necessarily the sender)
library governanceCodes
{
    string internal constant VOTES_NAY = "0x30";
    string internal constant VOTES_Yea = "0x31";
    string internal constant AWAITING_RATIFICATION = "0x32";
    string internal constant OFFER_SENT_OR_VOTED = "0x33";
    string internal constant QUORUM_NOT_REACHED = "0x34";
    string internal constant RATIFICATION_REQUESTED = "0x35";
    string internal constant LIMIT_REACHED = "0x36";
    //string internal constant [reserved] = "0x37";
    string internal constant ALREADY_VOTED = "0x38";
    //string internal constant [reserved] = "0x39";
    //string internal constant [reserved]= "0x3A";
    //string internal constant [reserved] = "0x3B";
    //string internal constant [reserved] = "0x3C";
    //string internal constant [reserved] = "0x3D";
    //string internal constant [reserved] = "0x3E";
    string internal constant METADATA = "0x3F";
}