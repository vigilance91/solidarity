// SPDX-License-Identifier: Apache 2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/ERC165/ERC165.sol";
import "https://github.com/vigilance91/solidarity/ERC/ERC173/ERC173.sol";

///interface iERC173Ownable is iERC165,
    //iERC173
//{
//}

///
/// @title ERC-173 Compliant Ownable Contract, with default support for ERC-165
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
///
abstract contract ERC173Ownable is ERC165,
    ERC173
{
    //bytes4 private constant _ERC173_INTERFACE_ID = type(iERC173).interfaceId;
    ////bytes4 private constant _OWNABLE_INTERFACE_ID = type(iERC173Ownable).interfaceId;
    
    constructor(
    )internal ERC165()
        ERC173()
    {
        _registerInterface(type(iERC173).interfaceId);
        //_registerInterface(type(iERC173Ownable).interfaceId);
    }
}