// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Constraints.sol";

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256ToString.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/addressToString.sol";
import "https://github.com/vigilance91/solidarity/libraries/string/stringUtilities.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Counters.sol";
///
/// @title Mixin Nonces Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 7/5/2021, All Rights Reserved
/// @dev mixin library providing storage and functions for using unique, address specific nonces,
/// typically used in `permit` style functions, meta-transactions/signed messages and to prevent double-pay/replay attacks
///
library mixinNonces
{
    using Counters for Counters.Counter;
    using AddressConstraints for address;
    
    using addressToString for address;
    using uint256ToString for uint256;
    
    using stringUtilities for string;
    
    bytes32 internal constant STORAGE_SLOT = keccak256("solidarity.mixin.nonces");
    
    struct NonceStorage{
        mapping(address=>Counters.Counter) nonces;
    }
    
    function storageNonces(
    )private pure returns(
        NonceStorage storage ret
    ){
        bytes32 position = STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
    
    function currentNonce(
        address account
    )internal view returns(
        uint256
    ){
        account.requireNotNull();
        
        return uint256(
            nonces()[account].current().hexadecimal().hash()
        );
    }
    
    function nonces(
    )internal view returns(
        mapping(address=>Counters.Counter) storage
    ){
        return storageNonces().nonces; //[account].nonces;
    }
    
    //function _nonceAt(
        //address account
    //)internal view returns(
        //Counters.Counter storage
    //){
        //return nonces()[account];
    //}
    
    function increment(
        address account
    )internal
    {
        account.requireNotNull();
        
        storageNonces().nonces[account].increment();
    }
    
    function _asHexAndSalt(
        address account
    )internal view returns(
        string memory
    ){
        return account.hexadecimal().concatenate(
            currentNonce(account).hexadecimal()
        );
    }
}