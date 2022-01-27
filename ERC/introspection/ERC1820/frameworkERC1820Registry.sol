// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "./iERC1820Registry.sol";
import "./iERC1820Implementer.sol";

//interface iERC1820... is iERC165,
//    iERC1820Implementer,
//    iERC1820Registry
//{
//}
///
/// @dev {frameworkERC1820Registry} ERC1820 Registry framework
///
library frameworkERC1820Registry
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    //function castERC1820
        //address registry
    //)internal pure returns(
        //iERC1820
    //){
        //_requireSupportsInterface1820(registry);
        //
        //return iERC1820(registry);
    //}
    //function thisCastERC1820(
    //)internal pure returns(
        //iERC1820
    //){
        //return castERC1820(
            //address(this)
        //);
    //}
    /*
    /// @return {address} the manager for `account`
    /// See {setManager}
    ///
    function hasRoleManager(
        address target,
        address account
    )internal view returns(
        address
    ){
        return iERC1820Registry(target).hasRole(ROLE_MANAGER, account);
    }
    function hasRoleAdmin(
        address account
    )internal view
    {
        return iERC1820Registry(target).hasRoleAdmin(account);
    }
    function _hasRoleAdminOrManager(
        address account
    )internal view
    {
        return iERC1820Registry(target).hasRoleAdminOrManager(account);
    }
    */
    string private constant _NAME = ' frameworkERC1820Registry: ';
    
    bytes4 private constant _iERC1820_IMPLEMENTER_ID = type(iERC1820Implementer).interfaceId;
    bytes4 private constant _iERC1820_REGISTRY_ID = type(iERC1820Registry).interfaceId;
    
    //bytes4 private constant _iERC1820_IMPLEMENTER_NAME_HASH = keccak256(type(iERC1820Implementer).name);
    //bytes4 private constant _iERC1820_REGISTRY_NAME_HASH = keccak256(type(iERC1820Registry).name);
    
    function _requireSupportsInterface(
        address target
    )private
    {
        target.requireNotNull();
        target.isContract().requireTrue(
            'address not a contract'
        );
        
        target.supportsInterface(_iERC1820_REGISTRY_ID).requireTrue(
            'contract does not implement iERC1820Registry'
        );
    }
    //function _supportsInterface(
        //address target
    //)private
        //(supportsERC1820RegistryInterfaceERC1820(target) || supportsERC1820RegistryInterfaceERC165(target));
    //}
    
    //function _requireSupportsInterface(
        //address target
    //)private
        //_supportsInterface(target).requireTrue(
            //'iERC1820 not supported'
        //);
    //}
    /**
    function _requireSupportsERC1820RegistryInterface(
        address target
    )private
    {
        target.requireNotNull();
        target.isContract().requireTrue(
            'address not a contract'
        );
        
        target.supportsInterface(_iERC1820_IDENTIFIER_ID).requireTrue(
            'contract does not implement iERC1820'
        );
    }
    */
    ///
    /// @dev Sets `newManager` as the manager for `account`. A manager of an
    /// account is able to set interface implementers for it.
    ///
    /// By default, each account is its own manager. Passing a value of `0x0` in
    /// `newManager` will reset the manager to this initial state.
    ///
    /// Emits a {ManagerChanged} event.
    ///
    /// Requirements:
    ///     - the caller must be the current manager for `account`
    ///
    function setManager(
        address target,
        address account,
        address newManager
    )internal
    {
        iERC1820Registry(target).setManager(account, newManager);
    }
    ///
    /// @return {address} the manager for `account`
    /// See {setManager}
    ///
    function getManager(
        address target,
        address account
    )internal view returns(
        address
    ){
        return iERC1820Registry(target).getManager(account);
    }
    ///
    /// @dev Sets the `implementer` contract as ``account``'s implementer for `interfaceHash`
    ///
    /// `account` being the zero address is an alias for the caller's address.
    /// The zero address can also be used in `implementer` to remove an old one.
    ///
    /// See {interfaceHash} to learn how these are created.
    ///
    /// Emits an {InterfaceImplementerSet} event.
    ///
    /// Requirements:
    ///     - the caller must be the current manager for `account`.
    ///     - `interfaceHash` must not be an {iERC165} interface id (i.e. it must not end in 28 zeroes)
    ///     - `implementer` must implement {IERC1820Implementer} and return true when
    ///     queried for support, unless `implementer` is the caller.
    ///     See {iERC1820Implementer-canImplementInterfaceForAddress}.
    ///
    function setInterfaceImplementer(
        address target,
        address account,
        bytes32 interfaceHash,
        address implementer
    )internal
    {
        iERC1820Registry(target).setInterfaceImplementer(
            account,
            interfaceHash,
            implementer
        );
    }
    ///
    /// @dev Returns the implementer of `interfaceHash` for `account`. If no such
    /// implementer is registered, returns the zero address.
    ///
    /// If `interfaceHash` is an {iERC165} interface id (i.e. it ends with 28 zeroes),
    ///`account` will be queried for support of it.
    /// `account` being the zero address is an alias for the caller's address.
    ///
    function getInterfaceImplementer(
        address target,
        address account,
        bytes32 interfaceHash
    )internal view returns(
        address
    ){
        target.getInterfaceImplementer(
            account,
            interfaceHash
        );
    }
    ///
    /// @return {bytes32} interface hash for an `interfaceName`, as defined in
    /// https://eips.ethereum.org/EIPS/eip-1820#interface-name[section of the EIP]
    ///
    function interfaceHash(
        address target,
        string calldata interfaceName
    )internal pure returns(
        bytes32
    ){
        return iERC1820Registry(target).interfaceHash(
            interfaceName
        );
    }
    ///
    /// @notice Updates the cache with whether the contract implements an ERC165 interface or not.
    /// 
    /// @param account Address of the contract for which to update the cache.
    /// @param interfaceId ERC165 interface for which to update the cache.
    ///
    function updateERC165Cache(
        address target,
        address account,
        bytes4 interfaceId
    )internal
    {
        iERC1820Registry(target).updateERC165Cache(
            account,
            interfaceId
        );
    }
    ///
    ///  @notice Checks whether a contract implements an ERC165 interface or not.
    ///  If the result is not cached a direct lookup on the contract address is performed.
    ///  If the result is not cached or the cached value is out-of-date, the cache MUST be updated manually by calling
    ///  {updateERC165Cache} with the contract address.
    /// 
    ///  @param account Address of the contract to check.
    ///  @param interfaceId ERC165 interface to check.
    /// 
    ///  @return {bool} true if `account` implements `interfaceId`, otherwise false.
    ///
    function implementsERC165Interface(
        address target,
        address account,
        bytes4 interfaceId
    )internal view returns(
        bool ret
    ){
        iERC1820Registry(target).implementsERC165Interface(
            account,
            interfaceId
        );
    }
    //function _requireImplementsERC165Interface(
        //address target,
        //address account,
        //bytes4 interfaceId
    //)internal view
    //{
        //account.requireSupportsInterface(interfaceId);
    //}
    ///
    /// @notice Checks whether a contract implements an ERC165 interface or not without using nor updating the cache.
    /// 
    /// @param account {address} of the contract to check.
    /// @param interfaceId {bytes4} ERC165 interface to check.
    /// 
    /// @return {bool} true if `account` implements `interfaceId`, otherwise false.
    ///
    function implementsERC165InterfaceNoCache(
        address target,
        address account,
        bytes4 interfaceId
    )external view returns(
        bool
    ){
        return iERC1820Registry(target).implementsERC165InterfaceNoCache(
            account,
            interfaceId
        );
    }
}