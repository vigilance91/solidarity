// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/chainId/iChainId.sol";
import "https://github.com/vigilance91/solidarity/contracts/chainId/ChainIdConstraintsABC.sol";
/// 
/// @title Chain ID Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/9/2021, All Rights Reserved
/// @dev execution cost to deploy: 626,728 
/// 
contract ChainId is ChainIdConstraintsABC,
    iChainId
{
    constructor(
    )public
        ChainIdConstraintsABC()
    {
    }
    //
    //public iChainId interface
    //
    function chainId(
    )public pure override returns(
        uint256
    ){
        return _chainId();
    }
    
    function chainIdHash(
    )public view override returns(
        bytes32
    ){
        return _chainIdHash();
    }
    function chainIdEqual(
        uint256 id
    )public pure override returns(
        bool
    ){
        return _chainIdEqual(id);
    }
    
    function chainIdHashEqual(
        bytes32 hash
    )public view override returns(
        bool
    ){
        return _chainIdHashEqual(hash);
    }
}