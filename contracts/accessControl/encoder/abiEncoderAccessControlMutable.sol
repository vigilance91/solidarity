// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Access Control Mutable Transaction ABI Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 15/3/2021, All Rights Reserved
/// @dev convenience library for creating encoded signatures for low-level address call operations
///
library abiEncoderAccessControlMutable
{
    //
    string internal constant STUB_GRANT_ROLE = 'grantRole(bytes32,address)';
    string internal constant STUB_REVOKE_ROLE = 'revokeRole(bytes32,address)';
    string internal constant STUB_RENOUNCE_ROLE = 'renounceRole(bytes32)';
    string internal constant STUB_TRANSFER_ROLE = 'transferRole(bytes32,address,address)';
    ///
    /// @dev Encodes a transaction to grant `account` the role `role`
    ///
    function grantRole(
        bytes32 role,
        address account
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_GRANT_ROLE,
            role,
            account
        );
    }
    ///
    /// @dev Encodes a transaction to revoke role `role from address `account`
    ///
    function revokeRole(
        bytes32 role,
        address account
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_REVOKE_ROLE,
            role,
            account
        );
    }
    ///
    /// @dev Encodes a transaction for renouncing role `role` from caller
    ///
    function renounceRole(
        bytes32 role
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_RENOUNCE_ROLE,
            role
        );
    }
    ///
    /// @dev Encodes a transaction for transfering role `role` from address `from` to address `to`
    ///
    function transferRole(
        bytes32 role,
        address from,
        address to
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_TRANSFER_ROLE,
            role,
            from,
            to
        );
    }
}