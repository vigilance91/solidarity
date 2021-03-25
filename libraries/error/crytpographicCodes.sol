// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//0xB* TBD - Currently unspecified. (Full range reserved)
//0xC* TBD - Currently unspecified. (Full range reserved)
//0xD* TBD - Currently unspecified. (Full range reserved)

/// @title Cryptographic Error Code Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 25/3/2021, All Rights Reserved
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