// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
/// 
/// @title Chain ID Constraints Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/9/2021, All Rights Reserved
/// 
interface iChainId
{
    function chainId(
    )external pure returns(
        uint256
    );
    function chainIdHash(
    )external view returns(
        bytes32
    );
    function chainIdEqual(
        uint256 id
    )external pure returns(
        bool
    );
    
    function chainIdHashEqual(
        bytes32 idHash
    )external view returns(
        bool
    );
}