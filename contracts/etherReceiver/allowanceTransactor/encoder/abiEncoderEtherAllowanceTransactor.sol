// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Ether Allowance Transactor Transaction Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
///
library abiEncoderEtherAllowanceTransactor
{
    bytes internal constant SIG_ETH_REVOKE_ALLOWANCE_FOR_THIS = abi.encodeWithSignature('ethRevokeAllowanceForThis()');
    
    string internal constant STUB_ETH_TRANSFER_FROM = 'ethTransferFrom(address,address,uint256)';
    string internal constant STUB_ETH_TRANSFER_FROM_TO_CALLER = 'ethTransferFromToCaller(address,uint256)';
    string internal constant STUB_ETH_TRANSFER_FROM_THIS = 'ethTransferFromThis(address,uint256)';
    string internal constant STUB_ETH_TRANSFER_FROM_THIS_TO_OWNER = 'ethTransferFromThisToOwner(uint256)';
    string internal constant STUB_ETH_TRANSFER_FROM_TO_THIS = 'ethTransferFromToThis(address,uint256)';
    string internal constant STUB_ETH_APPROVE = 'approve(address)';
    string internal constant STUB_ETH_THIS_APPROVE_ALLOWANCE_FOR = 'ethThisApproveAllowanceFor(address,uint256)';
    string internal constant STUB_ETH_THIS_REVOKE_ALLOWANCE = 'ethThisRevokeAllowance(address)';
    ///
    /// @return {bytes}
    ///
    function ethTransferFrom(
        address from,
        address recipient,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_ETH_TRANSFER_FROM,
            from,
            recipient,
            amount
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethTransferFromToCaller(
        address from,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_ETH_TRANSFER_FRMO_TO_CALLER,
            from,
            amount
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethTransferFromThis(
        address recipient,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_ETH_THIS_TRANSFER_FROM_THIS,
            recipient,
            amount
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethTransferFromThisToOwner(
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_ETH_THIS_TRANSFER_FROM_THIS_TO_OWNER,
            amount
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethTransferFromToThis(
        address owner,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_ETH_THIS_TRANSFER_FROM_TO_THIS,
            owner,
            amount
        );
    }
    //
    // approve/revoke allowance functions
    //
    ///
    /// @return {bytes}
    ///
    function approve(
        address spender
    )internal pure returns(
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
    function ethThisApproveAllowanceFor(
        address spender,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_ETH_THIS_APPROVE_ALLOWANCE_FOR,
            spender,
            amount
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethThisRevokeAllowance(
        address spender
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_ETH_THIS_REVOKE_ALLOWANCE,
            spender
        );
    }
}