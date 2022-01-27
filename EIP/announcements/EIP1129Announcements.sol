// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/ERC173/ERC173Ownable.sol";

import "https://github.com/vigilance91/solidarity/EIP/announcements/iEIP1129.sol";
import "https://github.com/vigilance91/solidarity/EIP/announcements/EIP1129.sol";
/**
interface iEIP1129Announcements is iEIP801Canary,
    iEIP1129
{
}
*/
///
/// @title EIP1129 Annoucements
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 8/4/2021, All Rights Reserved
///
contract EIP1129Announcements is ERC173Ownable, //EIP801Canary
    EIP1129
{
    constructor(
    )public
        ERC173Ownable()
        EIP1129()
    {
        //_registerInterface(type(iAccessControl).interfaceId);
        _registerInterface(type(iEIP1129).interfaceId);
        //_registerInterface(type(iEIP1129Announcements).interfaceId);
    }
}