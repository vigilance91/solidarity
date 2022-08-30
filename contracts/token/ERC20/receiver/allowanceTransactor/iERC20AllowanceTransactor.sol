// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/tokn/ERC20/erc20Receiver/transactor/iERC20Transactor.sol";
///
/// @title Ether Allowance Transactor Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev Any contract capable of safely receiving and sending Ether transfers,
/// as well as permitting the custody of ETH allowances by and/or to other third-party addresses/contracts
///
interface iERC20AllowanceTransactor is iERC20Transactor
{
    ///
    /// @dev See {mixinAllowance.transferFrom}
    /// 
    /// analogous to {ERC20.transferFrom} except for ETH rather than ERC20 tokens
    /// Additional  Requirements:
    ///     - `from` and `recipient` cannot be the same address
    ///     - msg.sender must have been granted a non-zero allowance by `from`
    ///     - `recipient` must have a non-zero allowance
    ///     - `amount` must be non-zero
    ///
    function erc20TransferFrom(
        address from,
        address recipient,
        uint256 amount
    )external returns(
        bool
    );
    /// @dev convenience wrapper for transferFrom where recipient is implicitly the caller
    function erc20TransferFromToCaller(
        address from,
        uint256 amount
    )external virtual returns(
        bool
    );
    /// @dev caller transfers `amount` of their allowance from this contract to `recipient`
    function erc20TransferFromThis(
        address recipient,
        uint256 amount
    )external returns(
        bool
    );
    /// @dev convenience wrapper for caller to transfer `amount` of their allowance to owner
    function erc20TransferFromThisToOwner(
        uint256 amount
    )external returns(
        bool
    );
    /// @dev convenience wrapper for transferFrom where the recipient is implicitly this contract
    function erc20TransferFromToThis(
        address owner,
        uint256 amount
    )external returns(
        bool
    );
    //
    // approve/revoke allowance functions
    //
    function approve(
        address spender
    )external payable returns(
        bool
    );
    function erc20ThisApproveAllowanceFor(
        address spender,
        uint256 amount
    )external returns(
        bool
    );
    /// @dev this contract revokes `spender`s allowance, if one is available
    function erc20ThisRevokeAllowance(
        address spender
    )external;
    
    /// @dev msg.sender revokes this contract's allowance, if one is available
    function erc20RevokeAllowanceForThis(
    )external;
}