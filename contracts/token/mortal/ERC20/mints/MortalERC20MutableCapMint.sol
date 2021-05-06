// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/mortal/ERC20/MortalERC20BurnableToken.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/supplyCap/MutableSupplyCapABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/PausableAccessControl.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/supplyCap/iMutableSupplyCap.sol";

//interface iSafeERC20MutableCapMint is iERC20,
// iPausable
//{
//}

///
/// @title ERC20 Token Mint Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 6/5/2021, All Rights Reserved
/// @dev ERC20 compliant token mint which is pausable, with a dynamic (mutable) supply cap
/// the supply cap can be increased, decreased or explicitly set after contract deployment
/// typically either by the contract owner, an admin or a trusted address othewise designated to do so
///
/// Setting a new cap explicitly or decreasing the supply cap below the total supply available
/// will cause the transaction to revert, requiring the burning of tokens (using burn or burnFrom)
/// before the supply cap can be further decreased
///
abstract contract MortalERC20MutableCapMint is MortalERC20BurnableToken,
    PausableAccessControl,
    MutableSupplyCapABC,
    iMutableSupplyCap
{
    using SafeMath for uint256;

    //using LogicConstraints for bool;
    using AddressLogic for address;
    //using uint256Constraints for uint256;
    
    //using stringUtilities for string;
    
    bytes32 public constant ROLE_MINTER = keccak256("SafeERC20MutableCapMint.ROLE_MINTER");
    bytes32 public constant ROLE_BURNER = keccak256("SafeERC20MutableCapMint.ROLE_BURNER");
    
    //string private constant _NAME = ' SafeERC20MutableCapMint: ';
    
    ///
    /// @dev explicitly prevent proxying
    /// NOTE:
    ///     since this contracts methods are external with ReentrancyGuard, not public,
    ///     this will automatically prevent proxying but cauases obscure and hard to track down errors
    ///     so, simply prevent proxying here and any attempt to call a function not declared in this implementation
    ///     will always revert here, no need to figure out issues with function visibility, modifiers, execution context, etc
    /// 
    //)external view nonReentrant payable{
        //LogicConstraints.alwaysRevert('proxying disabled');
    //}
    
    // note: derived contracts may optionally implement iEtherReceiver/iEtherTransactor, etc,
    // as desired or simply declare {receive()} to accept payments of ETH to this contract
    // this is neccessary if the inheriting contract must pay ETH for external transactions to
    // other contracts or wallet addresses
    
    constructor(
        string memory name,
        string memory symbol,
        //uint initialSupply
        uint256 tokenCap
    )internal 
        //ERC20AccessControlToken(name,symbol,0)
        SafeERC20BurnableToken(
            name,
            symbol
        )
        PausableAccessControl()
        MutableSupplyCapABC(
            tokenCap
        )
    {
        //tokenCap.requireGreaterThanOrEqual(
            //initialSupply,
            //_NAME.concatenate("initial supply > cap")
        //);
        
        address sender = _msgSender();
        
        _setupRole(ROLE_MINTER, sender);
        _setupRole(ROLE_BURNER, sender);
        
        _registerInterface(type(iMutableSupplyCap).interfaceId);
        //_registerInterface(type(iSafeERC20MutableCapMint).interfaceId);
        
        //if(initialSupply > 0){
            //_mint(sender, initialSupply);
        //}
    }
    ///
    /// @dev Creates `amount` new tokens for `to`
    /// See {ERC20._mint}
    /// 
    /// Requirements:
    ///     - the caller must have the `MINTER_ROLE`
    ///
    function mint(
        address to,
        uint256 amount
    )external virtual nonReentrant
        //onlyRole(MINTER_ROLE)
    {
        require(
            hasRole(ROLE_MINTER, _msgSender())
            //_NAME.concatenate("must have minter role to mint")
        );
        _mint(to, amount);
    }
    ///
    /// @dev caller destroys `amount` of their tokens
    /// See {ERC20._burn}
    ///
    /// Requirements:
    ///     - `amount` must be non-zero
    ///     - caller's balance must be at least `amount`
    ///
    function burn(
        uint256 amount
    )external virtual override nonReentrant
    {
        address sender = _msgSender();
        
        require(
            hasRole(ROLE_BURNER, sender)
            //_NAME.concatenate("must have minter role to mint")
        );
        _burn(
            sender,
            amount
        );
    }
    ///
    /// @dev caller destroys `amount` of `account`'s tokens,
    /// deducting from the caller's allowance
    /// See {ERC20._burn} and {ERC20.allowance}
    ///
    /// Requirements:
    ///     - caller can not be `account`
    ///     - `account` can not be null address
    ///     - `amount` must be non-zero
    ///     - `account` must have previously granted caller an allowance of at least `amount` tokens
    ///
    function burnFrom(
        address account,
        uint256 amount
    )external virtual override nonReentrant
    {
        address sender = _msgSender();
        
        require(
            hasRole(ROLE_BURNER, sender)
            //_NAME.concatenate("must have minter role to mint")
        );
        sender.requireNotEqual(account);
        
        uint256 A = _allowance(
            account,
            sender
        );
        
        //_requireAllowanceGreaterThanOrEqual(amount);
        A.requireGreaterThanZero(
            //'zero allowance available'
        );
        A.requireGreaterThanOrEqual(amount);
        
        //_decreasedAllowance(account, sender, amount);
        _approve(
            account,
            sender,
            A.sub(
                amount,
                "burn amount exceeds allowance"
            )
        );
        
        _burn(
            account,
            amount
        );
    }
    function increaseCapBy(
        uint256 amountBy
    )external virtual override onlyOwner nonReentrant
    returns(
        uint256
    ){
        return _increaseCapBy(amountBy);
    }
    function decreaseCapBy(
        uint256 amountBy
    )external virtual override onlyOwner nonReentrant
    returns(
        uint256
    ){
        //cannot reduce token cap below current total supply,
        //without first burning tokens but this does not know about the total token supply
        cap().sub(
            amountBy,
            'decreaseCapBy: undeflow'
        ).requireGreaterThanOrEqual(
            totalSupply()
            //'decreaseCapBy: burn tokens before reducing cap'
        );
        return _decreaseCapBy(amountBy);
    }
    
    function setCap(
        uint256 newCap
    )external override onlyOwner nonReentrant
    returns(
        uint256
    ){
        newCap.requireGreaterThanZero();
        
        uint256 CC = cap();
        
        CC.requireNotEqual(newCap);
        
        if(newCap > CC){
            _increaseCapBy(newCap.sub(CC));
        }
        else if(newCap < CC){
            _decreaseCapBy(CC.sub(newCap));
        }
        
        return _cap;
    }
    ///
    /// @dev See {ERC20._beforeTokenTransfer}
    ///
    /// Requirements:
    ///     - the contract must not be paused
    ///
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    )internal virtual override
        //whenNotPaused()
    {
        require(
            !paused()
            //_NAME.concatenate("paused")
        );
        
        //minting
        if(from.isNull()){
            require(
                totalSupply().add(amount) <= cap(),
                "supply cap exceeded"
            );
        }
        
        super._beforeTokenTransfer(
            from,
            to,
            amount
        );
    }
}