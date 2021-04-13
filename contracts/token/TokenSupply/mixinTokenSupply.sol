// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Contraints.sol";
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
    
    uinsg uint256Contraints for uint256;
    
    using eventsTokenSupply for uint256;
    
    struct TokenSupplyStorage{
        uint256 totalSupply;
    }
    
    bytes32 internal constant STORAGE_SLOT = keccak256("solidarity.tokenSupply.mixin.storage");
    
    function storageTokenSupply(
    )internal pure returns(
        TokenSupplyStorage storage ret
    ){
        bytes32 position = STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
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
        
        previousSupply.emitSetSupply(newSupply);
        
        return newSupply;
    }
    
    function increaseTotalSupply(
        uint256 amountBy
    )internal
    {
        amountBy.requireGreaterThanZero();
        uint256 previousSupply = totalSupply();
        
        uint256 newSupply = setTotalSupply(
            previousSupply.add(
                amountBy
            )
        );
        
        assert(previousSupply < newSupply);
        
        previousSupply.emitIncreaseSupply(amountBy, newSupply);
        
        //return newSupply;
    }
    function decreaseTotalSupply(
        uint256 amountBy
    )internal
    {
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
        
        previousSupply.emitDecreaseSupply(amountBy, newSupply);
        //return newSupply;
    }
    
    function initializeZero(
    )internal
    {
        setTotalSupply(0);
        //storageTokenSupply().totalSupply = 0;
    }
    function initialize(
        uint256 newSupply
    )internal
    {
        //newSupply().requireGreaterThanZero();
        setTotalSupply(newSupply);
    }
}