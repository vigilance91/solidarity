// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";
///
/// @title mixinERC20
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev {ERC20} mixin implementation
///
library mixinERC20
{
    //using addressConstraints for address;
    //using uint256Constraints for uint256;
    
    using SafeMath for uint256;
    
    struct ERC20Storage{
        mapping(address=>uint256) balances;
        mapping(address=>mapping(address=>uint256)) allowances;
        
        uint8 decimals;
        // notice totalSupply, name and symbol are similar to EIP-1753!
        // notice name and symbol are similar to ERC-721!
        //uint256 totalSupply;
        //string name;
        //string symbol;
    }
    
    bytes32 internal constant STORAGE_SLOT = keccak256("solidarity.ERC-20.mixin.STORAGE_SLOT");
    
    function storageERC20(
        //bytes32 slot
    )internal pure returns(
        ERC20Storage storage ret
    ){
        bytes32 position = STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
    ///
    ///getters
    ///
    function balances(
        //bytes32 slot
    )internal view returns(
        mapping(address=>uint256) storage
    ){
        return storageERC20().balances;
    }
    function allowances(
        //bytes32 slot
    )internal view returns(
        mapping(address=>mapping(address=>uint256)) storage
    ){
        return storageERC20().allowances;
    }
    function balanceOf(
        //bytes32 slot,
        address account
    )internal view returns(
        uint256
    ){
        return balances()[account];
    }
    function allowancesAt(
        //bytes32 slot,
        address account
    )internal view returns(
        mapping(address=>uint256) storage
    ){
        //account.requireNotNull();
        
        return allowances()[account];
    }
    function allowanceFor(
        //bytes32 slot,
        address account,
        address spender
    )internal view returns(
        uint256
    ){
        //account.requireNotNullAndNotEqual(spender);
        
        return allowances()[account][spender];
    }
    
    //function name(
    //)internal view returns(
        //string memory
    //){
        //return storageERC20().name;
    //}
    //function symbol(
    //)internal view returns(
        //string memory
    //){
        //return storageERC20().symbol;
    //}
    //function totalSupply(
    //)internal view returns(
        //uint256
    //){
        //return storageERC20().totalSupply;
    //}
    function decimals(
        //bytes32 slot
    )internal view returns(
        uint8
    ){
        return storageERC20().decimals;
    }
    ///
    ///setters
    ///
    function setBalanceOf(
        //bytes32 slot,
        address account,
        uint256 newBalance
    )internal
    {
        //account.requireNotNull();
        
        //newBalance.requireNotEqual(
            //balances()[account]
        //);
        
        balances()[account] = newBalance;
    }
    function increaseBalanceOf(
        //bytes32 slot,
        address account,
        uint256 amountBy
    )internal
    {
        setBalanceOf(
            account,
            balanceOf(account).add(
                amountBy
            )
        );
        //return balanceOf(account);
    }
    function decreaseBalanceOf(
        //bytes32 slot,
        address account,
        uint256 amountBy
    )internal
    {
        setBalanceOf(
            account,
            balanceOf(account).sub(
                amountBy
            )
        );
        //return balanceOf(account);
    }
    function setAllowanceFor(
        //bytes32 slot,
        address owner,
        address spender,
        uint256 newAllowance
    )internal
    {
        //owner.requireNotNullAndNotEqual(spender);
        
        //mapping storage a = allowances()[owner];
        
        //a[spender].requireNotEqual(newAllowance);
        
        allowances()[owner][spender] = newAllowance;
    }
    /**
    function increaseAllowanceFor(
        address owner,
        address spender,
        uint256 amountBy
    )internal
    {
        setAllowanceFor(
            owner,
            spender,
            allowanceFor(
                owner,
                spender
            ).add(
                amountBy
            )
        );
        //return allowanceFor(
            //owner,
            //spender
        //);
    }
    function decreaseAllowanceFor(
        address owner,
        address spender,
        uint256 amountBy
    )internal
    {
        setAllowanceFor(
            owner,
            spender,
            allowanceFor(
                owner,
                spender
            ).sub(
                amountBy
            )
        );
        //return balanceAt(account);
    }
    */
    //function setName(
        //string memory newName
    //)internal
    //{
        //storageERC20().name = newName;
    //}
    //function setSymbol(
        //string memory newSymbol
    //)internal
    //{
        //storageERC20().symbol = newSymbol;
    //}
    //function setTotalSupply(
        //uint256 newTotalSupply
    //)internal
    //{
        //storageERC20().totalSupply = newTotalSupply;
    //}
    /**
    function increaseTotalSupply(
        uint256 amountBy
    )internal returns(
        uint256
    ){
        setTotalSupply(
            totalSupply().add(
                amountBy
            )
        );
        
        return storageERC20().totalSupply;
    }
    function decreaseTotalSupply(
        uint256 amountBy
    )internal returns(
        uint256
    ){
        setTotalSupply(
            totalSupply().sub(
                amountBy
            )
        );
        
        return storageERC20().totalSupply;
    }
    */
    function setDecimals(
        //bytes32 slot,
        uint8 newDecimals
    )internal
    {
        storageERC20().decimals = newDecimals;
    }
    function initialize(
        //bytes32 slot,
        //string memory newName,
        //string memory newSymbol,
        uint8 newDecimals
    )internal
    {
        //_requireNotInitialized(slot);
        
        //setName(newName);
        //setSymbol(newSymbol);
        //setTotalSupply(0);
        setDecimals(newDecimals);
        
        //setBalanceAt(msg.sender, 0);
    }
    
    //function reset(
        //bytes32 slot
    //)internal
    //{
        //_requireInitialized(slot);
        //
        //ERC20Storage storage cs = storageERC20(slot);
        
        //setName(newName);
        //setSymbol(newSymbol);
        //setTotalSupply(0);
        //setDecimals(newDecimals);
    //}
    //function remove(
        //bytes32 slot
    //)internal
    //{
        //_requireInitialized();
        //
        //ERC20Storage storage s = storageERC20(slot);
        //
        //delete s.balances;
        //delete s.allowances;
        //
        //delete s.decimals;
    //}
    
    //transfer state from storage slot `from` to storage slot `to`,
    //removing the previous state of storage slot `from`
    //function transferStateERC20(
        //bytes32 from,
        //bytes32 to
    //)internal
    //{
        //_requireInitialized(from);
        
        //initialize(to, storageERC20(from));
        
        //remove(from);
    //}
    
    //transfer without removing the previous state at storage slot `from`
    //function copyStateERC20(
        //bytes32 from,
        //bytes32 to
    //)internal
    //{
        //_requireInitialized(from);
        
        //reset(to, storageERC20(from));
    //}
    
    ////function swapStateERC20(
        ////bytes32 lhs,
        ////bytes32 rhs
    ////)internal
    ////{
        //ERC20Storage storage sl = storageERC20(lhs);
        //ERC20Storage storage sr = storageERC20(rhs);
        
        //reset(
            //lhs,
            //sr
        //);
        //reset(
            //rhs,
            //sl
        //);
    ////}
}