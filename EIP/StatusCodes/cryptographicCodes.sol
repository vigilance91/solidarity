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
    string public constant DECRYPT_FAULURE = "0xE0";
    string public constant DECRYPT_SUCCESS = "0xE1";
    string public constant AWAITING_OTHER_SINGATURE = "0xE2";	//Awaiting Other Signatures or Keys
    string public constant SIGNED = "0xE3";
    string public constant UNSIGNED_OR_UNUTRUSTED = "0xE4";
    string public constant SIGNATURE_REQUIRED = "0xE5";
    string public constant KNOWN_COMPRIMISED = "0xE6";
    //string public constant [reserved] = "0xE7	[reserved]
    string public constant ALREADY_SIGNED_OR_NOT_ENCRYPTED = "0xE8";
    //string public constant [invalidSignature] = "0xE9	[reserved]
    //string public constant [invalidHash] = "0xEA	[reserved]
    //string public constant [reserved] = "0xEB	[reserved]
    //string public constant [reserved] = "0xEC	[reserved]
    //string public constant [reserved] = "0xED	[reserved]
    //string public constant [reserved] = "0xEE	[reserved]
    string public constant METADATA = "0xEF";
}