// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

//import "https://github.com/vigilance91/solidarity/libraries/bytes/BytesConstraints.sol";

import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Logic.sol";
import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Constraints.sol";

//import "https://github.com/vigilance91/solidarity/libraries/string/stringLogic.sol";
import "https://github.com/vigilance91/solidarity/libraries/string/stringUtilities.sol";

//import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";
//import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Logic.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256ToString.sol";
///
/// @title mixinChainId
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/9/2021, All Rights Reserved
/// @dev ChainID mixin implementation
///
library mixinChainId
{
    using LogicConstraints for bool;
    
    //using SafeMath for uint256;
    
    using Bytes32Logic for bytes32;
    using Bytes32Constraints for bytes32;
    
    using uint256Logic for uint256;
    using uint256Constraints for uint256;
    using uint256ToString for uint256;
    
    using StringLogic for string;
    using StringConstraints for string;
    using stringUtilities for string;
    
    //using BytesLogic for bytes;
    //using BytesConstraints for bytes;

    struct ChainIdStorage{
        uint256 id;
        
        bytes32 rawHash;    //hash of packed binary encoded chainId
        bytes32 idHash;  //hash of the decimal string of this chainId
        
        bytes bytesPacked;  //binary encoded uint256 value of chainid
        string idString;    //decimal string of chainId (used in combination with salting nonces and contract address hashes)
    }
    
    bytes32 internal constant STORAGE_SLOT = keccak256("solidarity.mixin.CHAIN_ID.STORAGE_SLOT");
    ///
    ///getters
    ///
    function storageChainId(
    )internal pure returns(
        ChainIdStorage storage ret
    ){
        bytes32 slot = STORAGE_SLOT;
        
        assembly {
            ret_slot := slot
        }
    }
    
    function chainId(
    )internal pure returns(
        uint256 chain
    ){
        assembly {
            chain := chainid()
        }
    }
    //function chainId(
        //bytes32 slot
    //)internal view returns(
        //bytes32
    //){
        //return storageChainId().chainId;
    //}
    function rawHash(
    )internal view returns(
        bytes32
    ){
        return storageChainId().rawHash;
    }
    function idHash(
    )internal view returns(
        bytes32
    ){
        return storageChainId().idHash;
    }
    function idString(
    )internal view returns(
        string memory
    ){
        return storageChainId().idString;
    }
    ///
    ///logic
    ///
    function chainIdEqual(
        uint256 id
    )public pure returns(
        bool
    ){
        return chainId().equal(id);
    }
    //function chainIdNotEqual(
        //uint256 id
    //)public pure returns(
        //bool
    //){
        //return chainId().notEqual(id);
    //}
    //
    function idStringEqual(
        string memory id
    )internal view returns(
        bool
    ){
        return idString().equal(id);
    }
    //function idStringNotEqual(
        //string memory id
    //)internal view returns(
        //bool
    //){
        //return idString().notEqual(id);
    //}
    //
    function chainHashEqual(
        bytes32 hash
    )internal view returns(
        bool
    ){
        return idHash().equal(hash);
    }
    //function chainHashNotEqual(
        //bytes32 hash
    //)internal view returns(
        //bool
    //){
        //return idHash().notEqual(hash);
    //}


    function requireVerifyRawHash(
    )internal view
    {
        ChainIdStorage storage SCID = storageChainId();
        //
        //SCID.bytesPacked.requireNotEmpty();
        SCID.rawHash.requireNotEmpty();     //Null();
        //
        SCID.rawHash.requireEqual(
            keccak256(SCID.bytesPacked)
        );
    }
    
    function requireVerifyHash(
    )internal view
    {
        ChainIdStorage storage SCID = storageChainId();
        //
        //SCID.idString.requireNotEmpty();
        SCID.idHash.requireNotEmpty();  //Null();

        SCID.idHash.requireEqual(
            SCID.idString.hash()
        );
    }
    ///
    ///setters
    ///
    function isSet(
    )internal view returns(
        bool
    ){
        ChainIdStorage storage SCID = storageChainId();
        
        return (SCID.id.greaterThanZero() &&
            SCID.rawHash.notEmpty() &&
            SCID.idHash.notEmpty() &&
            //
            //SCID.bytesPacked.requireNotEmpty() &&
            SCID.idString.notEmpty()
        );
    }
    function setChainId(
    )internal
    {
        isSet().requireFalse();

        ChainIdStorage storage SCID = storageChainId();
        
        //SCID.id.requireIsZero();
        //SCID.rawHash.requireEmpty();  //requireNull();
        //SCID.idHash.requireEmpty();   //requireNull();
        //
        //SCID.bytesPack.requireEmpty();
        //SCID.idString.requireEmpty();
        
        SCID.id = chainId();
        
        SCID.id.requireGreaterThanZero();
        
        SCID.bytesPacked = abi.encodePacked(SCID.id);
        SCID.rawHash = keccak256(SCID.bytesPacked);
        //
        SCID.idString = SCID.id.decimal();
        SCID.idHash = SCID.idString.hash();
    }
    function unsetChainId(
    )internal
    {
        isSet().requireTrue();

        ChainIdStorage storage SCID = storageChainId();
        
        delete SCID.id;
        //
        delete SCID.bytesPacked;
        delete SCID.rawHash;
        //
        delete SCID.idString;
        delete SCID.idHash;
    }
}

