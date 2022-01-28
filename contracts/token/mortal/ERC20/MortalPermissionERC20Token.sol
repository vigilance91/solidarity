// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/mortal/ERC20/MortalERC20Token.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/whitelist/frameworkWhitelist.sol";
//import "https://github.com/vigilance91/solidarity/contracts/accessControl/blacklist/frameworkBlacklist.sol";

/// full interface
//interface iMortalPermissionERC20Token is iMortalCanary,
    //iERC20
//{
//}

///
/// @title Mortal Permission ERC20Token Implementation
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 13/5/2021, All Rights Reserved
/// @dev standard ERC-20 token with (non-standard) Apoptosis support, for killing the contract (or for it to shut itself down internally)
/// Whitelist is deployed using create2 via EIP2470 SingletonFactory and should thus have the same address contract
/// every network deployed, assuming the contract creation code and the Factory's hash remain the same
/// 
/// NOTE:
///     if either the Factory's hash or the creation code have changed, the address the Whitelist is deployed to will vary
///
abstract contract MortalPermissionERC20Token is MortalERC20Token
{
    using logicConstraints for bool;
    
    using frameworkWhitelist for address;
    
    address private constant _WHITELIST = 0x9cF2b03628F83E2b73B19D652959CDB2C06153f2;
    //address private constant _BLACKLIST = 0x0;
    
    constructor(
        string memory name,
        string memory symbol
    )internal
        MortalERC20Token(name, symbol)
    {
        //_registerInterface(type(iMortalERC20Token).interfaceId);
    }
    function _requirePermitted(
        address account
    )internal view
    {
        isPermitted(account).requireTrue(
            'address is not whitelisted'
        );
    }
    function isPermitted(
        address account
    )public view returns(
        bool
    ){
        return _WHITELIST.isPermitted(account);
    }
    
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    )internal virtual override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}