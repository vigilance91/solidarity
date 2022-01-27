// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC721 Transactor Abstract Base Class
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev Abstract Base Contract which is capable of safely sending and receiving ERC721 transfers,
/// only the owner may transfer ERC721 tokens out of this contract
///
/// NOTE:
///     This contract performs safe transfers of ERC721 to contracts,
///     reverting if the recipient is a contract which does not implement iERC721Receiver
///
import "./ERC721ReceiverABC.sol";
import "./frameworkERC721Receiver.sol";
import "./ERC721ReceiverConstraintsABC.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";

abstract contract ERC721TransactorABC is ERC721ReceiverABC,
    ERC721ReceiverConstraintsABC
{
    using SafeMath for uint256;
    
    using logicConstraints for bool;
    using addressConstraints for address;
    using uint256Constraints for uint256;
    
    using frameworkERC721Receiver for address;
    
    string private constant _NAME = ' ERC721TransactorABC: ';
    //string private constant _TRANSFER_FAILED = _NAME.concatenate('transfer failed');
    
    //enable proxying to execute optional callback when making an ETH transfer?
    //fallback()external payable{
        //logicConstraints.alwaysRevert('proxying disable');
    //}
    
    constructor(
    )internal
        ERC721ReceiverABC()
        ERC721ReceiverConstraintsABC()
    {
        //_registerInterface(type(iERC721Sender).interfaceId);
        //_registerInterface(type(iERC721Transactor).interfaceId);
    }
    function _thisTransferERC721(
        address recipient,
        uint256 amount
    )internal
    {
        //_requireLessThanOrEqualAvailableBalance(amount);
        
        _requireCanReceiveETH(recipient, amount);
        recipient.requireNotEqual(address(this));
        //'cannot transfer to self');
        
        //uint256 preBal = thisBalance();
        
        //payable(recipient).transfer(amount);
        (bool success, ) = payable(recipient).call{value:amount}("");
        success.requireTrue('transfer failed');
        
        //assert(preBal.sub(amount) == thisBalance());
    }
    function _thisTransferERC721ToOwner(
        uint256 amount
    )internal{
    }
    function _transferERC721ToThis(
    )internal
    {
    }
    
    //function _externalTransferERC721(
        //address tokenContract,
        //address recipient,
        //uint256 tokenId
    //)internal;
    
    //function _externalTransferERC721ToThis(
        //address tokenContract,
        //uint256 tokenId
    //)internal;
    
    //function _externalTransferERC721ToOwner(
        //address tokenContract,
        //uint256 tokenId
    //)internal
    //{
    //}
    
    /// @dev contract's current ETH balance (including allowances)
    //function totalBalance(
    //)public view returns(
        //uint256
    //){
        //return address(this).balance;
    //}
}