// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/SingletonFactory/encoder/abiEncoderEIP2470.sol";
import "https://github.com/vigilance91/solidarity/EIP/SingletonFactory/encoder/iEncoderEIP2470.sol";
///
/// @title EIP-2470 Transaction ABI Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
/// convenience library for creating encoded signatures for low-level address call operations
///
abstract contract EncoderEIP2470 is iEncoderEIP2470
{
    using abiEncoderEIP2470 for bytes;
    
    constructor(
    )internal
    {
        //todo register appropriate interface in derived class which inherits from ERC-165
        //_registerInterface(type(iEncoderERC2470).interfaceId);
    }
    function deployedContracts(
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEIP2470.SIG_DEPLOYEED_CONTRACTS;
    }
    ///
    /// read-only interface
    ///
    function deploy(
        bytes memory byteCode,
        bytes32 salt
    )public pure override returns(
        bytes memory
    ){
        return byteCode.deploy(
            salt
        );
    }
    
    function deployPayable(
        bytes memory byteCode,
        bytes32 salt
    )public pure override returns(
        bytes memory
    ){
        return byteCode.deployPayable(
            salt
        );
    }
}