// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/frameworkEtherReceiver.sol";
import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/allowanceTransactor/EtherAllowanceTransactorABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/allowanceTransactor/iEtherAllowanceTransactor.sol";
///
/// @title External Ether Allowance Transactor Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev fully realized extension of EtherAllowanceTransactorABC which provides allowance functionality similar to ERC20 tokens,
/// in addition to the functionality provided by EtherTransactorABC
///
/// NOTE:
///     This contract can also be used for external addresses to enable allowances for external third parties as well
///
contract ExternalEtherAllowanceTransactor is EtherAllowanceTransactorABC
    iEtherAllowanceTransactor
{
    using SafeMath for uint256;
    
    using LogicConstraints for bool;
    using AddressConstraints for address;
    //using uint256Constraints for uint256;
    
    using frameworkEtherReceiver for address;
    
    string private constant _NAME = ' ExternalEtherAllowanceTransactor: ';
    //string private constant _TRANSFER_FAILED = _NAME.concatenate('transfer failed');
    
    //enable proxying to execute optional callback when making an ETH transfer?
    //fallback()external payable{
        
    //}
    constructor(
    )public //payable
        EtherAllowanceTransactorABC()
    {
        //if(msg.value > 0){
            //(bool success, ) = payable(address(this)).call{value:msg.value}("");
            //require(success, 'transfer failed');
        //}
        
        _registerInterface(type(iEtherTransactor).interfaceId);
        _registerInterface(type(iEtherAllowanceTransactor).interfaceId);
    }
    /// @dev transfer ETH from this contract to recipient
    function ethThisTransferTo(
        address recipient,
        uint256 amount
    )external virtual override onlyOwner
    {
        _requireAvailableBalanceGreaterThanOrEqual(amount);
        _ethThisTransferTo(recipient, amount);
    }
    /// @dev convenience wrapper to transfer ETH from this contract's balance to owner
    function ethThisTransferToOwner(
        uint256 amount
    )external virtual override onlyOwner
    {
        _requireAvailableBalanceGreaterThanOrEqual(amount);
        _ethThisTransferTo(owner(), amount);
    }
    function ethTransferToThis(
    )external virtual override payable
    {
        require(msg.value > 0, 'msg.value must be non-zero');
        //note, this contract becomes the new msg.sender in the receiver() function
        (bool success, ) = payable(address(this)).call{value:msg.value}("");
        success.requireTrue('transferToThis failed');
    }
    ///
    /// @dev See {mixinERC20.transferFrom}
    /// 
    ///Additional  Requirements:
    ///     - `sender` and `recipient` cannot be the same address
    ///
    function ethTransferFrom(
        address from,
        address recipient,
        uint256 amount
    )external virtual override returns(
        bool
    ){
        _requireCanReceiveETH(recipient, amount);
        
        address sender = _msgSender();
        
        uint256 A = allowance(
            from,
            sender
        );
        
        A.requireGreaterThanZero();
        A.requireGreaterThanOrEqual(amount);
        A.sub(
            amount,
            "allowance exceeded"
        );
        
        (bool success, ) = payable(recipient).call{value:amount}("");
        success.requireTrue('ethTransferFrom failed');
        
        _decreaseAllowance(
            from,
            sender,
            amount
        );
        return true;
    }
    /// @dev convenience wrapper for transferFrom where recipient is implicitly the caller
    function ethTransferFromToCaller(
        address from,
        uint256 amount
    )external virtual override returns(
        bool
    ){
        address sender = _msgSender();
        
        _requireCanReceiveETH(sender, amount);
        
        uint256 A = allowance(
            from,
            sender
        );
        
        A.requireGreaterThanZero();
        A.requireGreaterThanOrEqual(amount);
        A.sub(
            amount,
            "allowance exceeded"
        );
        
        (bool success, ) = payable(sender).call{value:amount}("");
        success.requireTrue('ethTransferFromToCaller failed');
        
        _decreaseAllowance(
            from,
            sender,
            amount
        );
        return true;
    }
    /// @dev caller transfers `amount` of their allowance from this contract to `recipient`
    function ethTransferFromThis(
        address recipient,
        uint256 amount
    )external virtual override returns(
        bool
    ){
        return _ethTransferFromThis(recipient, amount);
    }
    /// @dev convenience wrapper for caller to transfer `amount` of their allowance to owner
    function ethTransferFromThisToOwner(
        uint256 amount
    )external virtual override returns(
        bool
    ){
        return _ethTransferFromThis(owner(), amount);
    }
    /// @dev convenience wrapper for transferFrom where the recipient is implicitly this contract
    function ethTransferFromToThis(
        address owner,
        uint256 amount
    )external virtual override returns(
        bool
    ){
        return _ethTransferFromToThis(owner, _msgSender(), amount);
    }
    //
    // approve/revoke allowance functions
    //
    function approve(
        address spender
    )external payable virtual override
    returns(
        bool
    ){
        _approve(_msgSender(), spender, msg.value);
    }
    function ethThisApproveAllowanceFor(
        address spender,
        uint256 amount
    )external virtual onlyOwner
    returns(
        bool
    ){
        _approve(address(this), spender, amount);
    }
    /// @dev this contract revokes `spender`s allowance, if one is available
    function ethThisRevokeAllowance(
        address spender
    )external virtual override onlyOwner
    {
        _revokeAllowance(address(this), spender);
    }
    /// @dev msg.sender revokes this contract's allowance, if one is available
    function ethRevokeAllowanceForThis(
    )external virtual override
    {
        _revokeAllowance(_msgSender(), address(this));
    }
}