//library mixinChainIdList
//{
    //using SafeMath for uint256;
    
    //using bytes32Constraints for bytes32;
    
    //using uint256Constraints for unit256;
    //using uint256ToString for uint256;
    
    //using stringUtilities for string;
    
    //struct ChainIdListStorage{
        //mapping(string=>mixinChainId.ChainIdStorage) namedMap;
        //mixinChainId.ChainIdStorage[] list;
    //}
//}

//abstract contract ChainListABC
//{
    
//}

//contract EthereumChainList is ChainListABC
//{
    //constructor(
        //mixinChainId. [] memory
    //)public
    //ChainIdListABC(
        //({name:'mainnet', chainInfo:mixinChainId.()}),
        //
        //({name:'ropsten', chainInfo:mixinChainId.()}),
        //({name:'kovan', chainInfo:mixinChainId.()}),
        //({name:'rinkeby', chainInfo:mixinChainId.()}),
        //({name:'goeril', chainInfo:mixinChainId.()}),
        //...
    //)
//}

//contract EthereumPolygonChainList is EthereumChainList
//{
    //constructor(
        //mixinChainId. [] memory
    //)public
    //EthereumChainIdList(
        //mixinChainId.()
    //){
        
    //}
//}

//contract EthereumBSCChainList is EthereumChainList
//{
    //constructor(
        //mixinChainId. [] memory
    //)public
    //EthereumChainIdList(
        //mixinChainId.()
    //){
        
    //}
//}

////contract EthereumTOMOChainList is EthereumChainList
////{
    ////constructor(
        ////mixinChainId. [] memory
    ////)public
    ////EthereumChainIdList(
        ////mixinChainId.()
    ////){
        //
    ////}
////}

//contract EthereumTronChainList is EthereumChainList
//{
    //constructor(
        //mixinChainId. [] memory
    //)public
    //EthereumChainIdList(
        //mixinChainId.()
    //){
        
    //}
//}

//contract EthereumXDAIChainList is EthereumChainList
//{
    //constructor(
        //mixinChainId. [] memory
    //)public
    //EthereumChainIdList(
        //mixinChainId.()
    //){
        
    //}
//}

//contract EthereumArbitrumChainList is EthereumChainList
//{
    //constructor(
        //mixinChainId. [] memory
    //)public
    //EthereumChainIdList(
        //mixinChainId.()
    //){
        
    //}
//}

//contract EthereumOptimismChainList is EthereumChainList
//{
    //constructor(
        //mixinChainId. [] memory
    //)public
    //EthereumChainIdList(
        //mixinChainId.()
    //){
        
    //}
//}

//contract AllChainList is EthereumChainList
//{
    //constructor(
    //)public
    //EthereumChainIdList(
        //({name:'polygon', chainInfo:mixinChainId.()}),
        //({name:'bsc', chainInfo:mixinChainId.()}),
        //
        //({name:'tomo', chainInfo:mixinChainId.()}),
        //({name:'tron', chainInfo:mixinChainId.()}),
        //
        //({name:'xdai', chainInfo:mixinChainId.()}),
        //
        //({name:'arbitrum',chainInfo:mixinChainId.()}),
        //({name:'optimism',chainInfo:mixinChainId.()}),
        //
        //({name:'avalanche',chainInfo:mixinChainId.()}),
        //({name:'fantom',chainInfo:mixinChainId.()}),
        //
        //({name:'harmony',chainInfo:mixinChainId.()}),
        ////({name:'ht',chainInfo:mixinChainId.()})
    //){
        
    //}
//}