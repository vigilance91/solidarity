// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

/// @title Governances Status Code Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 25/3/2021, All Rights Reserved
/// 0x3* Negotiation & Governance, very broadly the flow of such transactions.
/// Note that “other party” may be more than one actor (not necessarily the sender).
library governanceCodes
{
    string public constant VOTES_NAY = "0x30";
    string public constant VOTES_Yea = "0x31";
    string public constant AWAITING_RATIFICATION = "0x32";
    string public constant OFFER_SENT_OR_VOTED = "0x33";
    string public constant QUORUM_NOT_REACHED = "0x34";
    string public constant RATIFICATION_REQUESTED = "0x35";
    string public constant LIMIT_REACHED = "0x36";
    //string public constant [reserved] = "0x37";
    string public constant ALREADY_VOTED = "0x38";
    //string public constant [reserved] = "0x39";
    //string public constant [reserved]= "0x3A";
    //string public constant [reserved] = "0x3B";
    //string public constant [reserved] = "0x3C";
    //string public constant [reserved] = "0x3D";
    //string public constant [reserved] = "0x3E";
    string public constant METADATA = "0x3F";
}