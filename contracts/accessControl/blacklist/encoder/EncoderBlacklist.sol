// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/libraries/token/abiEncoderERC20.sol";

//import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/iEncoderERC20.sol";
//import "https://github.com/vigilance91/solidarity/ERC/token/ERC20/iEncoderERC20.sol";

import "./abiEncoderBlacklist.sol";

import "./iEncoderBlacklist.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
///
/// @title Blacklist Transaction ABI Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 9/12/2021, All Rights Reserved
/// convenience library for creating encoded transactions for low-level address call operations on Blacklists
///
contract EncoderBlacklist is iEncoderBlacklist,
    ERC165
    //EncoderAccessControlABC
    //EncoderTokenSupplyABC
{
    //using abiEncoderBlacklist for address;
    
    constructor(
    )public
        ERC165()
        //EncoderAccessControlABC()
    {
        _registerInterface(type(iEncoderBlacklist).interfaceId);
    }
    ///
    /// @dev Encodes the transaction to determine if `account` is currently blacklisted
    ///
    function isBanned(
        address account
    )public pure virtual override returns(
        bytes memory
    ){
        return ;
    }
    ///
    /// @dev Encodes the transaction to get the count of all currently blacklisted addresses
    ///
    function bannedAddressCount(
    )public pure virtual override returns(
        bytes memory
    ){
        return ;
    }
    ///
    /// @dev Encodes a transaction to blacklist `account`
    ///
    function ban(
        address account
    )public pure virtual override returns(
        bytes memory
    ){
        return ;
    }
    ///
    /// @dev Encodes a transaction to revoke `account` from blacklist
    ///
    function revokeBan(
        address account
    )public pure virtual override returns(
        bytes memory
    ){
        return ;
    }
    /*
    /// 
    /// @dev gas cost: 22,866
    /// @return {uint256} amount of tokens owned by `account`
    /// 
    function balanceOf(
        address account
    )public pure virtual override returns(
        bytes memory
    ){
        return account.balanceOf();
    }
    ///
    /// @dev Moves `amount` tokens from the caller's account to `recipient`
    /// gas cost: 23,169 
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    function transfer(
        address recipient,
        uint256 amount
    )public pure virtual override returns(
        bytes memory
    ){
        return recipient.transfer(
            amount
        );
    }
    ///
    /// @dev gas cost: 23,508
    /// @return {bytes} binary encoded transaction payload repressenting an `allowance` call to an ERC20 token
    ///
    function allowance(
        address owner,
        address spender
    )public pure virtual override returns(
        bytes memory
    ){
        return owner.allowance(
            spender
        );
    }
    ///
    /// @dev gas cost: 23,081 
    /// @return {bytes} binary encoded transaction payload repressenting a `approve` call to an ERC20 token
    ///
    function approve(
        address spender,
        uint256 amount
    )public pure virtual override returns(
        bytes memory
    ){
        return spender.approve(
            amount
        );
    }
    ///
    /// @dev gas cost: 23,776
    /// @return {bytes} binary encoded transaction payload repressenting a `transferFrom`  call to an ERC20 token
    ///
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    )public pure virtual override returns(
        bytes memory
    ){
        return sender.transferFrom(
            recipient,
            amount
        );
    }
    */
}