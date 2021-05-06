// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/introspection/mortalCanary/MortalCanary.sol";

import "https://github.com/vigilance91/solidarity/ERC/token/ERC20/ERC20.sol";
import "https://github.com/vigilance91/solidarity/ERC/token/ERC20/iERC20.sol";

/// full interface
//interface iMortalERC20Token is iMortalCanary,
    //iERC20
//{
//}

///
/// @title Mortal ERC20Token Implementation
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 6/1/2021, All Rights Reserved
/// @dev standard ERC-20 token with (non-standard) Apoptosis support, for killing the contract (or for it to shut itself down internally)
///
abstract contract MortalERC20Token is MortalCanary,
    ERC20,
    iERC20
{
    constructor(
        string memory name,
        string memory symbol
    )internal
        MortalCanary()
        ERC20(name, symbol)
    {
        _registerInterface(type(iERC20).interfaceId);
        //_registerInterface(type(iMortalERC20Token).interfaceId);
    }
    //function apoptosis(
        //address owner,
        //address spender
    //)external view virtual override returns(
    //){
    //}
    function balanceOf(
        address account
    )external view override returns(
        uint256
    ){
        return _balanceOf(account);
    }   
    ///
    /// @dev See {mixinERC20.transfer}
    /// 
    /// Additional Requirements:
    ///     - `recipient` cannot be null
    ///     - `recipient` cannot be msgSender
    ///     - `amount` must be greater than zero
    ///
    function transfer(
        address recipient,
        uint256 amount
    )external virtual override nonReentrant returns(
        bool
    ){
        _transfer(
            _msgSender(),
            recipient,
            amount
        );
        return true;
    }
    ///
    /// @dev Get the current allownace `owner` has granted `spender`,
    /// if this value is 0, `spender` has not been granted an allowance by `owner`
    /// See {mixinERC20.allowance}
    /// 
    /// Additional Requirements:
    ///     - `owner` and `spender` cannot be null
    ///     - `owner` can not be `spender`
    ///
    function allowance(
        address owner,
        address spender
    )external view virtual override returns(
        uint256
    ){
        return _allowance(owner,spender);
    }
    // `spender`'s available allowance permitted by caller
    //function allowanceFor(
        //address spender
    //)external view virtual override nonReentrant returns(
        //uint256
    //){
        //return _allowance(_msgSender(),spender);
    //}
    //function allowanceForCaller(
        //address owner
    //)external view virtual override nonReentrant returns(
        //uint256
    //){
        //return _allowance(owner,_msgSender());
    //}
    ///
    /// @dev See {mixinERC20.approve}
    /// 
    /// Additional Requirements:
    ///     - `spender` cannot be this contract
    ///
    function approve(
        address spender,
        uint256 amount
    )external virtual override nonReentrant returns(
        bool
    ){
        //address sender = _msgSender();
        //spender must not have a previous allownace set, otherwise, call increaseAllowance or decreaseAllowance as required
        //allowance(
            //sender,
            //spender
        //).requireEqualZero();
        
        _approve(
            _msgSender(),
            spender,
            amount
        );
        return true;
    }
    ///
    /// @dev msg.sender transfers `amount` of tokens from `owner` to `recipient`
    /// 
    ///Additional  Requirements:
    ///     - `sender` and `recipient` cannot be the same address
    ///
    function transferFrom(
        address owner,
        address recipient,
        uint256 amount
    )external virtual override nonReentrant returns(
        bool
    ){
        return _transferFrom(
            owner,
            _msgSender(),
            recipient,
            amount
        );
    }
    ///
    /// @dev msg.sender revokes `spender`'s allowance
    /// 
    /// Additional Requirements:
    ///     - `spender` cannot be null
    ///     - `caller` cannot be `spender`
    ///     - `spender` must have a non-zero allowance
    ///
    function revokeAllowance(
        address spender
    )external virtual nonReentrant returns(
        bool
    ){
        return _revokeAllowance(_msgSender(), spender);
    }
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    )internal virtual override{
        super._beforeTokenTransfer(from, to,amount);
    }
}