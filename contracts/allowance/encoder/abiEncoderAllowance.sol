// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

///
/// @dev Allowance Transaction Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
///
library abiEncoderAllowance
{
    string public constant STUB_ALLOWANCE = 'allowance(address,address)';
    string public constant STUB_APPROVE = 'approve(address)';
    string public constant STUB_REVOKE_ALLOWANCE = 'revokeAllowance(address)';
    ///
    /// @return {bytes}
    ///
    function allowance(
        address owner,
        address spender
    )external pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_ALLOWANCE,
            owner,
            spender
        );
    }
    ///
    /// @return {bytes} 
    /// 
    function approve(
        address spender
    )external pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_APPROVE,
            spender
        );
    }
    ///
    /// @return {bytes} 
    /// 
    function revokeAllowance(
        address spender
    )external pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_REVOKE_ALLOWANCE,
            spender
        );
    }
}