// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title Ether Allowance Transactor Abstract Base Class
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev extension of EtherTransactionABC which provides allowance functionality,
/// similar to ERC20 tokens but for ETH and can be easily expanded to other applications
///
/// NOTE:
///     This contract can also be used for external addresses to enable allowances for external third parties as well
///
import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/EtherTransactorABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/allowance/AllowanceABC.sol";

abstract contract EtherAllowanceTransactorABC is EtherTransactorABC,
    AllowanceABC
{
    using SafeMath for uint256;
    
    using logicConstraints for bool;
    using addressConstraints for address;
    //using uint256Constraints for uint256;
    
    using frameworkEtherReceiver for address;
    
    string private constant _NAME = ' EtherAllowanceTransactorABC: ';
    //string private constant _TRANSFER_FAILED = _NAME.concatenate('transfer failed');
    
    
    constructor(
    )internal
        EtherTransactorABC()
        AllowanceABC()
    {
        //if(msg.value > 0){
            //(bool success, ) = payable(address(this)).call{value:msg.value}("");
            //require(success, 'transfer failed');
        //}
        
        //_registerInterface(type(iAllowance).interfaceId);
        //_registerInterface(type(iEtherAllowanceTransactor).interfaceId);
    }
    ///
    /// @return {uint256} difference between the total ETH held by the contract and totalAllowanceHeldInCustody()
    /// @dev represents the total amount of ETH that this contract is freely able to transfer or otherwise transact with
    ///
    function availableBalance(
    )public view returns(
        uint256
    ){
        return totalBalance().sub(
            totalAllowanceHeldInCustody()
        );
    }
    function _requireAvailableBalanceGreaterThanOrEqual(
        uint256 amount
    )internal view
    {
        availableBalance().requireGreaterThanOrEqual(amount);
    }
    /// @dev require that this contract can transfer `amount` of allowance to recipient, if one is available
    /// otherwise revert
    function _requireCanWithdrawlAllowanceETH(
        address owner,
        address recipient,
        uint256 amount
    )internal view
    {
        //owner.requireNotEqualAndNotNull(recipient);
        
        _requireCanReceiveEther(
            recipient
        );
        
        uint256 A = allowance(
            owner,
            recipient
        );
        
        A.requireGreaterThanZero();
        A.sub(
            amount,
            "allowance exceeded"
        );
    }
    /// @dev require that this contract can transfer `amount` of allowance to recipient, if one is available
    /// otherwise revert
    function _requireThisCanWithdrawlAllowanceFromETH(
        address from,
        uint256 amount
    )internal view
    {
        _requireCanWithdrawlAllowanceETH(
            from,
            address(this),
            amount
        );
    }
    /// @dev require recipient is able to withdrawl `amount` from an allowance approved by this contract
    function _requireCanWithdrawlAllowanceFromThisETH(
        address recipient,
        uint256 amount
    )internal view
    {
        _requireCanWithdrawlAllowanceETH(
            address(this),
            recipient,
            amount
        );
    }
    ///
    /// @dev convenience wrapper for transferFrom with owner implicitly this contract
    ///
    function _ethTransferFromThis(
        address recipient,
        uint256 amount
    )internal virtual returns(
        bool
    ){
        _requireCanWithdrawlAllowanceFromThisETH(recipient, amount);
        
        address sender = _msgSender();
        address _this = address(this);
        
        (bool success, ) = payable(sender).call{value:amount}("");
        success.requireTrue('transferEthFromThis failed');
        
        _decreaseAllowance(
            _this,
            sender,
            amount
        );
        return true;
    }
    /// @dev msg.sender transfer their allowance from owner to this contract
    function _ethTransferFromToThis(
        address owner,
        address spender,
        uint256 amount
    )internal virtual returns(
        bool
    ){
        address _this = address(this);
        
        _requireCanWithdrawlAllowanceETH(owner, spender, amount);
        
        (bool success, ) = payable(_this).call{value:amount}("");
        success.requireTrue('transferEthFromToThis failed');
        
        _decreaseAllowance(
            owner,
            spender,
            amount
        );
        return true;
    }
}