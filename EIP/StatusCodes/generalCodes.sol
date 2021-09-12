// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-1066 Status Codes General Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/3/2021, All Rights Reserved
/// @dev based on https://eips.ethereum.org/EIPS/eip-1066 by Brooklyn Zelenka, Tom Carchrae, Gleb Naumenko
/// 0x0* general codes, these double as bare “reasons” for things happening in the systemLanguage
/// 0x1* Permission & Control, used for common state machine actions
/// 0x2* Find, Inequalities & Range, broadly intended for finding and matching
/// 0x3* Negotiation & Governance, very broadly the flow of such transactions
/// 0x4* Availability & Time, service or action availability.
/// 0x5* Tokens, Funds & Finance, special token and financial concepts. Many related concepts are included in other ranges
/// 0x6* TBD - Currently unspecified. (Full range reserved)
/// 0x7* TBD -Currently unspecifie. (Full range reserved)
/// 0x8* TBD - Currently unspecified. (Full range reserved)
/// 0x9* TBD - Currently unspecified. (Full range reserved)
/// 0xA* Application-Specific Codes, contracts may have special states that they need to signal
/// 0xB* TBD - Currently unspecified. (Full range reserved)
/// 0xC* TBD - Currently unspecified. (Full range reserved)
/// 0xD* TBD - Currently unspecified. (Full range reserved)
/// 0xE* Encryption, Identity & Proofs, actions around signatures, cryptography, signing, and application-level authentication
/// 0xF* Off-Chain, for off-chain actions
///
library generalCodes
{
    string internal constant SUCCESS = "0x01";	
    string internal constant AWAITING_OTHERS = "0x02";
    string internal constant ACCEPTED = "0x03";
    string internal constant LOWER_LIMIT = "0x04";
    string internal constant RECEIVER_ACTION_REQUESTED = "0x05";
    string internal constant UPPER_LIMIT = "0x06";
    //string internal constant reserved = "0x07";	[reserved]
    string internal constant INAPPLICABLE = "0x08";
    //string internal constant reserved = "0x09";	[reserved]
    //string internal constant reserved = "0x0A";	[reserved]
    //string internal constant reserved = "0x0B";	[reserved]
    //string internal constant reserved = "0x0C";	[reserved]
    //string internal constant reserved = "0x0D";	[reserved]
    //string internal constant reserved = "0x0E";	[reserved]
    string internal constant METADATA = "0x0F";
}