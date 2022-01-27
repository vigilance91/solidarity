// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/TokenIdentifier/encoder/EncoderTokenIdentifierABC.sol";
import "https://github.com/vigilance91/solidarity/EIP/token/license/encoder/EncoderEIP1753ABC.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
interface iEncoderEIP1753License is iEncoderTokenIdentifier,
    iEncoderEIP1753
{
    
}
///
/// @title Allowance Transaction Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
/// 
contract EncoderEIP1753License is ERC165,
    EncoderTokenIdentifierABC,
    EncoderEIP1753ABC
{   
    constructor(
    )public
        ERC165()
        EncoderTokenIdentifierABC()
        EncoderEIP1753ABC()
    {
        _registerInterface(type(iEncoderTokenIdentifier).interfaceId);
        _registerInterface(type(iEncoderEIP1753).interfaceId);
        
        _registerInterface(type(iEncoderEIP1753License).interfaceId);
    }
}