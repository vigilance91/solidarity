// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/nonces/mixinUint256Nonces.sol";
///
/// @title Uint256 Nonces Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 7/5/2021, All Rights Reserved
/// @dev provides the derived implementation with account based nonces and the corresponding internal operations
///
abstract contract Uint256NoncesABC
{
    using mixinUint256Nonces for bytes32;
    
    using uint256ToString for uint256;
    
    using stringUtilities for string;
    
    bytes32 internal constant _STORAGE_SLOT = keccak256("solidarity.UINT256_NONCES_ABC");
    
    constructor(
    )internal{
    }
    function _currentNonce(
        uint256 key
    )internal view returns(
        uint256
    ){
        return _STORAGE_SLOT.currentNonce(hash);
    }
    function _nonces(
    )internal view returns(
        mapping(uint256=>Counters.Counter) storage
    ){
        return _STORAGE_SLOT.nonces(); //[account].nonces;
    }
    
    function _incrementNonce(
        uint256 key
    )internal
    {
        _STORAGE_SLOT.increment(key);
    }
    
    //function _decrementNonce(
        //uint256 key
    //)internal
    //{
        //_STORAGE_SLOT.decrement(key);
    //}
    
    function _asHexAndSalt(
        uint256 key
    )internal view returns(
        string memory
    ){
        return _STORAGE_SLOT.asHexAndSalt(key);
    }
    
    //function _keyNonceHash(
        //uint256 key
    //)internal view returns(
        //bytes32
    //){
        //return keccak256(
            //bytes(_asHexAndSalt(key))
        //);
    //}
}