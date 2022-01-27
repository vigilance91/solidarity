// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Token Identifier Mixin Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev token identifier mixin, for composing tokens
/// 
library mixinTokenIdentifier
{
    struct TokenIdentifierStorage{
        string name;
        string symbol;
    }
    
    bytes32 internal constant STORAGE_SLOT = keccak256("solidarity.tokenIdentifier.mixin.storage");
    
    function storageTokenIdentifier(
    )internal pure returns(
        TokenIdentifierStorage storage ret
    ){
        bytes32 position = STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
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
        //newName().requireNotEmpty();
        storageTokenIdentifier().name = newName;
    }
    function setSymbol(
        string memory newSymbol
    )internal
    {
        //newSymbol.requireNotEmpty();
        storageTokenIdentifier().symbol = newSymbol;
    }
    function initialize(
        string memory newName,
        string memory newSymbol
    )internal
    {
        //name().requireNotEmpty();
        //symbol().requireNotEmpty();
        //_requireSymbolLength(symbol);
        
        setName(newName);
        setSymbol(newSymbol);
    }
}