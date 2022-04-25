// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/batched/iERC165Batched.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/mixinERC165.sol";
///
/// @title ERC-165 Compliant Interface Support Introspection Contract Implementation
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev Derived contracts can call {_registerInterface} to declare their support of an interface
/// interface id: 0x01ffc9a7
///     bytes4(keccak256('supportsInterface(bytes4)')) == 0x01ffc9a7
///
abstract contract ERC165Batched is iERC165Batched
{
    //using mixinERC165 for bytes32;
    
    bytes4 private constant _IID_ERC165_BATCHED = type(iERC165Batched).interfaceId;

    constructor(
    )internal
    {
        _registerInterfacesMemory((bytes4[])[
            _IID_ERC165_BATCHED
        ]);
    }
    ///
    /// @dev See {iERC165.supportsInterface}
    /// Time complexity O(1), guaranteed to always use less than 30,000 gas
    ///
    function supportsInterface(
        bytes4[] calldata interfaceIds
    )external view virtual override returns(
        bool[] memory results
    ){
        uint IL = interfaceIds.length;
        
        results = new bool[](IL);
        
        for(uint i; i < IL; i++){
            results[i] = mixinERC165.supportsInterface(interfaceIds[i]);
        }
    }
    ///
    /// @dev Registers support for each interface in `interfaceIds`
    /// Interface support of ERC-165 is automatic when inheriting from this contract,
    ///
    /// Requirements:
    ///     - `interfaceId` cannot be the ERC-165 invalid interface (`0xffffffff`)
    ///
    function _registerInterfacesMemory(
        bytes4[] memory interfaceIds
    )internal virtual
    {
        for(uint i; i < interfaceIds.length; i++){
            mixinERC165.setSupportsInterface(interfaceIds[i], true);
        }
    }
    ///
    /// @dev Registers support for each interface in `interfaceIds`
    /// Interface support of ERC-165 is automatic when inheriting from this contract,
    ///
    /// Requirements:
    ///     - `interfaceId` cannot be the ERC-165 invalid interface (`0xffffffff`)
    ///
    function _registerInterfacesStorage(
        bytes4[] storage interfaceIds
    )internal virtual
    {
        for(uint i; i < interfaceIds.length; i++){
            mixinERC165.setSupportsInterface(interfaceIds[i], true);
        }
    }
}