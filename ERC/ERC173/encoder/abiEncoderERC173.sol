// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC-173 Ownership Transaction Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
///
library abiEncoderERC173
{
    bytes internal constant SIG_OWNER = abi.encodeWithSignature('owner()');
    bytes internal constant SIG_RENOUNCE_OWNERSHIP = abi.encodeWithSignature('renounceOwnership()');
    
    string internal constant STUB_TRANSFER_OWNERSHIP = 'transferOwnership(address)';
    
    function transferOwnership(
        address newOwner
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_TRANSFER_OWNERSHIP,
            newOwner
        );
    }
}