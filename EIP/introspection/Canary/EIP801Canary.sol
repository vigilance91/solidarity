// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
//
//note: ERC173 is unsafe by allowing ownership transfers to contracts which can not,
//      instead of directly inehriting from ERC173, this implementation of EIP801Canary
//      derives from SafeERC173Ownable instead, which automatically reverts if transfering
//      ownership to a contract which does not implement iERC173Receiver or inherits from SafeERC173Ownable
//
//import "https://github.com/vigilance91/solidarity/ERC/ERC173/ERC173Ownable.sol";
import "https://github.com/vigilance91/solidarity/contracts/ownership/safeERC173/ownable/SafeERC173Ownable.sol";

import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/EIP801.sol";
import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/eventsEIP801.sol";

/**
interface iEIP801Canary is iSafeERC173OwnableOwner,
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
contract EIP801Canary is SafeERC173Ownable, //ERC173OwnableOwner,
    EIP801
{
    using eventsEIP801 for address;
    
    constructor(
    )public
        SafeERC173Ownable()
        EIP801()
    {
        _registerInterface(type(iEIP801).interfaceId);
        //_registerInterface(type(iEIP801Canary).interfaceId);
        
        _this.emitCreated(
            owner()
        );
    }
}