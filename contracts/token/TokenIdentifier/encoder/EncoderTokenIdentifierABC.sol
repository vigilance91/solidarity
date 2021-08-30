// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/libraries/token/abiEncoderERC20.sol";

//import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/iEncoderERC20.sol";
//import "https://github.com/vigilance91/solidarity/ERC/token/ERC20/iEncoderERC20.sol";

import "./abiEncoderTokenIdentifier.sol";

import "./iEncoderTokenIdentifier.sol";
///
/// @title ERC20 Transaction ABI Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 27/8/2021, All Rights Reserved
/// convenience library for creating encoded signatures for low-level address call operations
///
abstract contract EncoderTokenIdentifierABC is iEncoderTokenIdentifier
{   
    constructor(
    )internal
    {
    }
    /// @return {uint256} amount of tokens owned by `account`
    function name(
    )public pure virtual override returns(
        bytes memory
    ){
        return abiEncoderTokenIdentifier.SIG_NAME;
    }
    function symbol(
    )public pure virtual override returns(
        bytes memory
    ){
        return abiEncoderTokenIdentifier.SIG_SYMBOL;
    }
}