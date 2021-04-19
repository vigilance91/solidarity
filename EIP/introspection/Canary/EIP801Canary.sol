// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/eventsEIP801.sol";
import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/EIP801.sol";

import "https://github.com/vigilance91/solidarity/ERC/ERC173/ERC173Ownable.sol";

/**
interface iEIP801Canary is iERC173Ownable,
    iEIP801
{
}
*/

///
/// @title EIP-801 Canary Standard Compliant Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev ligi, "EIP-801: ERC-801 Canary Standard [DRAFT]," Ethereum Improvement Proposals, no. 801, December 2017. [Online serial].
/// Available: https://eips.ethereum.org/EIPS/eip-801
/// 
contract EIP801Canary is ERC173Ownable,
    EIP801
{
    using eventsEIP801 for address;
    
    constructor(
    )public ERC173Ownable()
        EIP801()
    {
        _registerInterface(type(iEIP801).interfaceId);
        //_registerInterface(type(iEIP801Canary).interfaceId);
        
        _this.emitCreated(
            owner()
        );
    }
}