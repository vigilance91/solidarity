// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
//
import "https://github.com/vigilance91/solidarity/contracts/ownership/safeERC173/SafeERC173OwnableOwner.sol";

import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/EIP801.sol";
import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/eventsEIP801.sol";

//interface iSafeEIP801Canary is iSafeERC173OwnableOwner,
//    iEIP801
//{
//}

///
/// @title Safe EIP-801 Canary Standard Compliant Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev ligi, "EIP-801: ERC-801 Canary Standard [DRAFT]," Ethereum Improvement Proposals, no. 801, December 2017. [Online serial].
/// Available: https://eips.ethereum.org/EIPS/eip-801
/// 
contract SafeEIP801Canary is SafeERC173OwnableOwner,
    EIP801
    //iSafeEIP801Canary
{
    using eventsEIP801 for address;
    
    constructor(
    )public
        SafeERC173OwnableOwner()
        EIP801()
    {
        _registerInterface(type(iEIP801).interfaceId);
        //_registerInterface(type(iERC173OwnableOwner).interfaceId);
        //_registerInterface(type(iSafeEIP801Canary).interfaceId);
        
        _this.emitCreated(
            owner()
        );
    }
}