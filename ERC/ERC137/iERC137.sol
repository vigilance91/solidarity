// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC-137 Ethereum Domain Name Service Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 11/30/2021, All Rights Reserved
///
interface iERC137
{
    //NOTE: ENS registry address on Mainnet, Ropsten, Rinkby and Goerli is: 0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e
    //NOTE: .eth registrar address: 0x57f1887a8BF19b14fC0dF6Fd9B2acc9Af147eA85
    //NOTE: address for the public resolver: 0x4976fb03C32e5B8cfe2b6cCB31c09Ba78EBaBa41
    //the public resolver looks up names in the ENS registry to determine who is permitted to configure records for them
    //
    function owner(
        bytes32 node
    )external view returns(
        address
    );
    //
    function resolver(
        bytes32 node
    )external view returns(
        address
    );
    
    function ttl(
        bytes32 node
    )external view returns(
        uint64
    );
    
    function setOwner(
        bytes32 node,
        address owner
    )external;
    
    function setSubnodeOwner(
        bytes32 node,
        bytes32 label,
        address owner
    )external;

    function setResolver(
        bytes32 node,
        address resolver
    )external;

    function setTTL(
        bytes32 node,
        uint64 ttl
    )external;
}