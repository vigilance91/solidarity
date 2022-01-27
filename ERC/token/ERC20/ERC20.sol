// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/MutableSupplyTokenABC.sol";

import "https://github.com/vigilance91/solidarity/ERC/token/ERC20/mixinERC20.sol";
import "https://github.com/vigilance91/solidarity/ERC/token/ERC20/eventsERC20.sol";
///
/// @title ERC20
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev {iERC20} interface implementation
///
/// This implementation is agnostic to the way tokens are created,
/// meaning that a supply mechanism must be added in a derived contract using {_mint}
/// For a generic mechanism see {ERC20PresetMinterPauser}
///
/// TIP:
///     For a detailed writeup see OpenZeppelin's guide:
///         https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How to implement supply mechanisms]
///
/// This contract is written in compliance with general OpenZeppelin guidelines:
///     functions revert instead of returning `false` on failure
///
/// This behavior is comliant with the expectations of ERC-20 contracts
///
/// Additionally, {Approval} events are emitted on calls to {transferFrom},
/// allowing applications to reconstruct the allowance for all accounts by listening for Approval events
/// 
/// NOTE:
///     Other implementations of the EIP may not emit these events,
///     as it isn't required by the specification
///
/// Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
/// functions have been added to mitigate the well-known issues around setting allowances
/// See {iERC20-approve}
///
/// NOTE:
///     By default, for security and sanity, this ERC20 token implementation does NOT allow for
///     this contract to be the sender or receiver of its own tokens,
///     since ERC20 does not provide any mechanism for a contract to forward tokens sent to it.
///     In solidity there is nothing preventing contracts from being the recipient of a transfer call.
///     
///     This is a blatantly obvious flaw since allowing a token contract to receive its own tokens,
///     without any way to send the tokens out, causes to permanent tokens loss.
///     The same is true for making transfers to any contract address which does not support such a interface.
///     
///     This flaw is a major concern, as many contracts in production today suffer from this issue (such as the Golem Network),
///     and as a result, these contracts have millions, if not hundreds of thousands of dollars worth of tokens
///     locked in them, which can never be accessed nor recovered.
///     
///     It just makes sense that this behaviour should be disabled by default by the EVM,
///     infuriatingly, however, this is not the case
///     
///     Should a derived contract need the ability to perform its own token transfers,
///     {approve}, {transfer}, {mint} and {burn} functions can be easily overriden to simply
///     not perform the check preventing target accounts being this contract
///
///     todo derive a child contract which performs checks on contract addresses using ERC-165,
///     and only transfer to contracts which support a specific interface for token transfers to/from contracts
///
abstract contract ERC20 is MutableSupplyTokenABC
{
    using logicConstraints for bool;
    
    using uint256Constraints for uint256;
    using addressConstraints for address;
    
    using eventsERC20 for address;
    
    using SafeMath for uint256;
    ///
    /// @dev Set {name} and {symbol} of token, initializes {decimals} with a default value of 18
    ///
    /// NOTE:
    ///     call {_setupDecimals} in derived constructors to set a different value for {decimals}
    ///     These values are immutable and should not be set or modified outside a constructor
    ///
    constructor(
        string memory name,
        string memory symbol
    )internal MutableSupplyTokenABC(name, symbol, 0)
    {
        mixinERC20.initialize(
            18
        );
    }
    function _mutableERC20Storage(
    )private returns(
        mixinERC20.ERC20Storage storage
    ){
        return mixinERC20.storageERC20();
    }
    function _readOnlyERC20Storage(
    )private pure returns(
        mixinERC20.ERC20Storage storage
    ){
        return mixinERC20.storageERC20();
    }
    /// See {mixinERC20.decimals}
    function decimals(
    )public view returns(
        uint8
    ){
        return mixinERC20.decimals();
    }
    /// @dev See {iERC20-totalSupply}
    //function totalSupply(
    //)public view override returns(
        //uint256
    //){
        //return mixinERC20.totalSupply();
    //}
    
    //balanceOf caller
    //function balanceOf(
    //)public view override returns(
        //uint256
    //){
        //return mixinERC20.balanceOf(_msgSender());
    //}
    
    //function _requireBalanceGreaterThan(
        //address account,
        //uint256 amount
    //)internal view
    //{
        //balanceOf(
            //account
        //).requireGreaterThan(
            //amount
            ////'insufficient balance'
        //);
    //}
    //function _requireAllowanceGreaterThan(
        //address owner,
        //address spender,
        //uint256 amount
    //)internal view
    //{
        //allowance(
            //owner,
            //spender
        //).requireGreaterThan(amount);
    //}
    /// @dev See {iERC20.balanceOf}
    function _balanceOf(
        address account
    )internal view returns(
        uint256
    ){
        return mixinERC20.balanceOf(account);
    }
    //function balanceOfCaller(
    //)external view override returns(
        //uint256
    //){
        //_requireNotThis(account);
        //return mixinERC20.balanceOf(_msgSender());
    //}
    /// non-standard convenience method
    ///@return {tuple} numerator, denominator
    //function balanceOfToTotalSupply(
    //)external view returns(
        //uint256 numerator,
        //uint256 denominator
    //){
        //return (balaneOf(_msgSender(), _cap);
    //}
    ///
    /// @dev See {mixinERC20.decreaseAllowance}
    /// 
    /// Additional Requirements:
    ///     - `spender` cannot be this contract
    ///     - `spender` must have a non-zero allowance to increase it, otherwise first call allow(),
    ///         then call increase/decrease as required
    ///
    function _increaseAllowance(
        address owner,
        address spender,
        uint256 addedValue
    )internal virtual returns(
        bool
    ){
        //_requireNotThis(spender);
        addedValue.requireGreaterThanZero();
        
        uint256 A = _allowance(
            owner,
            spender
        );
        
        A.requireGreaterThanZero();
        
        _approve(
            owner,
            spender,
            A.add(
                addedValue
                //"allowance overflow"
            )
        );
        return true;
    }
    ///
    /// @dev See {mixinERC20.decreaseAllowance}
    /// Additional Requirements:
    ///     - `spender` cannot be null
    ///     - `spender` must already have a non-zero allowance of at least `subtractedValue`
    ///
    function _decreaseAllowance(
        address owner,
        address spender,
        uint256 subtractedValue
    )internal virtual returns(
        bool
    ){
        //_requireNotThis(spender);
        
        uint256 A = _allowance(
            owner,
            spender
        );
        //spender must have a non-zero allowance, if decreasing it
        subtractedValue.requireGreaterThanZero();
        A.requireGreaterThanOrEqual(
            subtractedValue
        );
        
        _approve(
            owner,
            spender,
            A.sub(
                subtractedValue,
                "allowance underflow"
            )
        );
        
        return true;
    }
    function _revokeAllowance(
        address owner,
        address spender
    )internal virtual returns(
        bool
    ){
        //spender must have a non-zero allowance, if owner is revoking it
        //_requireAllowanceGreaterThanZero();
        _allowance(
            owner,
            spender
        ).requireGreaterThanZero();
        
        _approve(
            owner,
            spender,
            0
        );
        
        return true;
    }
    /// @dev See {mixinERC20.transfer}
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    )internal virtual
        //_emitTransfer(sender,recipient,amount)
    {
        sender.requireNotNull(
            //"ERC20: transfer from the zero address"
        );
        recipient.requireNotNull(
            //"ERC20: transfer to the zero address"
        );
        sender.requireNotEqual(
            recipient
            //"ERC20: transfer from the zero address"
        );
        amount.requireGreaterThanZero();
        //balanceOf(sender).greaterThanOrEqual(amount);
        
        //if(recipient.isContract()){
            //recipient.supportsInterface(type(i...).interfaceId).requireTrue(
                //"can't transfer tokens to contract"
            //);
        //}
        
        _beforeTokenTransfer(
            sender,
            recipient,
            amount
        );

        //_setBalanceOf(
        mixinERC20.setBalanceOf(
            sender,
            _balanceOf(sender).sub(
                amount,
                "balance exceeded"
            )
        );
        
        mixinERC20.setBalanceOf(
            recipient,
            _balanceOf(recipient).add(
                amount
            )
        );
        
        sender.emitTransfer(
            recipient,
            amount
        );
    }
    function _allowance(
        address owner,
        address spender
    )internal view returns(
        uint256
    ){
        return mixinERC20.allowanceFor(owner,spender);
    }
    
    function _transferFrom(
        address owner,
        address spender,
        address recipient,
        uint256 amount
    )internal virtual returns(
        bool
    ){  
        uint256 A = _allowance(
            owner,
            spender
        );
        
        A.requireGreaterThanZero();
        A.requireGreaterThanOrEqual(amount);
        
        _transfer(
            owner,
            recipient,
            amount
        );
        
        //_decreaseAllowance(owner,spender, amount);
        _approve(
            owner,
            spender,
            A.sub(
                amount,
                "allowance exceeded"
            )
        );
        
        return true;
    }
    function _setBalanceOf(
        address account,
        uint256 amount
    )internal
    {
        mixinERC20.setBalanceOf(
            account,
            amount
        );
    }
    function _increaseBalanceOf(
        address account,
        uint256 amountBy
    )internal
    {
        _setBalanceOf(
            account,
            _balanceOf(account).add(amountBy)
        );
    }
    function _decreaseBalanceOf(
        address account,
        uint256 amountBy
    )internal
    {
        _setBalanceOf(
            account,
            _balanceOf(account).sub(amountBy)
        );
    }
    /// 
    /// @dev Creates `amount` tokens and assigns them to `account` (increasing the total supply)
    /// Emits a {Transfer} event, `from` is set to the zero address
    /// 
    /// Additional Requirements:
    ///     - `account` cannot be null
    ///     - `amount` must be non-zero
    ///
    function _mint(
        address account,
        uint256 amount
    )internal virtual
        //_emitTransfer(addressLogic.NULL,account,amount)
    {
        account.requireNotNull(
            //"_mint"
        );
        amount.requireGreaterThanZero(
            //''
        );
        
        //if(account.isContract()){
            //account.supportsInterface(type(i...interfaceId)).requireTrue(
                //"can't transfer tokens to contract"
            //);
        //}
        
        _beforeTokenTransfer(
            addressLogic.NULL,
            account,
            amount
        );
        
        //_setTotalSupply(totalSupply().add(amount));
        _increaseTotalSupply(amount);
        
        mixinERC20.setBalanceOf(
            account,
            _balanceOf(account).add(
                amount
                //'balance overflow'
            )
        );
        
        addressLogic.NULL.emitTransfer(
            account,
            amount
        );
    }
    ///
    /// @dev Destroys `amount` of tokens from `account` (reducing the total supply)
    /// Emits a {Transfer} event, `to` is set to the zero address
    /// 
    ///Additional Requirements:
    ///     - `account` cannot be null
    ///     - `amount` must be non-zero
    ///
    function _burn(
        address account,
        uint256 amount
    )internal virtual
        //_emitTransfer(account,addressLogic.NULL,amount)
    {
        //_requireNotThis(account);
        
        account.requireNotNull(
            ////"_burn"
        );
        amount.requireGreaterThanZero(
            //''
        );
        
        _beforeTokenTransfer(
            account,
            addressLogic.NULL,
            amount
        );
        
        //uint256 previousSupply = totalSupply();
        //uint256 previousBalance = balanceOf(account);
        
        mixinERC20.setBalanceOf(
            account,
            _balanceOf(account).sub(
                amount,
                "balance exceeded"
            )
        );
        
        //balanceOf(account).requireLessThan(previousBalance);
        
        //_setTotalSupply(totalSupply().sub(amount));
        _decreaseTotalSupply(amount);
        
        //totalSupply().requireLessThan(previousSupply);
        
        account.emitTransfer(
            addressLogic.NULL,
            amount
        );
    }
    /**
    modifier _emitApproval(
        address owner,
        address spender,
        uint256 amount
    ){
        amount.requireGreaterThanZero(
            //"ERC20: approve"
        );
        owner.requireNotNull(
            //"ERC20: approve from the zero address"
        );
        spender.requireNotNull(
            //"ERC20: approve to the zero address"
        );
        owner.requireNotEqual(spender);
        
        _;
        
        owner.emitApproval(
            spender,
            amount
        );
    }
    */
    ///
    /// @dev See {mixinERC20.approve}
    /// 
    /// Requirements:
    ///     - `owner` and `spender` cannot be null
    ///     - `owner` cannot be `spender`
    ///
    function _approve(
        address owner,
        address spender,
        uint256 amount
    )internal virtual
        //_emitApproval(owner,spender,amount)
    {
        //_requireNotThis(spender);
        //note: amount may be 0
        owner.requireNotNull(
            //"approve from the zero address"
        );
        spender.requireNotNull(
            //"approve to the zero address"
        );
        owner.requireNotEqual(spender);
        
        mixinERC20.setAllowanceFor(
            owner,
            spender,
            amount
        );
        
        owner.emitApproval(
            spender,
            amount
        );
    }
    ///
    /// @dev Sets {decimals} to a value other than the default one of 18
    ///
    /// WARNING:
    ///     This function should only be called from the constructor
    /// NOTE:
    ///     Most applications that interact with token contracts will not expect {decimals} to ever change,
    ///     attempting to modify this value after costruction is NOT reccomeded and,
    ///     may result in incorrect display results at best or may lead to an invariant state which may be exploited at worst
    ///
    function _setupDecimals(
        uint8 newDecimals
    )internal
    {
        mixinERC20.setDecimals(newDecimals);
    }
    ///
    /// @dev Hook that is called before any transfer of tokens,
    /// including minting and burning
    /// 
    /// Calling conditions:
    ///     - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
    ///         will be to transferred to `to`
    ///     - when `from` is zero, `amount` of tokens will be minted for `to`
    ///     - when `to` is zero, `amount` of `from`'s tokens will be burned
    ///     - `from` and `to` are never both zero
    ///     - `from` and `to` can not be the same address
    /// 
    /// To learn more about hooks,
    ///     head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks]
    ///
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    )internal virtual{
        //emit event?
    }
}