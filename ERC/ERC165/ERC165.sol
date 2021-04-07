// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/ERC165/iERC165.sol";
import "https://github.com/vigilance91/solidarity/ERC/ERC165/mixinERC165.sol";
///
/// @title ERC-165 Compliant Interface Support Introspection Contract Implementation
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev Derived contracts can call {_registerInterface} to declare their support of an interface
/// interface id: 0x01ffc9a7
///     bytes4(keccak256('supportsInterface(bytes4)')) == 0x01ffc9a7
///
abstract contract ERC165 is iERC165
{
    bytes4 private constant _INTERFACE_ID = type(iERC165).interfaceId;

    constructor(
    )internal
    {
        _registerInterface(_INTERFACE_ID);
    }
    //function _supportedInterfaces(
    //)internal view returns(
        //mapping(bytes4=>bool) storage
    //){
        //return mixinERC165.supportedInterfaces();
    //}
    ///
    /// @dev See {iERC165.supportsInterface}
    /// Time complexity O(1), guaranteed to always use less than 30,000 gas
    ///
    function supportsInterface(
        bytes4 interfaceId
    )public view override returns(
        bool
    ){
        return mixinERC165.supportsInterface(interfaceId);
    }
    ///
    /// @dev Registers support of interface `interfaceId`
    /// Interface support of ERC-165 is automatic when inheriting from this contract,
    /// explicit registering its interface id is not required
    /// See {iERC165.supportsInterface}
    ///
    /// Requirements:
    ///     - `interfaceId` cannot be the ERC-165 invalid interface (`0xffffffff`)
    ///
    function _registerInterface(
        bytes4 interfaceId
    )internal virtual
    {
        //_supportedInterfaces[interfaceId] = true;
        mixinERC165.setSupportsInterface(interfaceId, true);
    }
}