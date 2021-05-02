// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/EtherTransactorABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/iEtherTransactor.sol";
///
/// @title External Ether Transactor Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev Fully realized External extension of EtherTransactorABC which provides safe ETH transfer functionality,
/// similar to ERC20 tokens but for ETH and can be easily implemented in other dApps or be used as a stand alone contract
///
contract ExternalEtherTransactor is EtherTransactorABC
    iEtherTransactor
{
    using SafeMath for uint256;
    
    using LogicConstraints for bool;
    using AddressConstraints for address;
    //using uint256Constraints for uint256;
    
    using frameworkEtherReceiver for address;
    
    string private constant _NAME = ' ExternalEtherTransactor: ';
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
}