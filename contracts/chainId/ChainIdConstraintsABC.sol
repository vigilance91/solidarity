// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";
//import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";
//import "https://github.com/vigilance91/solidarity/libraries/bytes32/bytes32Constraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";

import "https://github.com/vigilance91/solidarity/contracts/chainId/mixinChainId.sol";
/// 
/// @title Chain ID Constraints Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/9/2021, All Rights Reserved
/// 
abstract contract ChainIdConstraintsABC
{
    using logicConstraints for bool;
    
    //using uint256ToString for uint256;
    using uint256Logic for uint256;
    using uint256Constraints for uint256;
    
    string private constant _NAME = ' ChainIdConstraintsABC: ';
    
    constructor(
    )internal
    {
        mixinChainId.setChainId();

        //_requireVerifyHashes();
    }
    
    function _chainId(
    )internal pure returns(
        uint256
    ){
        //if(_cachedChainIdNotEqualThis()){
            //reset();
        //}
        //prevent forking to unsupported chains
        //_requireThisChainSupported();
        
        return mixinChainId.chainId();
    }

    function _chainIdHash(
    )internal view returns(
        bytes32
    ){
        return mixinChainId.idHash();
    }

    function _chainIdString(
    )internal view returns(
        string memory
    ){
        return mixinChainId.idString();
    }
    //
    //constrain execution of code to a specific chain eg:
    //  Ethereum Mainet:
    //  Ropsten:
    //  :
    //  :
    //  Kovan:
    //  Matic:
    //  BSC:
    //
    function _requireChain(
        uint256 chain
    )internal pure
    {
        _chainIdEqual(chain).requireTrue();
    }
    function _requireNotChain(
        uint256 chain
    )internal pure
    {
        _chainIdEqual(chain).requireFalse();
    }

    function _requireIsSet(
    )internal view
    {
        mixinChainId.isSet().requireTrue(
            "chainID not set"
        );
    }

    function _requireNotSet(
    )internal view
    {
        mixinChainId.isSet().requireFalse(
            "chainID cannot be set"
        );
    }
    /// 
    /// @dev used to prevent code execution if the even of a chain fork,
    /// such that the cached chain ID hashes will not match the executing the forked blockchain's new chain ID,
    /// preventing replaying attacks when forks occur
    /// 
    function _requireVerifyHashes(
    )internal view
    {
        _requireIsSet();

        mixinChainId.requireVerifyRawHash();
        mixinChainId.requireVerifyHash();
    }
    
    //function _requireChains(
        //uint256[] memory chains
    //)internal pure
    //{
        // uint L = chains.length;

        //L.requireGreaterThanZero();
        
        //for(uint i; i < L; i++){
            //if(!mixinChainId.chainIdEqual(chains[i])){
                //return false;
            //}
        //}
    //}
    //function _requireNotChains(
        //uint256[] memory chains
    //)internal pure
    //{
        // uint L = chains.length;

        //L.requireGreaterThanZero();
        
        //for(uint i; i < L; i++){
            //if(!mixinChainId.chainIdEqual(chains[i])){
                //return false;
            //}
        //}
    //}
    
    function _requireChainIdStringEqual(
        string memory id
    )internal view
    {
        _chainIdStringEqual(id).requireTrue();
    }
    function _requireChainIdStringNotEqual(
        string memory id
    )internal view
    {
        _chainIdStringEqual(id).requireFalse();
    }
    
    function _requireChainHashEqual(
        bytes32 hash
    )internal view
    {
        _chainIdHashEqual(hash).requireTrue();
    }
    function _requireChainHashNotEqual(
        bytes32 hash
    )internal view
    {
        _chainIdHashEqual(hash).requireFalse();
    }
    
    function _chainIdStringEqual(
        string memory id
    )internal view returns(
        bool
    ){
        return mixinChainId.idStringEqual(id);
    }
    
    function _chainIdEqual(
        uint256 id
    )internal pure returns(
        bool
    ){
        return _chainId().equal(id);
    }
    
    function _chainIdHashEqual(
        bytes32 hash
    )internal view returns(
        bool
    ){
        return mixinChainId.chainHashEqual(hash);
    }
}

abstract contract MultiChainIdConstraintsABC is ChainIdConstraintsABC
{
    using logicConstraints for bool;
    
    mapping(uint256=>bool) _supportedChains;
    
    constructor(
        uint256[] memory whitelistedChainIds
        //uint256[] memory blacklistedChainIds
    )internal
        ChainIdConstraintsABC()
    {
        //_supportedChains[CHAIN_IDS.ETHEREUM] = true;
        //_supportedChains[CHAIN_IDS.KOVAN] = true;
        //
        //testnets
        //_supportedChains[CHAIN_IDS.ROPSTEN] = true;
        
        uint256 CID;
        
        for(uint i; i < whitelistedChainIds.lenght; i++){
            cid = whitelistedChainIds[i];
            
            if(!_supportedChains[cid]){
                _supportedChains[cid] = true;
            }
        }
    }
    
    //function _thisChainSupported(
    //)internal view returns(
        //bool
    //){
        //return _supportedChains[_chainId()];
    //}
    function _chainIdSupported(
        uint256 chainId
    )internal view
    {
        return _supportedChains[chainId];
    }
    
    function _requireChainIdSupported(
        uint256 chainId
    )internal view
    {
        _supportedChains[chainId].requireTrue(
        );
    }
    function _requireChainIdNotSupported(
        uint256 chainId
    )internal view
    {
        _supportedChains[chainId].requireFalse(
        );
    }
    
    //function _requireChainIdsSupported(
        //uint256[] calldata chainIds
    //)external view
    //{
        //_supportedChains[chainId].requireTrue(
        //);
    //}
    //function _requireChainIdsNotSupported(
        //uint256[] calldata chainIds
    //)external view
    //{
        //_supportedChains[chainId].requireFalse(
        //);
    //}
}