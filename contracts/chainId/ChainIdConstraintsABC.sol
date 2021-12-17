// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";
//import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";
//import "https://github.com/vigilance91/solidarity/libraries/bytes32/bytes32Constraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";

import "https://github.com/vigilance91/solidarity/contracts/chainId/mixinChainID.sol";
/// 
/// @title Chain ID Constraints Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/9/2021, All Rights Reserved
/// 
abstract contract ChainIdConstraintsABC
{
    using LogicConstraints for bool;
    
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
    //}
    //function _requireNotChains(
        //uint256[] memory chains
    //)internal pure
    //{
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