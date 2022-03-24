// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/ERC173/mixinERC173.sol";

interface iERC173View
{
    /// @return {address} current owner of this contract
    function owner(
    )external view returns(
        address
    );
    //function ownerPayable(
    //)external view returns(
        //address payable
    //);
}
///
/// @title ERC-173 compliant Ownership View Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/3/2022, All Rights Reserved
/// 
/// @dev read-only internal and private members for ERC-173 derived contracts
///
abstract contract ERC173ViewABC is iERC173View
{
    using addressConstraints for address;
    
    using mixinERC173 for bytes32;
    
    string private constant _NAME = ' - ERC173: ';
    
    //bytes32 private constant _NAMESPACE = bytes32(uint256(
        //keccak256("solidarity.eip.")
    //) - 1);
    //
    //bytes32 private constant _STORAGE_SLOT = _NAMESPACE ^ bytes32(uint256(
        //keccak256("eip173Ownable.STORAGE_SLOT")
    //) - 1);
    
    string private constant _ERR_OWNER_IS_NULL = string(
        abi.encodePacked(
            _NAME,
            "owner is NULL"
        )
    );
    
    string private constant _ERR_OWNER_NOT_NULL = string(
        abi.encodePacked(
            _NAME,
            "owner is not NULL"
        )
    );
    
    bytes32 private _storageSlotERC173;
    
    /// @dev Initializes the contract setting the deployer as the initial owner
    constructor(
        bytes32 storageSlot
    )internal
        //ContractConstraintsABC()
    {
        _storageSlotERC173 = storageSlot;
        
        //_storageSlotERC173.set(_msgSender());
        _storageSlotERC173.transferOwnership(_msgSender());
    }
    /// @dev reverts if called by any account other than owner
    //modifier _senderIsOwner(){
    modifier onlyOwner(){
        _storageSlotERC173.requireOwner(_msgSender());
        
        _;
    }
    /// @dev modified function reverts if called by any account that is the owner
    //modifier _senderNotOwner(){
        //_requireNotOwner(_msgSender());
        //
        //_;
    //}
    ///modifier to allow only a specific address to execute a contract's function
    ///modifier onlyAddress(
        //address account
    //){
        //account.requireNotNull(
            ////_NAME.concatenate("onlyOwner, owner can not be NULL")
        //);
        //account.requireEqual(
            //_msgSender()
            ////_NAME.concatenate("onlyOwner, caller is not owner")
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
            _storageSlotERC173.owner()
        );
    }
    function _requireOwnerNull(
    )internal view
    {
        //_storageSlotERC173.requireOwnerIsNull();
        _storageSlotERC173.owner().requireIsNull(
        );
    }
    function _requireOwnerNotNull(
    )internal view
    {
        //_storageSlotERC173.requireOwnerNotNull();
        _storageSlotERC173.owner().requireNotNull(
        );
    }
    function _requireOwnerNotSelf(
    )internal view
    {
        _requireNotOwner(address(this));
    }
    //require this contract to own itself
    //function _requireOwnerSelf(
    //)internal view
    //{
        //_requireOwner(address(this));
    //}
    /// @return {address} current owner of this contract
    function owner(
    )public view override returns(
        address
    ){
        return _storageSlotERC173.owner();
    }
    function _ownerPayable(
    )internal view returns(
        address payable
    ){
        return _storageSlotERC173.ownerPayable();
    }
}