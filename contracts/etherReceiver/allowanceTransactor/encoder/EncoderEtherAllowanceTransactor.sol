// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/allowanceTransactor/encoder/abiEncoderEtherAllowanceTranactor.sol";
import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/allowanceTransactor/encoder/iEncoderEtherAllowanceTransactor.sol";
//
//import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/encoder/EncoderEtherTransactor.sol";
///
/// @title Ether ALlowance Transactor Transaction Encoder Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
///
contract EncoderEtherAllowanceTransactor is iEncoderEtherAllowanceTransactor,
    //EncoderEtherTransactor
{
    constructor(
    )public
        //EncoderEtherTransactor()
    {
        //_reg();
    }
    
    function ethRevokeAllowanceForThis(
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEtherAllowanceTransactor.SIG_ETH_REVOKE_ALLOWANCE_FOR_THIS;
    }
    ///
    /// @return {bytes}
    ///
    function ethTransferFrom(
        address from,
        address recipient,
        uint256 amount
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEtherAllowanceTransactor.ethTransferFrom(
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
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEtherAllowanceTransactor.ethTransferFromToCaller(
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
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEtherAllowanceTransactor.ethTransferFromThis(
            recipient,
            amount
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethTransferFromThisToOwner(
        uint256 amount
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEtherAllowanceTransactor.ethTransferFromThisToOwner(
            amount
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethTransferFromToThis(
        address owner,
        uint256 amount
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEtherAllowanceTransactor.ethTransferFromToThis(
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
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEtherAllowanceTransactor.approve(
            spender
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethThisApproveAllowanceFor(
        address spender,
        uint256 amount
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEtherAllowanceTransactor.ethThisApproveAllowanceFor(
            spender,
            amount
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethThisRevokeAllowance(
        address spender
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEtherAllowanceTransactor.ethThisRevokeAllowance(
            spender
        );
    }
}