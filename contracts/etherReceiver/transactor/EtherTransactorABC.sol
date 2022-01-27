// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/EtherReceiverABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/frameworkEtherReceiver.sol";
import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/EtherReceiverConstraintsABC.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";

//import "https://github.com/vigilance91/solidarity/contracts/allowance/AllowanceABC.sol";
///
/// @title Ether Transactor Abstract Base Class
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev Abstract Base Contract which is capable of safely receiving ETH and transfering ETH to other addresses,
/// only the owner may transfer ETH out of the contract
///
/// NOTE:
///     This contract performs safe transfers of ETH to contracts,
///     reverting if the recipient is a contract which does not implement iEtherReceiver
///
abstract contract EtherTransactorABC is EtherReceiverABC,
    EtherReceiverConstraintsABC
    //AllowanceABC
{
    using SafeMath for uint256;
    
    using logicConstraints for bool;
    
    using addressConstraints for address;
    
    using uint256Constraints for uint256;
    
    using frameworkEtherReceiver for address;
    
    string private constant _NAME = ' EtherTransactorABC: ';
    
    string private constant _TRANSFER_FAILED = string(
        abi.encodePacked(
            _NAME,
            'transfer failed'
        )
    );
    
    receive(
    )external virtual payable
    {
        _requireOnEtherReceived(
            _this,
            msg.sender,
            msg.value
        );
    }
    //enable proxying to execute optional callback when making an ETH transfer?
    //fallback()external payable{
        
    //}
    constructor(
    )internal
        EtherReceiverABC()
        EtherReceiverConstraintsABC()
        //AllowanceABC()
    {
        //if(msg.value > 0){
            //(bool success, ) = payable(address(this)).call{value:msg.value}("");
            //require(success, 'transfer failed');
        //}
        
        //_registerInterface(type(iEtherSender).interfaceId);
        //_registerInterface(type(iEtherTransactor).interfaceId);
    }
    /// @dev can recipient receive `amount` of ETH
    function _requireCanReceiveETH(
        address recipient,
        uint256 amount
    )internal view
    {
        _requireCanReceiveEther(recipient);
        //will revert if recipient's balance overflows
        //_requireDeposit(recipient, amount);
        recipient.balance.add(amount);
    }
    
    function _ethThisTransferTo(
        address recipient,
        uint256 amount
    )internal
    {
        _requireCanReceiveETH(recipient, amount);
        recipient.requireNotEqual(_this);
        //'cannot transfer to self');
        
        //uint256 preBal = thisBalance();
        
        //payable(recipient).transfer(amount);
        (bool success, ) = payable(recipient).call{value:amount}("");
        
        success.requireTrue(_TRANSFER_FAILED);
        
        //assert(preBal.sub(amount) == thisBalance());
    }
    /// @dev contract's current ETH balance (including allowances)
    function totalBalance(
    )public view returns(
        uint256
    ){
        return _this.balance;
    }
}

/*
contract PayableEtherTransactorABC is EtherTransactorABC,
    PayableMsgValueConstraintsABC
{
    constructor(
    )internal payable
        EtherTransactorABC()
        PayableMsgValueConstraintsABC()
    {

    }
}
*/