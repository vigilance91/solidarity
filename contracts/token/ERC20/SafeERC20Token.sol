// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/ERC/token/ERC20/ERC20Token.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/ERC20ReceiverConstraintsABC.sol";
///
/// @title Safe ERC20 Token Implementation
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/4/2021, All Rights Reserved
/// @dev basic ERC-20 token with ERC-165 and EIP-801 support, as well,
/// since by default, ERC20 contracts do not care if tokens are transfered to a wallet address or a contract address,
/// this non-standard ERC20 implementation enforces contraints requiring contracts which are transfered tokens to implement iERC20Reciever,
/// as well as provide custom implementation logic for handeling out transfers from the implementing contract,
/// otherwise, by default, any ERC20 tokens transfered to an arbitrary contract would be lost forever (this was a horrible design choice by default),
/// since that contract (most likely) does not implement any mechanism to transfer tokens, or interact with ERC20 compliant contracts by default.
/// 
/// This entire class of bugs can be easily avoided simply by having a token contract implement SafeERC20Token,
/// instead of the standard ERC20Token (which this contract derives from),
/// found under solidarity/ERC/token/ERC20/
///
/// By default, this contract will revert if an ERC20 token transfer is made to this contract
///
/// If the implementing contract desires to accept ERC20 token transfers,
/// simply inhert from both SafeERC20Token and ERC20ReceiverABC and ensure:
/// ```
/// _registerInterface(type(iERC20Reciever).interfaceId);
/// ```
/// is called from the derived contract's constructor, which is required for introspection support
///
abstract contract SafeERC20Token is ERC20Token,
    ERC20ReceiverConstraintsABC
{
    using frameworkERC165 for address;
    
    constructor(
        string memory name,
        string memory symbol
    )internal ERC20Token(name, symbol)
        ERC20ReceiverConstraintsABC()
    {
        //enable this contract to receive ERC20 token transfers
        //_registerInterface(type(iERC20Reciever).interfaceId);
        //_registerInterface(type(iSafeERC20Token).interfaceId);
    }
    //can be used, for example, if USDT is transfered to this contract address,
    //this contract can then accept the Tether contract address and perform a safe transfer from the external token address,
    //to some other address
    function _externalSafeTransfer(
        address token,
        address recipient,
        uint256 amount
    )internal
    {
        token.supportsInterface(type(iERC20).interfaceId).requireTrue(
            'SafeERC20Token: external token contract is not ERC20 compliant'
        );
        
        _requireCanReceiveERC20(recipient);
        
        iERC20(token).transfer(address(this), recipient, amount);
        
        _requireOnERC20Received(recipient, address(this), amount);
    }
    //like _externalSafeTransfer but exclusively transfers `amount` of tokens to this contract's owner
    function _externalSafeTransferToOwner(
        address token,
        uint256 amount
    )internal
    {
        _externalSafeTransfer(token, owner(), amount);
    }
    //transfer from this contract to address `to`, must either be a wallet or an iERC20Receiver implementer
    //Requirements:
    //  - reverts if `to` is NULL or is a contract which does not implement ERC165 AND iERC20Receiver
    //
    function _safeTransferTo(
        address to,
        uint256 amount
    )internal
    {
        _transfer(address(this), to, amount);
    }
    //Requirements:
    //  - reverts if this contract's owner is NULL
    //  - reverts if owner is a contract which does not implement ERC165 AND iERC20Receiver
    //
    function _safeTransferToOwner(
        uint256 amount
    )internal
    {
        _safeTransferTo(owner(), amount);
    }
    /// 
    /// @dev See {ERC20._transfer}
    /// 
    /// Additional Requirements:
    ///     - `recipient`  must be either a non-zero wallet address or a contract which implements ERC165 AND iERC20Receiver
    ///
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    )internal virtual override
        //_emitTransfer(sender,recipient,amount)
    {
        _requireCanReceiveERC20(recipient);
        
        super._transfer(sender, recipient, amount);
        
        _requireOnERC20Received(recipient, sender, amount);
    }
    /// 
    /// @dev See {ERC20._mint}
    /// 
    /// Additional Requirements:
    ///     - `account`  must be either a non-zero wallet address or a contract which implements ERC165 AND iERC20Receiver
    ///
    function _mint(
        address account,
        uint256 amount
    )internal virtual override
    {
        _requireCanReceiveERC20(account);
        
        super._mint(account, amount);
        
        _requireOnERC20Received(account, AddressLogic.NULL, amount);
    }
    ///
    ///Requirements:
    ///     - `spender` must be either a wallet address or a contract which implements ERC165 AND iERC20Receiver
    ///
    function _approve(
        address owner,
        address spender,
        uint256 amount
    )internal virtual override
    {
        _requireCanReceiveERC20(spender);
        
        super._approve(owner, spender, amount);
    }
}