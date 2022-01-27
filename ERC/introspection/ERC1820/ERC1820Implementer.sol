// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "./iERC1820Implementer.sol";
///
/// @dev {iERC1820Implementer} interface Implementation
///
/// Derived contracts may call {_registerInterfaceForAddress} to
/// declare their willingness to be implementers of an interface.
/// To then complete interface registration, {iERC1820Registry.setInterfaceImplementer} should be called
///
contract ERC1820Implementer is iERC1820Implementer
{
    bytes32 constant private _ERC1820_ACCEPT_MAGIC = keccak256(
        abi.encodePacked("ERC1820_ACCEPT_MAGIC")
    );

    mapping(bytes32=>mapping(address=>bool)) private _supportedInterfaces;

    /// See {iERC1820Implementer.canImplementInterfaceForAddress}
    function canImplementInterfaceForAddress(
        bytes32 interfaceHash,
        address account
    )public view override returns(
        bytes32
    ){
        return _supportedInterfaces[interfaceHash][account] ? _ERC1820_ACCEPT_MAGIC : bytes32(0x00);
    }
    ///
    /// @dev Declares the contract as willing to be an implementer of `interfaceHash` for `account`
    /// See {iERC1820Registry.setInterfaceImplementer} and {iERC1820Registry.interfaceHash}
    ///
    function _registerInterfaceForAddress(
        bytes32 interfaceHash,
        address account
    )internal virtual
    {
        _supportedInterfaces[interfaceHash][account] = true;
        
        //account.emitSupportsInterface(interfaceHash);
    }
}