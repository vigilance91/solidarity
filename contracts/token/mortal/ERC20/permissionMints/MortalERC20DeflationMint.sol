// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/mortal/ERC20/MortalPermissionERC20BurnableToken.sol";
//import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/supplyCap/MutableSupplyCapABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/PausableAccessControl.sol";

//interface iSafeERC20DelationMint is iERC20,
// iPausableAccessControl
//{
//}

///
/// @title Mortal ERC20 Deflation Mint
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 4/5/2021, All Rights Reserved
/// @dev ERC20 compliant token mint which is pausable and ONLY capable of burning tokens (after deployment),
/// support safe ERC20 transfers and supports programmed contract death
///
abstract contract MortalERC20DeflationMint is MortalPermissionERC20BurnableToken,
    PausableAccessControl
{
    using SafeMath for uint256;

    using AddressLogic for address;
    
    //using stringUtilities for string;
    
    bytes32 public constant ROLE_BURNER = keccak256("MortalPermissionERC20Mint.ROLE_BURNER");
    
    //string private constant _NAME = ' SafeERC20DeflationMint: ';
    
    ///
    /// @dev explicitly prevent proxying
    //fallback(
    //)external view nonReentrant payable{
        //LogicConstraints.alwaysRevert('proxying disabled');
    //}
    
    
    /// @dev this type of mint can not actually mint tokens after deployment, only burn them
    constructor(
        string memory name,
        string memory symbol,
        //string memory version,
        uint256 initialSupply
    )internal 
        MortalPermissionERC20BurnableToken(
            name,
            symbol
        )
        PausableAccessControl()
        //MutableSupplyCapABC(initialSupply)
    {
        address sender = _msgSender();
        
        _setupRole(ROLE_BURNER, sender);
        
        require(
            initialSupply > 0,
            'initial supply must be non-zero'
        );
        
        _mint(sender, initialSupply);
        
        //_registerInterface(type(iSafeERC20DeflationMint).interfaceId);
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
    ///
    /// @dev See {ERC20._beforeTokenTransfer}
    ///
    /// Requirements:
    ///     - the contract must not be paused
    ///     - `from` cannot be null (ie, cannot mint tokens)
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
        
        if(from.isNull()){
            LogicConstraints.alwaysRevert(
                //_NAME.concatenate("cannot mint tokens")
                "cannot mint tokens"
            );
        }
        //else{
            //_requirePermitted(from);
        //}
        
        //if(to.isNotNull()){
            //_requirePermitted(to);
        //}
        
        super._beforeTokenTransfer(
            from,
            to,
            amount
        );
    }
}