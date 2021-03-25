// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

/// @title uint256 Logic Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/3/2021, All Rights Reserved
///@notice based on EIP-1066: Status Codes (Draft)
///0x0* general codes, these double as bare “reasons” for things happening in the systemLanguage
library generalCodes
{
    string public constant SUCCESS = "0x01";	
    string public constant AWAITING_OTHERS = "0x02";
    string public constant ACCEPTED = "0x03";
    string public constant LOWER_LIMIT = "0x04";
    string public constant RECEIVER_ACTION_REQUESTED = "0x05";
    string public constant UPPER_LIMIT = "0x06";
    //string public constant INSUFFICIENT_FUNDS = "0x07";	[reserved]
    string public constant INAPPLICABLE = "0x08";
    //string public constant INSUFFICIENT_FUNDS = "0x09";	[reserved]
    //string public constant INSUFFICIENT_FUNDS = "0x0A";	[reserved]
    //string public constant INSUFFICIENT_FUNDS = "0x0B";	[reserved]
    //string public constant INSUFFICIENT_FUNDS = "0x0C";	[reserved]
    //string public constant INSUFFICIENT_FUNDS = "0x0D";	[reserved]
    //string public constant INSUFFICIENT_FUNDS = "0x0E";	[reserved]
    string public constant METADATA = "0x0F";
}

/// 0x1* Permission & Control, used for common state machine actions
library permissionControlCodes
{
    string public constant DISALLOWED = "0x10";
    string public constant ALLOWED = "0x11";
    string public constant AWAITING_OTHERS_PERMISSION = "0x12";
    string public constant PERMISSION_REQUESTED = "0x13";
    string public constant INSECURE = "0x14";
    string public constant REQUIRES_PERMISSION_FOR_CONTINUATION = "0x15";
    string public constant REVOKED = "0x16";
    //string public constant Metadata = "0x17	[reserved]
    string public constant NOT_APPLICABLE = "0x18";
    //string public constant Metadata = "0x19	[reserved]
    //string public constant Metadata = "0x1A	[reserved]
    //string public constant Metadata = "0x1B	[reserved]
    //string public constant Metadata = "0x1C	[reserved]
    //string public constant Metadata = "0x1D	[reserved]
    //string public constant Metadata = "0x1E	[reserved]
    string public constant METADATA = "0x1F";
}

///0x2* Find, Inequalities & Range, broadly intended for finding and matching. Data lookups and order matching are two common use cases
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
    //string public constant Metadata = "0x2B";
    //string public constant Metadata = "0x2C";
    //string public constant Metadata = "0x2D";
    //string public constant Metadata = "0x2E";
    string public constant METADATA = "0x2F";
}
///0x3* Negotiation & Governance, very broadly the flow of such transactions. Note that “other party” may be more than one actor (not necessarily the sender).
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

//0x4* Availability & Time, service or action availability.
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

//0x5* Tokens, Funds & Finance, special token and financial concepts. Many related concepts are included in other ranges
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

//0x6* TBD - Currently unspecified. (Full range reserved)
//0x7* TBD -Currently unspecifie. (Full range reserved)
//0x8* TBD - Currently unspecified. (Full range reserved)
//0x9* TBD - Currently unspecified. (Full range reserved)

//0xA* Application-Specific Codes, contracts may have special states that they need to signal.
//This proposal only outlines the broadest meanings, but implementers may have very specific meanings for each,
// as long as they are coherent with the broader definition.
library ApplicationCodes
{
    string public constant FAILURE = "0xA0";
    string public constant SUCCESS = "0xA1";
    string public constant AWAITING_OTHERS = "0xA2";
    string public constant ACCEPTANCE = "0xA3";
    string public constant BELOW_CONDITION = "0xA4";
    string public constant RECEIVER_ACTION_REQUIRED = "0xA5";
    string public constant TIMEOUT_REACHED = "0xA6";
    //string public constant [reserved] = "0xA7";
    string public constant INAPPLICABLE = " 0xA8";
    //string public constant [reserved] = "0xA9";
    //string public constant [reserved] = "0xAA";
    //string public constant [reserved] = "0xAB";
    //string public constant [reserved] = "0xAC";
    //string public constant [reserved] = "0xAD";
    //string public constant [reserved] = "0xAE";
    string public constant METADATA = "0xAF";
}
//0xB* TBD - Currently unspecified. (Full range reserved)
//0xC* TBD - Currently unspecified. (Full range reserved)
//0xD* TBD - Currently unspecified. (Full range reserved)

