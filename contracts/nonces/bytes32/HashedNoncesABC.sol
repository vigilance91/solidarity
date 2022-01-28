// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/nonces/mixinHashedNonces.sol";
///
/// @title Hashed Nonces Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 7/5/2021, All Rights Reserved
/// @dev provides the derived implementation with account based nonces and the corresponding internal operations
///
abstract contract HashedNoncesABC
{
    using mixinHashedNonces for bytes32;
    
    using bytes32ToString for bytes32;
    using uint256ToString for uint256;
    
    using stringUtilities for string;
    
    bytes32 internal constant _STORAGE_SLOT = keccak256("solidarity.HASHED_NONCES_ABC");
    
    constructor(
    )internal{
    }
    function _currentNonce(
        bytes32 hash
    )internal view returns(
        uint256
    ){
        return _STORAGE_SLOT.currentNonce(hash);
    }
    function _nonces(
    )internal view returns(
        mapping(bytes32=>Counters.Counter) storage
    ){
        return _STORAGE_SLOT.nonces(); //[account].nonces;
    }
    
    function _incrementNonce(
        bytes32 hash
    )internal
    {
        return _STORAGE_SLOT.increment(hash);
    }
    
    //function _decrementNonce(
        //address account
    //)internal
    //{
        //return mixinNonces.decrement(account);
    //}
    
    function _asHexAndSalt(
        bytes32 hash
    )internal view returns(
        string memory
    ){
        return _STORAGE_SLOT.asHexAndSalt(hash);
    }
    
    //function _hashNonceHash(
        //bytes32 hash
    //)internal view returns(
        //bytes32
    //){
        //return keccak256(
            //bytes(_asHexAndSalt(account))
        //);
    //}
}