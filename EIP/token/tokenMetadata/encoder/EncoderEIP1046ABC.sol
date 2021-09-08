// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/encoder/iEncoderEIP801.sol";
import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/encoder/abiEncoderEIP801.sol";
///
/// @title EIP-1046 Token Metadata Transaction Encoder Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 8/9/2021, All Rights Reserved
/// @dev ligi, "EIP-801: ERC-801 Canary Standard [DRAFT]," Ethereum Improvement Proposals, no. 801, December 2017. [Online serial].
/// Available: https://eips.ethereum.org/EIPS/eip-801
/// 
abstract contract EncoderEIP1046ABC is iEncoderEIP1046
{
    bytes private constant _SIG_TOKEN_URI = abi.encodeWithSignature('tokenURI()');
    
    constructor(
    )internal
    {
    }
    /// 
    /// @return {bytes} payload for a `tokenURI` call to an external contract or proxy
    /// 
    function tokenURI(
    )public pure override returns(
        bytes memory
    ){
        return _SIG_TOKEN_URI;
    }
}