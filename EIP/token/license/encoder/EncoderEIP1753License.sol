// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/token/license/encoder/EncoderEIP1753ABC.sol";

//import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
///
/// @title Allowance Transaction Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
/// 
contract EncoderEIP1753License is //ERC165
    EncoderEIP1753ABC
{
    using abiEncoderEIP1735 for address;
    
    constructor(
    )public
        //ERC165()
        //EncoderEIP1753ABC()
    {
        //_registerInterface(type(iEncoderEIP1753).interfaceId);
    }
}