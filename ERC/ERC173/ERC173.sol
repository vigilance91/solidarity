// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/ERC173/iERC173.sol";
import "https://github.com/vigilance91/solidarity/ERC/ERC173/mixinERC173.sol";
///
/// @title ERC-173 compliant Ownership contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/3/2021, All Rights Reserved
/// 
/// @dev Contract providing access control mechanism to an exclusive an account with access to specific functions
/// The owning account is the deployers of the contract by default,
/// which can change by calling {transferOwnership}
///
abstract contract ERC173 is Context,
    iERC173
{
    using AddressConstraints for address;
    
    //string private constant _CONTRACT_NAME = ' ERC173: ';
    
    /// @dev Initializes the contract setting the deployer as the initial owner
    constructor(
    )internal Context()
    {
        mixinERC173.transferOwnership(_msgSender());
    }
    /// @dev reverts if called by any account other than owner
    modifier onlyOwner(){
        mixinERC173.requireOwner(_msgSender());
        _;
    }
    ///modifier to allow only a specific address to execute a contract's function
    ///modifier onlyAddress(
        //address account
    //){
        //account.requireNotNull(
            ////_CONTRACT_NAME.concatenate("onlyOwner, owner can not be NULL")
        //);
        //account.requireEqual(
            //_msgSender()
            ////_CONTRACT_NAME.concatenate("onlyOwner, caller is not owner")
        //);
        //_;
    //}
    function _requireNotThis(
        address account
    )internal view
    {
        //account.requireNotNull();
        account.requireNotEqual(
            address(this)
        );
    }
    function _requireNotOwner(
        address account
    )internal view
    {
        //account.requireNotNull();
        account.requireNotEqual(
            owner()
        );
    }
    function _requireOwnerNull(
    )internal view
    {
        owner().requireIsNull(
            //_CONTRACT_NAME.concatenate('')
        );
    }
    function _requireOwnerNotNull(
    )internal view
    {
        owner().requireNotNull(
            //_CONTRACT_NAME.concatenate('')
        );
    }
    function _requireOwnerNotSelf(
    )internal view
    {
        _requireNotOwner(address(this));
    }
    /// @dev Returns the address of the current owner.
    function owner(
    )public view override returns(
        address
    ){
        return mixinERC173.owner();
    }
    function ownerPayable(
    )public view returns(
        address payable
    ){
        return mixinERC173.ownerPayable();
    }
    ///
    /// @dev Leaves the contract without owner. It will not be possible to call
    /// `onlyOwner` functions anymore. Can only be called by the current owner.
    ///
    /// NOTE: Renouncing ownership will leave the contract without an owner,
    /// thereby removing any functionality that is only available to the owner.
    function renounceOwnership(
    )external virtual override onlyOwner
    {
        mixinERC173.renounceOwnership();
    }
    ///
    /// @dev Transfer ownership of this contract to a new address (`newOwner`),
    /// can only be called by the current owner
    /// NOTICE newOwner can be either a wallet address OR a contract
    /// if newOwner is a contract which does NOT support ERC173 and/or
    /// is NOT programmed to transfer ownership, ownership is lost forever!
    ///
    function transferOwnership(
        address newOwner
    )external virtual override onlyOwner
    {
        newOwner.requireNotNull(
            //_CONTRACT_NAME.concatenate("transferOwnership")
        );
        //new owner can not be current owner
        _requireNotOwner(newOwner);
        //contract can not own itself
        _requireNotThis(newOwner);
        
        mixinERC173.transferOwnership(newOwner);
    }
}