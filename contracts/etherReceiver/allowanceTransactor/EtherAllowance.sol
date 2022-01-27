// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "./EtherReceiverABC.sol";
import "./frameworkEtherReceiver.sol";
//import "./EtherReceiverConstraintsABC.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "./EtherAllowanceTransactorABC.sol";

interface iEtherTransactor is iEtherReceiver
{
    /// @dev transfer ETH from this contract to recipient
    function ethThisTransferTo(
        address recipient,
        uint256 amount
    )external;
    /// @dev convenience wrapper to transfer ETH from this contract's balance to owner
    function ethThisTransferToOwner(
        uint256 amount
    )external;
    function ethTransferToThis(
    )external payable;

    //function transferFrom(
        //address from,
        //uint256 amount
    //)external;
}

contract TestReceiver is EtherAllowanceTransactorABC,
    //ContractConstraintsABC
    iEtherTransactor
{
    using SafeMath for uint256;
    
    using logicConstraints for bool;
    using addressConstraints for address;
    //using uint256Constraints for uint256;
    
    using frameworkEtherReceiver for address;
    
    string private constant _NAME = ' TestReceiver: ';
    //string private constant _TRANSFER_FAILED = _NAME.concatenate('transfer failed');
    
    /// explicitly disable proxying
    //fallback(
    //)external nonReentrant payable
    //{
        //logicConstraints.alwaysRevert('proxying not allowed');
    //}
    constructor(
    )public nonReentrant
        EtherAllowanceTransactorABC()
        //ContractConstraintsABC
    {
        //_requireThisBalanceZero();
        
        _registerInterface(type(iEtherTransactor).interfaceId);
    }
    /// @dev transfer ETH from this contract to recipient
    function ethThisTransferTo(
        address recipient,
        uint256 amount
    )external virtual override onlyOwner nonReentrant
    {
        _ethThisTransferTo(recipient, amount);
    }
    /// @dev convenience wrapper to transfer ETH from this contract's balance to owner
    function ethThisTransferToOwner(
        uint256 amount
    )external virtual override onlyOwner nonReentrant
    {
        _ethThisTransferTo(owner(), amount);
    }
    function ethTransferToThis(
    )external virtual override payable nonReentrant
    {
        //_requireThisCanReceiveDeposit(mgs.value);

        _requireMsgValueGreaterThanZero();
        //require(msg.value > 0, 'msg.value must be non-zero');
        //note, this contract becomes the new msg.sender in the receiver() function
        (bool success, ) = payable(_this).call{value:msg.value}("");
        success.requireTrue('transferToThis failed');
    }
    //function transferTo(
        //address recipient,
        //uint256 amount
    //)external _canReceiveETH(recipient, amount)
    //{
        //payable(recipient).transfer(amount);
    //}
    //function transferToOwner(
        //uint256 amount
    //)external onlyOwner _canReceiveETH(recipient, amount)
    //{
        //_ownerPayable().transfer(amount);
    //}
    ///
    /// @dev See {mixinERC20.transferFrom}
    /// 
    ///Additional  Requirements:
    ///     - `sender` and `recipient` cannot be the same address
    ///     - the balance held by this contract must be greater than 0
    ///     - the balance held by this contract must be greater than or equal to `amount`
    ///
    function ethTransferFrom(
        address from,
        address recipient,
        uint256 amount
    )external virtual nonReentrant returns(
        bool
    ){
        //_requireThisBalanceGreaterThanZero();
        //_requireThisBalanceGreaterThanOrEqual(amount);
        
        amount.requireGreaterThanZero();

        _requireAvailableBalanceGreaterThanOrEqual(amount);
        
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
        success.requireTrue('transferEthFrom failed');
        
        //if(!_isContract(recipient)){
            //_requireOnEtherReceived(recipient, amount);
        //}

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
    )external virtual nonReentrant returns(
        bool
    ){
        //_requireThisBalanceGreaterThanZero();
        //_requireThisBalanceGreaterThanOrEqual(amount);
        _requireAvailableBalanceGreaterThanOrEqual(amount);

        amount.requireGreaterThanZero();
        
        address sender = _msgSender();
        
        _requireCanReceiveETH(sender, amount);
        
        uint256 A = allowance(
            from,
            sender
        );
        
        A.requireGreaterThanZero();
        A.requireGreaterThanOrEqual(amount);

        //uint256 newAllowance = A.sub(
        A.sub(
            amount,
            "allowance exceeded"
        );
        
        ////_requireCanReceiveDeposit(sender, amount);

        (bool success, ) = payable(sender).call{value:amount}("");
        success.requireTrue('transferEthFromToCaller failed');
        
        _decreaseAllowance(
            from,
            sender,
            amount
        );

        //allowance(from, sender).requireEqual(
            //newAllowance
        //);

        return true;
    }
    /// @dev caller transfers `amount` of their allowance from this contract to `recipient`
    function ethTransferFromThis(
        address recipient,
        uint256 amount
    )external virtual nonReentrant returns(
        bool
    ){
        return _ethTransferFromThis(recipient, amount);
    }
    /// @dev convenience wrapper for caller to transfer `amount` of their allowance to owner
    function ethTransferFromThisToOwner(
        uint256 amount
    )external virtual nonReentrant returns(
        bool
    ){
        return _ethTransferFromThis(owner(), amount);
    }
    /// @dev convenience wrapper for transferFrom where the recipient is implicitly this contract
    function ethTransferFromToThis(
        address owner,
        uint256 amount
    )external virtual nonReentrant returns(
        bool
    ){
        return _ethTransferFromToThis(owner, _msgSender(), amount);
    }
    //
    // approve/revoke allowance functions
    //
    function approve(
        address spender
    )external payable virtual nonReentrant override
    returns(
        bool
    ){
        _requireMsgValueGreaterThanZero();    //'approve failed');

        _approve(_msgSender(), spender, msg.value);
    }
    // 
    // onlyOwner
    // 
    function ethThisApproveAllowanceFor(
        address spender,
        uint256 amount
    )external virtual onlyOwner nonReentrant
    returns(
        bool
    ){
        _approve(_this, spender, amount);
    }
    ///
    /// @dev this contract revokes `spender`s allowance, if one is available
    /// Requirements:
    ///     - `spender` cannot be null
    ///     - `spender` cannot be caller
    ///     - `spender` must have a non-zero allowance
    /// 
    function ethThisRevokeAllowance(
        address spender
    )external virtual onlyOwner nonReentrant
    {
        _revokeAllowance(_this, spender);
    }
    /// 
    /// @dev msg.sender revokes this contract's entire allowance, if one is available
    /// Requirements:
    ///     - msg.sender must have a non-zero allowance allocted for this contract 
    ///
    function ethRevokeAllowanceForThis(
    )external virtual nonReentrant
    {
        _revokeAllowance(_msgSender(), _this);
    }
}