// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/ERC173/encoder/abiEncoderERC173.sol";
import "https://github.com/vigilance91/solidarity/ERC/ERC173/encoder/iEncoderERC173.sol";
///
/// @title ERC-173 Ownership Transaction Encoder Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
///
abstract contract EncoderERC173ABC is iEncoderERC173
{
    constructor(
    )internal
    {
    }
    
    function owner(
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderERC173.SIG_OWNER;
    }
    
    function renounceOwnership(
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderERC173.SIG_RENOUNCE_OWNERSHIP;
    }
    
    function transferOwnership(
        address newOwner
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderERC173.transferOwnership(
            newOwner
        );
    }
}