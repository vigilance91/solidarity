// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @dev Read-only interface of the global ERC1820 Registry,
/// as defined in the https://eips.ethereum.org/EIPS/eip-1820[EIP]
/// 
/// Accounts may register implementers for interfaces in this registry,
/// as well as query support.
///
/// Implementers may be shared by multiple accounts,
/// and can also implement more than a single interface for each account.
/// Contracts can implement interfaces for themselves,
/// but externally-owned accounts (EOA) must delegate this to a contract.
///
/// {iERC165} interfaces can also be queried via the registry
///
/// For an in-depth explanation and source code analysis, see the EIP text.
///
interface iERC1820RegistryView
{
    ///
    /// @return {address} the manager for `account`
    /// See {setManager}
    ///
    function getManager(
        address account
    )external view returns(
        address
    );
    ///
    /// @dev Returns the implementer of `interfaceHash` for `account`. If no such
    /// implementer is registered, returns the zero address.
    ///
    /// If `interfaceHash` is an {iERC165} interface id (i.e. it ends with 28 zeroes),
    ///`account` will be queried for support of it.
    /// `account` being the zero address is an alias for the caller's address.
    ///
    function getInterfaceImplementer(
        address account,
        bytes32 _interfaceHash
    )external view returns(
        address
    );
    ///
    /// @return {bytes32} interface hash for an `interfaceName`, as defined in
    /// https://eips.ethereum.org/EIPS/eip-1820#interface-name[section of the EIP]
    ///
    function interfaceHash(
        string calldata interfaceName
    )external pure returns(
        bytes32
    );
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
        address account,
        bytes4 interfaceId
    )external view returns(
        bool
    );
    ///
    /// @notice Checks whether a contract implements an ERC165 interface or not without using nor updating the cache.
    /// 
    /// @param account {address} of the contract to check.
    /// @param interfaceId {bytes4} ERC165 interface to check.
    /// 
    /// @return {bool} true if `account` implements `interfaceId`, otherwise false.
    ///
    function implementsERC165InterfaceNoCache(
        address account,
        bytes4 interfaceId
    )external view returns(
        bool
    );
}
///
/// @dev Mutable Interface of the global ERC1820 Registry,
/// as defined in https://eips.ethereum.org/EIPS/eip-1820[EIP]
///
interface iERC1820RegistryMutable
{
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
        address account,
        address newManager
    )external;
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
        address account,
        bytes32 _interfaceHash,
        address implementer
    )external;
    ///
    /// @notice Updates the cache with whether the contract implements an ERC165 interface or not.
    /// 
    /// @param account Address of the contract for which to update the cache.
    /// @param interfaceId ERC165 interface for which to update the cache.
    ///
    function updateERC165Cache(
        address account,
        bytes4 interfaceId
    )external;
}

interface iERC1820Registry is iERC1820RegistryView,
    iERC1820RegistryMutable
{
    
}
///
///@dev ERC-1820 Registry events
///
library eventsERC1820Registry
{
    event InterfaceImplementerSet(
        address account,
        bytes32 interfaceHash,
        address implementer
    );
    event ManagerChanged(
        address account,
        address newManager
    );
    ///
    ///emitter functions
    ///
    function emitInterfaceImplementerSet(
        address account,
        bytes32 interfaceHash,
        address implementer
    )internal
    {
        emit InterfaceImplementerSet(
            account,
            interfaceHash,
            implementer
            //block.tmiestamp,
            //block.number
        );
    }
    function emitManagerChanged(
        address account,
        address newManager
    )internal
    {
        emit ManagerChanged(
            account,
            newManager
            //block.tmiestamp,
            //block.number
        );
    }
}