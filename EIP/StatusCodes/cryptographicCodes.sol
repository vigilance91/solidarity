// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-1066 Status Codes Cryptographic Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/3/2021, All Rights Reserved
/// 0xE* Encryption, Identity & Proofs, actions around signatures, cryptography, signing, and application-level authentication.
/// The meta code 0xEF is often used to signal a payload describing the algorithm or process used
/// 
library cryptographicCodes
{
    string internal constant DECRYPT_FAULURE = "0xE0";
    string internal constant DECRYPT_SUCCESS = "0xE1";
    string internal constant AWAITING_OTHER_SINGATURE = "0xE2";	//Awaiting Other Signatures or Keys
    string internal constant SIGNED = "0xE3";
    string internal constant UNSIGNED_OR_UNUTRUSTED = "0xE4";
    string internal constant SIGNATURE_REQUIRED = "0xE5";
    string internal constant KNOWN_COMPRIMISED = "0xE6";
    //string internal constant [reserved] = "0xE7	[reserved]
    string internal constant ALREADY_SIGNED_OR_NOT_ENCRYPTED = "0xE8";
    //string internal constant [invalidSignature] = "0xE9	[reserved]
    //string internal constant [invalidHash] = "0xEA	[reserved]
    //string internal constant [reserved] = "0xEB	[reserved]
    //string internal constant [reserved] = "0xEC	[reserved]
    //string internal constant [reserved] = "0xED	[reserved]
    //string internal constant [reserved] = "0xEE	[reserved]
    string internal constant METADATA = "0xEF";
}