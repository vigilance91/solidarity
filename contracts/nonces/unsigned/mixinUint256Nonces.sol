// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256ToString.sol";

import "https://github.com/vigilance91/solidarity/libraries/string/stringUtilities.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Counters.sol";
///
/// @title Mixin Uint256 Nonces Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 6/12/2021, All Rights Reserved
/// @dev mixin library providing storage and functions for using unique, uint256 specific nonces
///
library mixinUint256Nonces
{
    using Counters for Counters.Counter;
    
    using uint256Constraints for uint256;
    using uint256ToString for uint256;
    
    using stringUtilities for string;
    
    //bytes32 internal constant STORAGE_SLOT = keccak256("solidarity.mixin.HASHED_NONCES");
    
    struct NonceStorage{
        mapping(uint256=>Counters.Counter) nonces;
    }
    
    function _storageNonces(
        bytes32 slot
    )private pure returns(
        NonceStorage storage ret
    ){  
        assembly {
            ret_slot := slot
        }
    }
    
    function currentNonce(
        bytes32 slot,
        uint256 key
    )internal view returns(
        uint256
    ){
        //account.requireNotNull();
        return uint256(
            nonces(slot)[key].current().hexadecimal().hash()
        );
    }
    //
    //function currentNonceHash(
        //bytes32 slot,
        //uint256 key
    //)internal view returns(
        //bytes32
    //){
        //return nonces(slot)[key].current().hexadecimal().hash();
    //}
    
    function nonces(
        bytes32 slot
    )internal view returns(
        mapping(uint256=>Counters.Counter) storage
    ){
        return _storageNonces(slot).nonces; //[account].nonces;
    }
    
    //function _nonceAt(
        //address account
    //)internal view returns(
        //Counters.Counter storage
    //){
        //return nonces()[account];
    //}
    
    function increment(
        bytes32 slot
        uint256 key
    )internal
    {
        //if(_storageNonces(slot).nonces[key] ==){
            //_storageNonces(slot).nonces[key] = 0;
            //return;
        //}
        
        _storageNonces(slot).nonces[key].increment();
    }
    
    function _asHexAndSalt(
        bytes32 slot,
        uint256 key
    )internal view returns(
        string memory
    ){
        return key.hexadecimal().concatenate(
            currentNonce(slot, key).hexadecimal()
        );
    }
    //function _asHexSaltAndHash(
        //uint256 hash
    //)internal view returns(
        //bytes32
    //){
        //return keccak256(bytes(
            //hash.hexadecimal().concatenate(
                //currentNonce(hash).hexadecimal()
            //)
        //);
    //}
}