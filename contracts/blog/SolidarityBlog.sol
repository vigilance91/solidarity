// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/TokenIdentifier/TokenIdentifierABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/introspection/mortalCanary/MortalCanary.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/iAccessControl.sol";
import "https://github.com/vigilance91/solidarity/EIP/announcements/iEIP1129.sol";

import "https://github.com/vigilance91/solidarity/EIP/announcements/EIP1129.sol";
/**
interface iSolidarityBlog is iMortalCanary,
    iTokenIdentifier,
    iEIP1129
{
}
*/
///
/// @title Blog Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
/// @dev EIP-1129 compliant Blog contract with a name and symbol, although not a token, helps identify different blog and versions
///
contract SolidarityBlog is MortalCanary,
    TokenIdentifierABC,
    EIP1129
{
    constructor(
    )public
        MortalCanary()
        TokenIdentifierABC(
            "Solidarity Blog V1",
            'SBV1'
        )
        EIP1129()
    {
        _registerInterface(type(iTokenIdentifier).interfaceId);
        _registerInterface(type(iAccessControl).interfaceId);
        _registerInterface(type(iEIP1129).interfaceId);
        //_registerInterface(type(iSolidarityBlog).interfaceId);
    }
}