// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/contracts/allowance/eventsAllowance.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";
///
/// @title mixinAllowance
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev Allowance mixin implementation
///
library mixinAllowance
{
    using SafeMath for uint256;
    using eventsAllowance for address;
    //using stringUtilities for string;
    
    //using EnumerableMap for EnumerableMap.Map;
    
    struct AllowanceStorage{
        mapping(address=>mapping(address=>uint256)) allowances;
        //mapping(address=>mapping(address=>EnumerableMap.Map)) nonces;
    }
    
    bytes32 internal constant STORAGE_SLOT = keccak256("VSN.allownace.mixin.storage");
    //string internal constant _NAME = ' mixinAllownace: ';
    //string internal constant ... = _NAME.concatenate('owner can not be spender');
    
    function storageAllowance(
    )internal pure returns(
        AllowanceStorage storage ret
    ){
        bytes32 position = STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
    ///
    ///getters
    ///
    function allowances(
    )internal view returns(
        mapping(address=>mapping(address=>uint256)) storage
    ){
        return storageAllowance().allowances;
    }
    //function nonces(
    //)internal view returns(
        //mapping(address=>mapping(address=>EnumerableMap.Map)) storage
    //){
        //return storageAllowance().nonces;
    //}
    function allowancesAt(
        address account
    )internal view returns(
        mapping(address=>uint256) storage
    ){
        account.requireNotNull();
        
        return allowances()[account];
    }
    //function noncesAt(
        //address owner
    //)internal view returns(
        //EnumerableMap storage //mapping(address=>bytes32[]) storage
    //){
        //owner.requireNotNull();
        //
        //return nonces()[owner];
    //}
    function allowanceFor(
        address owner,
        address spender
    )internal view returns(
        uint256
    ){
        owner.requireNotNullAndNotEqual(
            spender
        );
        
        return allowances()[owner][spender];
    }
    /**
    function currentNonceFor(
        address owner,
        address spender
    )internal view returns(
        bytes32
    ){
        owner.requireNotNullAndNotEqual(spender);
        
        bytes32[] memory N = nonces()[owner][spender];
        
        return N[N.length.sub(1)];
    }
    function nonceCount(
        address owner,
        address spender
    )internal view returns(
        uint256
    ){
        return noncesAt(owner,spender).length;
    }
    function nonceAlreadyUsed(
        address owner,
        address spender
    )internal view returns(
        bool
    ){
        //bytes32[] memory N = nonces()[owner][spender];
        //
        //return N[N.length.sub(1)];
        
        //bytes32 nonce = owner.hexadecimal().saltAndHash(
            //spender.hexadecimal().concatenate(
                //nonceCount(owner, spender).add(1).hexadecimal()
            //)
        //);
        //
        //return nonce()[owner][spender].contains(nonce) == true;
    }
    */
    ///
    ///setters
    ///
    /**
    function incrementNonce(
        address owner,
        address spender
    )internal
    {
        nonces()[owner][spender].push(
            owner.hexadecimal().saltAndHash(
                spender.hexadecimal().concatenate(
                    nonceCount(owner, spender).add(1).hexadecimal()
                )
            )
        );
    }
    */
    function setAllowanceFor(
        address owner,
        address spender,
        uint256 newAllowance
    )internal
    {
        //requireNonce... 
        
        //prevent redundant setting of allowance
        allowanceFor(owner,spender).requireNotEqual(
            newAllowance
            //_NAME.concatenate('allowance already set to amount')
        );
        
        allowances()[owner][spender] = newAllowance;
        
        //incrementNonce(owner,spender);
    }
    /// @dev spender must have no allowance (an allowance of 0) to approve
    function approve(
        address owner,
        address spender,
        uint256 amount
    )internal
    {
        //cannot approve an allowance if one is already set
        allowanceFor(owner,spender).requireEqual(0);
        
        setAllowanceFor(
            owner,
            spender,
            amount
        );
        //assert(allowanceFor(owner,spender) == amount);
        owner.emitApproveAllowance(
            spender,
            amount
        );
    }
    /// @dev spender must have a non-zero allowance to revoke
    function revoke(
        address owner,
        address spender
    )internal
    {
        uint256 A = allowanceFor(owner,spender);
        
        A.requireGreaterThanZero();
        //cannot revoke allowance if none is set
        setAllowanceFor(
            owner,
            spender,
            0
        );
        //assert(allowanceFor(owner,spender) == 0);
        owner.emitRevokeAllowance(
            spender,
            A
        );
    }
    //for internal use only, to increase an allowance externally,
    //it is recommended to first revoke the previous allowance
    //and then approve the new desired allowance in order to prevent double spend attacks
    function increaseAllowance(
        address owner,
        address spender,
        uint256 amountBy
    )internal returns(
        uint256 newAllowance
    ){
        uint256 PA = allowanceFor(owner,spender);
        //cannot increase allowance if none is set,
        //call approve before increase allowance
        PA.requireGreaterThanZero(
            //_NAME.concatenate('spender does not have an allowance')
        );
        
        newAllowance = PA.add(
            amountBy
        );
        
        setAllowanceFor(
            owner,
            spender,
            newAllowance
        );
        //assert(NA > PA);
    }
    //for internal use only, to decrease an allowance externally,
    //it is recommended to first revoke the previous allowance
    //and then approve the new desired allowance in order to prevent double spend attacks
    function decreaseAllowance(
        address owner,
        address spender,
        uint256 amountBy
    )internal returns(
        uint256 newAllowance
    ){
        uint256 PA = allowanceFor(owner,spender);
        //cannot increase allowance if none is set,
        //call approve before increase allowance
        PA.requireGreaterThanZero(
            //_NAME.concatenate('spender does not have an allowance')
        );
        
        newAllowance = PA.sub(
            amountBy
        );
        
        setAllowanceFor(
            owner,
            spender,
            newAllowance
        );
        //assert(NA < PA);
    }
}