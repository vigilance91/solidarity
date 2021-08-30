// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/introspection/Consumable/encoder/EncoderAllowanceABC.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
///
/// @title Allowance Transaction Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
/// 
contract EncoderAllowance is ERC165,
    EncoderAllowanceABC
{
    using abiEncoderAllowance for address;
    
    constructor(
    )public
        ERC165()
        EncoderAllowanceABC()
    {
        //_registerInterface(type(iEncoderAllowance).interfaceId);
    }
}