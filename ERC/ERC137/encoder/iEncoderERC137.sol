// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC-137 Ethereum Domain Name Service Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
///
interface iEncoderERC173
{
    function owner(
        bytes32 node
    )external pure returns(
        bytes memory
    );
    
    function resolver(
        bytes32 node
    )external pure returns(
        bytes memory
    );
    
    function ttl(
        bytes32 node
    )external pure returns(
        bytes memory
    );
    
    function setOwner(
        bytes32 node,
        address owner
    )external pure returns(
        bytes memory
    );
    
    function setSubnodeOwner(
        bytes32 node,
        bytes32 label,
        address owner
    )external pure returns(
        bytes memory
    );

    function setResolver(
        bytes32 node,
        address resolver
    )external pure returns(
        bytes memory
    );

    function setTTL(
        bytes32 node,
        uint64 ttl
    )external pure returns(
        bytes memory
    );
}