//0xE* Encryption, Identity & Proofs, actions around signatures, cryptography, signing, and application-level authentication.
//The meta code 0xEF is often used to signal a payload describing the algorithm or process used.
library cryptographicCodes
{
    string public constant DECRYPT_FAULURE = "0xE0";
    string public constant DECRYPT_SUCCESS = "0xE1";
    string public constant AWAITING_OTHER_SINGATURE = "0xE2";	//Awaiting Other Signatures or Keys
    string public constant SIGNED = "0xE3";
    string public constant USIGNED_OR_UNUTRUSTED = "0xE4";
    string public constant SIGNATURE_REQUIRED = "0xE5";
    string public constant KNOWN_COMPRIMISED = "0xE6";
    //string public constant [reserved] = "0xE7	[reserved]
    string public constant ALREADY_SIGNED_OR_NOT_ENCRYPTED = "0xE8";
    //string public constant [reserved] = "0xE9	[reserved]
    //string public constant [reserved] = "0xEA	[reserved]
    //string public constant [reserved] = "0xEB	[reserved]
    //string public constant [reserved] = "0xEC	[reserved]
    //string public constant [reserved] = "0xED	[reserved]
    //string public constant [reserved] = "0xEE	[reserved]
    string public constant METADATA = "0xEF";
}

//0xF* Off-Chain, for off-chain actions. Much like th 0x0*: Generic range, 0xF* is very general, and does little to modify the reason.
//Among other things, the meta code 0xFF may be used to describe what the off-chain process is.
library offchainCodes
{
    string public constant OFF_CHAIN_FAILURE = "0xF0";
    string public constant OFF_CHAIN_SUCCESS = "0xF1";
    string public constant AWAITING_OFF_CHAIN_PROCESS = "0xF2";
    string public constant OFF_CHAIN_PROCESS_STRATED = "0xF3";
    string public constant OFF_CHAIN_SERVICE_UNREACHABLE = "0xF4";
    string public constant OFF_CHAIN_ACTION_REQUIRED = "0xF5";
    string public constant OFF_CHAIN_TIMEOUT_REACHED = "0xF6";
    //string public constant [reserved] = "0xF7";
    string public constant DUPLICATE_OFF_CHAIN_REQUEST = "0xF8";
    //string public constant [reserved] = "0xF9";
    //string public constant [reserved] = "0xFA";
    //string public constant [reserved] = "0xFB";
    //string public constant [reserved] = "0xFC";
    //string public constant [reserved] = "0xFD";
    //string public constant [reserved] = "0xFE";
    string public constant METADATA = "0xFF";
}
/**
library FinanceError
{
    string public constant INSUFFICIENT_FUNDS = "101{ISF}";
    //use when manually pre-checking if an account does NOT has enough gas to execute a transaction
    string public constant INSUFFICIENT_GAS = "102{ISG}";
    string public constant INSUFFICIENT_ALLOWANCE = "103{ISA}";
    string public constant PAYMENT_REQUIRED = "104{PAYREQ}";
    //similar to HTTP 500 (forbidden) error, such as restricting access based on geography,
    //or laws specific to various international jurisidictions,
    //such as where cryptocurrencies are illegal
    string public constant ACCESS_FORBIDDEN = "500{FORBIDDEN}";
}

///
///Invalid Addresses
///
library AddressError
{
    //use this if an account tries to transact with the null address, itself or with a contract which does not supoort receive() or fallback()
    string public constant IS_NULL = "301{AIN}";
    string public constant IS_NOT_NULL = "302{AINN}";
    //use this if an account tries to withdraw an allowance from the null address, itself or with a contract which does not supoort receive() or fallback()
    string public constant INVALID_RECIPIENT = "303{IRA}";
    string public constant INVALID_FROM = "304{AIF}";
}
///
///Strings
///
//library StringError
//{
    //string public constant EMPTY = "301{ESTR}";
    //string public constant INVALID_SECRET = "303{IVS}";
//}
///
///AccessControl
///
//library PermissionsError
//{
    //for when an AccessControl or Ownable or other such role based permissions are denied to a registered account
    //400, bad request due to invalid client data
    //string public constant INVALID_PERMISSIONS = "400{IVP}";
    //caller is not a client of this platform and does not have rights to access its functionality,
    //similar to IVP except this is the default state, when non-registered account,
    //by default are not clients and must undergo a registration process first
    //401 unauthorized, use when authentication fails
    //string public constant IS_NOT_CLIENT = "401{INC}";
    //HTTP 404 resouce not found, for when fallback() can not resolve an external call,
    //or a contract has been killed and no longer exists/is "alive" in a functioning state
    //string public constant ACCESS_NOT_FOUND = "404{NF}";
    //useful when a function is deleted or proxying is not enabled
    //string public constant METHOD_NOT_ALLOWED = "405{MNA}";
//}
*/