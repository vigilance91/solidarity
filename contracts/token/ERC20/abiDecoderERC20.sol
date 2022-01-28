// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";
//import "https://github.com/vigilance91/solidarity/libraries/bytes/bytesConstraints.sol";
///
/// @title ERC20 Transaction Decoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
///
library abiDecoderERC20
{
    using logicConstraints for bool;
    
    //using bytesConstraints for bytes;
    
    //string private constant _NAME = ' abiDecoderERC20: ';
    
    /// @return {uint256} amount of tokens owned by `account`
    function balanceOf(
        bytes memory data
    )internal pure returns(
        address token,
        address account
    ){
        //data.requireNotEmpty();
        (
            token,
            account
        ) = abi.decode(
            data,
            (address, address)
        );
    }
    ///
    /// @dev Moves `amount` tokens from the caller's account to `recipient`
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    function transfer(
        bytes memory data
    )internal pure returns(
        address token,
        address recipient,
        uint256 amount
    ){
        //data.requireNotEmpty();
        (
            token,
            recipient,
            amount
        ) = abi.decode(
            data,
            (address, address, uint256)
        );
    }
    ///
    /// @dev return {uint256} amount of tokens `spender` is allowed to spend/withdrawl on behalf of `owner` through {transferFrom}
    ///
    /// NOTE:
    ///     this value is zero by default and
    ///     changes when {approve}, {increaseAllownace}, {decreaseAllowance} or {transferFrom} are called
    ///
    function allowance(
        bytes memory data
    )internal pure returns(
        address token,
        address owner,
        address spender
    ){
        //data.requireNotEmpty();
        (
            token,
            owner,
            spender
        ) = abi.decode(
            data,
            (address, address, address)
        );
    }
    ///
    /// @dev Sets `amount` as the allowance of `spender` over the caller's tokens
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    function approve(
        bytes memory data
    )internal pure returns(
        address token,
        address spender,
        uint256 amount
    ){
        //data.requireNotEmpty();
        (
            token,
            spender,
            amount
        ) = abi.decode(
            data,
            (address, address, uint256)
        );
    }
    ///
    /// @dev Move `amount` tokens from `sender` to `recipient`
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    function transferFrom(
        bytes memory data
    )internal pure returns(
        address token,
        address sender,
        address recipient,
        uint256 amount
    ){
        //data.requireNotEmpty();
        (
            token,
            sender,
            recipient,
            amount
        ) = abi.decode(
            data,
            (address, address, address, uint256)
        );
    }
}