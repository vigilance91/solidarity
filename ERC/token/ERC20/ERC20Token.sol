// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/EIP801Canary.sol";
import "https://github.com/vigilance91/solidarity/ERC/token/ERC20/ERC20.sol";

/// full interface
//interface iERC20Token is iEIP801Canary,
    //iERC20
//{
//}

///
/// @title ERC20Token Implementation
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev basic ERC-20 token with ERC-165 and ERC-173 support
///
abstract contract ERC20Token is EIP801Canary,
    ERC20
{
    constructor(
        string memory name,
        string memory symbol
    )internal EIP801Canary()
        ERC20(name, symbol)
    {
        _registerInterface(type(iERC20).interfaceId);
        //_registerInterface(type(iERC20Token).interfaceId);
    }
    //function _beforeTokenTransfer(
        //address from,
        //address to,
        //uint256 amount
    //)internal virtual override{
        //super._beforeTokenTransfer(from, to,amount);
    //}
}