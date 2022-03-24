// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Constraints.sol";

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/eventsTokenSupply.sol";
///
/// @title Token Supply Mixin Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev token identifier mixin, for composing tokens which have a total circulating supply,
/// which may either be immutable (static and unchanging) or mutable (may be increased, decreased or set as desired)
///
library mixinTokenSupply
{
    using SafeMath for uint256;
    
    using uint256Constraints for uint256;
    using Bytes32Constraints for bytes32;

    using eventsTokenSupply for uint256;
    
    struct TokenSupplyStorage{
        uint256 totalSupply;
    }
    
    bytes32 internal constant STORAGE_SLOT = bytes32(uint256(
        keccak256("solidarity.mixins.mixinTokenSupply.STORGE_SLOT")
    ) - 1);
    
    bytes32 private constant _TOKEN_SUPPLY_TYPE_HASH = keccak256("solidarity.mixins.mixinTokenSupplyStorage(bytes32 typeHash,uint256 totalSupply)");
    
    function storageTokenSupply(
        //bytes32 slot
    )internal pure returns(
        TokenSupplyStorage storage ret
    ){
        bytes32 position = STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
    //
    //constraints
    //
    function _requireInitialized(
        //bytes32 slot
    )private view
    {
        storageTokenSupply().totalSupply.requireGreaterThanZero();
    }
    function _requireNotInitialized(
        //bytes32 slot
    )private view
    {
        storageTokenSupply().totalSupply.requireIsZero();
    }
    //
    //encoding functions
    //
    function _encode(
        uint256 tokenSupply
    )private pure returns(
        bytes memory
    ){
        return abi.encodePacked(
            keccak256(
                abi.encodePacked(
                    _TOKEN_SUPPLY_TYPE_HASH,
                    tokenSupply
                )
            ),
            _TOKEN_SUPPLY_TYPE_HASH,
            tokenSupply
        );
    }
    function encodeTokenSupply(
        uint256 totalSupply
    )internal pure returns(
        bytes memory
    ){
        return _encode(
            totalSupply
        );
    }
    
    function encodeTokenSupplyStorage(
        TokenSupplyStorage storage self
    )internal view returns(
        bytes memory
    ){
        return _encode(
            self.totalSupply
        );
    }
    function encodeTokenSupplyMemory(
        TokenSupplyStorage memory self
    )internal pure returns(
        bytes memory
    ){
        return _encode(
            self.totalSupply
        );
    }
    //
    //decoding functions
    //
    function decodeTokenSupply(
        bytes memory data
    )internal pure returns(
        //uint256 chainId,
        uint256 totalSupply
    ){
        bytes32 dataHash;
        bytes32 typedHash;

        (
            dataHash,
            typedHash,
            //chainId,
            totalSupply
        ) = abi.decode(
            data,
            (bytes32, bytes32, uint256)
        );
        
        typedHash.requireEqual(_TOKEN_SUPPLY_TYPE_HASH);
        dataHash.requireEqual(
            keccak256(
                abi.encodePacked(
                    _TOKEN_SUPPLY_TYPE_HASH,
                    //_chainId(),
                    totalSupply
                )
            )
        );
    }
    /*
    function decodeTokenSupplyExtra(
        bytes memory data
    )internal pure returns(
        //uint256 chainId,
        uint256 totalSupply,
        bytes memory extraData
    ){
        bytes32 dataHash;
        bytes32 typedHash;

        (
            dataHash,
            typedHash,
            //chainId,
            totalSupply,
            extraData
        ) = abi.decode(
            data,
            (bytes32, bytes32, uint256,bytes)
        );
        
        typedHash.requireEqual(_TOKEN_SUPPLY_TYPE_HASH);
        dataHash.requireEqual(
            keccak256(
                abi.encodePacked(
                    _TOKEN_SUPPLY_TYPE_HASH,
                    //_chainId(),
                    totalSupply
                    //extranData
                )
            )
        );
    }
    */
    ///
    ///getters
    ///
    function totalSupply(
    )internal view returns(
        uint256
    ){
        return storageTokenSupply().totalSupply;
    }
    ///
    ///setters
    ///
    function setTotalSupply(
        uint256 newSupply
    )internal returns(
        uint256
    ){
        uint256 previousSupply = totalSupply();
        
        //newSupply.requireGreaterThanZero();
        //previousSupply.requireNotEqual(newSupply);
        
        storageTokenSupply().totalSupply = newSupply;
        
        previousSupply.emitSetTotalSupply(newSupply);
        
        return newSupply;
    }
    
    function increaseTotalSupply(
        uint256 amountBy
    )internal
    {
        //_requireInitialized();

        amountBy.requireGreaterThanZero();
        uint256 previousSupply = totalSupply();
        
        uint256 newSupply = setTotalSupply(
            previousSupply.add(
                amountBy
            )
        );
        
        assert(previousSupply < newSupply);
        
        previousSupply.emitIncreaseTotalSupply(amountBy, newSupply);
        
        //return newSupply;
    }
    function decreaseTotalSupply(
        uint256 amountBy
    )internal
    {
        //_requireInitialized();

        amountBy.requireGreaterThanZero();
        
        uint256 previousSupply = totalSupply();
        uint256 newSupply = setTotalSupply(
            previousSupply.sub(
                amountBy
            )
        );
        
        newSupply.requireGreaterThanZero(
            //total supply NEVER be 0 after construction
        );
        
        assert(previousSupply > newSupply);
        
        previousSupply.emitDecreaseTotalSupply(amountBy, newSupply);
        //return newSupply;
    }
    
    function initializeZero(
    )internal
    {
        setTotalSupply(0);
        //storageTokenSupply().totalSupply = 0;
    }
    function reset(
        uint256 newSupply
    )internal
    {
        _requireInitialized();
        
        totalSupply().requireNotEqual(newSupply);
        
        setTotalSupply(newSupply);
    }
    function initialize(
        uint256 newSupply
    )internal
    {
        //newSupply().requireGreaterThanZero();
        setTotalSupply(newSupply);
    }
     function initializeBytes(
        //bytes32 slot,
        bytes memory data
    )internal
    {
        _requireNotInitialized();

        setTotalSupply(
            decodeTokenSupply(data)
        );
    }
    function initializeMemory(
        //bytes32 slot,
        TokenSupplyStorage memory tokenSupply
    )internal
    {
        _requireNotInitialized();

        //tokenId.totalSupply.requireGreaterThanZero();
        
        setTotalSupply(tokenSupply.totalSupply);
    }

    function dealloc(
        //bytes32 slot
    )internal
    {
        _requireInitialized();

        TokenSupplyStorage storage s = storageTokenSupply();
        
        delete s.totalSupply;
    }
}