// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC-137 Ethereum Domain Name Service Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 11/30/2021, All Rights Reserved
///
library abiEncoderERC137
{
    //bytes internal constant SIG_OWNER = abi.encodeWithSignature('owner()');
    //bytes internal constant SIG_RENOUNCE_OWNERSHIP = abi.encodeWithSignature('renounceOwnership()');
    
    string internal constant STUB_TRANSFER_OWNERSHIP = 'transferOwnership(address)';
    
    string internal constant STUB_OWNER = 'owner(bytes32 node)';
    string internal constant STUB_RESOLVER = 'resolver(bytes32 node)';
    string internal constant STUB_TTL = 'ttl(bytes32 node)';
    //
    string internal constant STUB_SET_OWNER = 'setOwner(bytes32,address)';
    string internal constant STUB_SET_SUBNODE_OWNER = 'setSubnodeOwner(bytes32,bytes32,address)';
    //
    string internal constant STUB_SET_RESOLVER = 'setResolver(bytes32,address)';
    string internal constant STUB_SET_TTL = 'setTTL(bytes32,uint64)';
    
    function owner(
        bytes32 node
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_OWNER,
            node
        );
    }
    //
    function resolver(
        bytes32 node
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_RESOLVER,
            node
        );
    }
    
    function ttl(
        bytes32 node
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_TTL,
            node
        );
    }
    
    function setOwner(
        bytes32 node,
        address owner
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_SET_OWNER,
            node,
            owner
        );
    }
    
    function setSubnodeOwner(
        bytes32 node,
        bytes32 label,
        address owner
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_SET_SUBNODE_OWNER,
            node,
            label,
            owner
        );
    }

    function setResolver(
        bytes32 node,
        address resolver
    )internal pure returns(
        bytes memory
    ){
        //_requireSupportsInterfaceERC137Resolver(
            //resolver
        //);
        
        return abi.encodeWithSignature(
            STUB_SET_RESOLVER,
            node,
            resolver
        );
    }

    function setTTL(
        bytes32 node,
        uint64 ttl
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_SET_TTL,
            node,
            ttl
        );
    }
}