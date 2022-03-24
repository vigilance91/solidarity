// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Constraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/string/stringConstraints.sol";
///
/// @title Token Identifier Mixin Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev token identifier mixin, for composing tokens
/// 
library mixinTokenIdentifier
{
    using stringConstraints for string;
    using Bytes32Constraints for bytes32;

    struct TokenIdentifierStorage{
        string name;
        string symbol;
    }
    
    bytes32 internal constant STORAGE_SLOT = bytes32(uint256(
        keccak256("solidarity.mixins..mixinTokenIdentifier.STORAGE_SLOT")
    ) - 1);
    
    bytes32 private constant _TOKEN_ID_TYPE_HASH = keccak256("solidarity.mixins.mixinTokenIdentifierStorage(bytes32 typeHash,string name, string symbol)");
    
    function storageTokenIdentifier(
        //bytes32 slot
    )internal pure returns(
        TokenIdentifierStorage storage ret
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
        name().requireEmpty();
        symbol().requireEmpty();
    }
    function _requireNotInitialized(
        //bytes32 slot
    )private view
    {
        name().requireNotEmpty();
        symbol().requireNotEmpty();
    }
    //
    //encoding functions
    //
    function encodeTokenIdentifier(
        string memory name,
        string memory symbol
    )internal pure returns(
        bytes memory
    ){
        return abi.encodePacked(
            keccak256(
                abi.encodePacked(
                    _TOKEN_ID_TYPE_HASH,
                    name,
                    symbol
                )
            ),
            _TOKEN_ID_TYPE_HASH,
            name,
            symbol
        );
    }
    
    function encodeTokenIdentifierStorage(
        TokenIdentifierStorage storage self
    )internal view returns(
        bytes memory
    ){
        return abi.encodePacked(
            keccak256(
                abi.encodePacked(
                    _TOKEN_ID_TYPE_HASH,
                    self.name,
                    self.symbol
                )
            ),
            _TOKEN_ID_TYPE_HASH,
            self.name,
            self.symbol
        );
    }
    function encodeTokenIdentifierMemory(
        TokenIdentifierStorage memory self
    )internal pure returns(
        bytes memory
    ){
        return abi.encodePacked(
            keccak256(
                abi.encodePacked(
                    _TOKEN_ID_TYPE_HASH,
                    self.name,
                    self.symbol
                )
            ),
            _TOKEN_ID_TYPE_HASH,
            self.name,
            self.symbol
        );
    }
    //
    //decoding functions
    //
    function decodeTokenIdentifier(
        bytes memory data
    )internal pure returns(
        //uint256 chainId,
        string memory name,
        string memory symbol
    ){
        bytes32 dataHash;
        bytes32 typedHash;

        (
            dataHash,
            typedHash,
            //chainId,
            name,
            symbol
        ) = abi.decode(
            data,
            (bytes32, bytes32, string, string)
        );
        
        typedHash.requireEqual(_TOKEN_ID_TYPE_HASH);
        dataHash.requireEqual(
            keccak256(
                abi.encodePacked(
                    _TOKEN_ID_TYPE_HASH,
                    //_chainId(),
                    name,
                    symbol
                )
            )
        );
    }
    /*
    function decodeTokenIdentifier(
        bytes memory data
    )internal pure returns(
        //uint256 chainId,
        string memory name,
        string memory symbol,
        bytes memory extraData
    ){
        bytes32 dataHash;
        bytes32 typedHash;

        (
            dataHash,
            typedHash,
            //chainId,
            name,
            symbol,
            extraData
        ) = abi.decode(
            data,
            (bytes32, bytes32, string, string,bytes)
        );
        
        typedHash.requireEqual(_TOKEN_ID_TYPE_HASH);
        dataHash.requireEqual(
            keccak256(
                abi.encodePacked(
                    _TOKEN_ID_TYPE_HASH,
                    //_chainId(),
                    name,
                    symbol
                    //extraData
                )
            )
        );
    }
    */
    function decodeTokenIdentifierMemory(
        bytes memory data
    )internal pure returns(
        TokenIdentifierStorage memory tokenId
    ){
        bytes32 dataHash;
        bytes32 typedHash;
        //
        string memory newName;
        string memory newSymbol;
        //
        //
        (
            dataHash,
            typedHash,
            //chainId,
            newName,
            newSymbol
        ) = abi.decode(
            data,
            (bytes32, bytes32, string, string)
        );
        //
        typedHash.requireEqual(_TOKEN_ID_TYPE_HASH);
        dataHash.requireEqual(
            keccak256(
                abi.encodePacked(
                    _TOKEN_ID_TYPE_HASH,
                    //_chainId(),
                    newName,
                    newSymbol
                )
            )
        );
        //
        tokenId = TokenIdentifierStorage({
            name:newName,
            symbol:newSymbol
        });
    }
    /*
    function decodeTokenIdentifierStorage(
        bytes memory data
    )internal pure returns(
        TokenIdentifierStorage storage tokenId
    ){
        bytes32 dataHash;
        bytes32 typedHash;

        (
            dataHash,
            typedHash,
            //chainId,
            name,
            symbol
        ) = abi.decode(
            data,
            (bytes32, bytes32, string, string)
        );
        
        typedHash.requireEqual(_TOKEN_ID_TYPE_HASH);
        dataHash.requireEqual(
            keccak256(
                abi.encodePacked(
                    _TOKEN_ID_TYPE_HASH,
                    //_chainId(),
                    name,
                    symbol
                )
            )
        );
    }
    */
    /*
    function decodeTokenIdentifierMemory(
        bytes memory data
    )internal pure returns(
        TokenIdentifierStorage memory tokenId,
        bytes memory extraData
    ){
        bytes32 dataHash;
        bytes32 typedHash;
        //
        string memory newName;
        string memory newSymbol;
        //
        //
        (
            dataHash,
            typedHash,
            //chainId,
            newName,
            newSymbol,
            extraData
        ) = abi.decode(
            data,
            (bytes32, bytes32, string, string,bytes)
        );
        //
        typedHash.requireEqual(_TOKEN_ID_TYPE_HASH);
        dataHash.requireEqual(
            keccak256(
                abi.encodePacked(
                    _TOKEN_ID_TYPE_HASH,
                    //_chainId(),
                    newName,
                    newSymbol
                    //extraData
                )
            )
        );
        //
        tokenId = TokenIdentifierStorage({
            name:newName,
            symbol:newSymbol
        });
    }
    */
    ///
    ///getters
    ///
    function name(
    )internal view returns(
        string memory
    ){
        return storageTokenIdentifier().name;
    }
    function symbol(
    )internal view returns(
        string memory
    ){
        return storageTokenIdentifier().symbol;
    }
    ///
    ///setters
    ///
    function setName(
        string memory newName
    )internal
    {
        newName.requireNotEmpty();
        
        TokenIdentifierStorage storage  s = storageTokenIdentifier();   //(slot).name;
        
        s.name.requireNotEqual(newName);

        s.name = newName;
    }
    function setSymbol(
        string memory newSymbol
    )internal
    {
        newSymbol.requireNotEmpty();
        
        TokenIdentifierStorage storage s = storageTokenIdentifier();    //slot);
        
        s.symbol.requireNotEqual(newSymbol);
        s.symbol = newSymbol;
    }
    
    function initialize(
        //bytes32 slot,
        string memory newName,
        string memory newSymbol
    )internal
    {
        _requireNotInitialized();
        //_requireSymbolLength(newSymbol);
        
        setName(newName);
        setSymbol(newSymbol);
    }
    function initializeBytes(
        //bytes32 slot,
        bytes memory data
    )internal
    {
        _requireNotInitialized();

        string memory newName;
        string memory newSymbol;
        
        (
            newName,
            newSymbol
            
        ) = decodeTokenIdentifier(data);
        
        setName(newName);
        setSymbol(newSymbol);
    }
    function initializeMemory(
        //bytes32 slot,
        TokenIdentifierStorage memory tokenId
    )internal
    {
        _requireNotInitialized();

        tokenId.name.requireEmpty();
        tokenId.symbol.requireEmpty();
        //_requireSymbolLength(symbol);
        
        setName(tokenId.name);
        setSymbol(tokenId.symbol);
    }
    function dealloc(
        //bytes32 slot
    )internal
    {
        _requireInitialized();

        TokenIdentifierStorage storage s = storageTokenIdentifier();
        
        delete s.name;
        delete s.symbol;
    }
}