// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/ERC137/encoder/abiEncoderERC137.sol";
import "https://github.com/vigilance91/solidarity/ERC/ERC137/encoder/iEncoderERC137.sol";
///
/// @title ERC-137 Ethereum Domain Name Service Encoder Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/11/2021, All Rights Reserved
///
abstract contract EncoderERC137ABC is iEncoderERC137
{
    constructor(
    )internal
    {
    }
    
    function owner(
        bytes32 node
    )public pure override returns(
        bytes memory
    ){
        //_requireNotNullBytes32(node);
        
        return abiEncoderERC137.owner(
            node
        );
    }
    //
    function resolver(
        bytes32 node
    )public pure override returns(
        bytes memory
    ){
        //_requireNotNullBytes32(node);
    
        return abiEncoderERC137.resolver(
            node
        );
    }
    
    function ttl(
        bytes32 node
    )public pure override returns(
        bytes memory
    ){
        //_requireNotNullBytes32(node);
        
        return abiEncoderERC137.ttl(
            node
        );
    }
    
    function setOwner(
        bytes32 node,
        address owner
    )public pure override returns(
        bytes memory
    ){
        //_requireNotNullBytes32(node);
        
        return abiEncoderERC137.setOwner(
            node,
            owner
        );
    }
    
    function setSubnodeOwner(
        bytes32 node,
        bytes32 label,
        address owner
    )public pure override returns(
        bytes memory
    ){
        //_requireNotNullBytes32(node);
        ////_requireNotNullBytes32(label);
        
        return abiEncoderERC137.setSubnodeOwner(
            node,
            label,
            owner
        );
    }

    function setResolver(
        bytes32 node,
        address resolver
    )public pure override returns(
        bytes memory
    ){
        //_requireNotNullBytes32(node);
        //_requireSupportsInterfaceERC137Resolver(
            //resolver
        //);
        
        return abiEncoderERC137.setResolver(
            node,
            resolver
        );
    }

    function setTTL(
        bytes32 node,
        uint64 ttl
    )public pure override returns(
        bytes memory
    ){
        //_requireNotNullBytes32(node);
        
        return abi.encodeWithSignature(
            node,
            ttl
        );
    }
}