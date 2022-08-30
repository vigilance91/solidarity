// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/receiver/ERC20ReceiverABC.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/receiver/frameworkERC20Receiver.sol";

//import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/receiver/ERC20ReceiverConstraintsABC.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";

//import "https://github.com/vigilance91/solidarity/contracts/allowance/AllowanceABC.sol";
///
/// @title ERC20 Transactor Abstract Base Class
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev Abstract Base Contract which is capable of safely receiving and transfering ERC20 tokens,
/// only the owner may transfer ERC20 out of the contract
///
/// NOTE:
///     This contract performs safe transfers of ERC20 tokens to contracts,
///     reverting if the recipient is a contract which does not implement iERC20Receiver
///
abstract contract ERC20TransactorABC is ERC20ReceiverABC
    //ERC20ReceiverConstraintsABC
    //AllowanceABC
{
    using SafeMath for uint256;
    
    //using externalConstraints for *;
    
    using logicConstraints for bool;
    
    using addressConstraints for address;
    
    using uint256Constraints for uint256;
    
    using frameworkERC20Receiver for address;
    
    address private _token;
    
    string private constant _NAME = ' ERC20TransactorABC: ';
    
    string private constant _TRANSFER_FAILED = string(
        abi.encodePacked(
            _NAME,
            'transfer failed'
        )
    );
    
    //receive(
    //)external virtual payable
    //{
        //_requireOnERC20Received(
            //_this,
            //msg.sender,
            //msg.value
        //);
    //}
    
    constructor(
        address erc20Token
    )internal
        ERC20ReceiverABC()
        //ERC20ReceiverConstraintsABC()
        //AllowanceABC()
    {
        _token = erc20Token;
        //
        //_registerInterface(type(iERC20Sender).interfaceId);
        //_registerInterface(type(iERC20Transactor).interfaceId);
    }
    
    function token(
    )public view returns(
        address
    ){
        return _token;
    }
    
    function _erc20ThisTransferTo(
        address recipient,
        uint256 amount
    )internal
    {
        _requireCanReceiveERC20(recipient, amount);
        recipient.requireNotEqual(_this);
        //'cannot transfer to self');
        
        //uint256 preBal = thisBalance();
        
        //payable(recipient).transfer(amount);
        //
        //try
            token.transfer(recipient, amount).requireTrue(_TRANSFER_FAILED);
        //except(string memory){}
        //except(bytes memory){}
        //except(){}
        
        //assert(preBal.sub(amount) == thisBalance());
    }
    /// @dev contract's current ETH balance (including allowances)
    function totalBalance(
    )public view returns(
        uint256
    ){
        return _token.balanceOf(_this());
    }
}

/*
contract PayableERC20TransactorABC is ERC20TransactorABC,
    EtherReceiverABC,
    PayableMsgValueConstraintsABC
{
    constructor(
    )internal payable
        ERC20TransactorABC()
        EtherReceiverABC()
        PayableMsgValueConstraintsABC()
    {

    }
}
*/