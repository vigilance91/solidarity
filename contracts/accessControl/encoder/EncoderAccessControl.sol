// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/encoder/abiEncoderAccessControlView.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/encoder/abiEncoderAccessControlMutable.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/encoder/iEncoderAccessControl.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
///
/// @title Access Control Transaction ABI Encoder Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 9/12/2021, All Rights Reserved
/// convenience library for creating encoded transactions for low-level address call operations on Access Contorl Contracts
/// @dev deployment cost: 587,349 gas
///
contract EncoderAccessControl is iEncoderAccessControl,
    ERC165
{
    using abiEncoderAccessControlView for bytes32;
    using abiEncoderAccessControlMutable for bytes32;
    
    constructor(
    )public
        ERC165()
    {
        _registerInterface(type(iEncoderAccessControlView).interfaceId);
        _registerInterface(type(iEncoderAccessControlMutable).interfaceId);
        _registerInterface(type(iEncoderAccessControl).interfaceId);
        _registerInterface(type(iERC165).interfaceId ^ type(iEncoderAccessControl).interfaceId);
    }
    /// @dev execution cost: 23,103 gas
    function hasRole(
        bytes32 role,
        address account
    )public pure override returns(
        bytes memory
    ){
        return role.hasRole(account);
    }
    /// @dev execution cost: 22,564 gas
    function getRoleMemberCount(
        bytes32 role
    )public pure override returns(
        bytes memory
    ){
        return role.getRoleMemberCount();
    }
    /// @dev execution cost: 22,763  gas
    function getRoleMember(
        bytes32 role,
        uint256 index
    )public pure override returns(
        bytes memory
    ){
        return role.getRoleMember(index);
    }
    // /// @dev execution cost: 
    //function sliceRoleMembers(
        //bytes32 role,
        //uint256 start,
        //uint256 end
    //)public pure override returns(
        //bytes memory
    //){
        //return role.sliceRoleMembers(start, end);
    //}
    
    /// @dev execution cost: 22,432 gas
    function getRoleAdmin(
        bytes32 role
    )public pure override returns(
        bytes memory
    ){
        return role.getRoleAdmin();
    }
    //
    //mutable
    // 
    
    /// @dev execution cost: 23,015 gas
    function grantRole(
        bytes32 role,
        address account
    )public pure override returns(
        bytes memory
    ){
        return role.grantRole(account);
    }
    /// @dev execution cost: 23,147 gas
    function revokeRole(
        bytes32 role,
        address account
    )public pure override returns(
        bytes memory
    ){
        return role.revokeRole(account);
    }
    /// @dev execution cost: 22,498 gas
    function renounceRole(
        bytes32 role
    )public pure override returns(
        bytes memory
    ){
        return role.renounceRole();
    }
    /// @dev execution cost: 23,725 gas
    function transferRole(
        bytes32 role,
        address from,
        address to
    )public pure override returns(
        bytes memory
    ){
        return role.transferRole(from, to);
    }
}