// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/SafeERC20BurnableToken.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/supplyCap/MutableSupplyCapABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/PausableAccessControl.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/supplyCap/iMutableSupplyCap.sol";

//interface iSafeERC20MutableCapMint is iERC20,
// iPausable
//{
//}

///
/// @title Safe ERC20 Token Mint
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev Generic ERC20 compliant token mint which is pausable, with an uncapped, dynamic (mutable) supply,
/// capable of permissioned minting and burning of tokens by addresses designated with minter and burner roles
///
abstract contract SafeERC20Mint is SafeERC20BurnableToken,
    PausableAccessControl
{
    using SafeMath for uint256;

    //using LogicConstraints for bool;
    using AddressLogic for address;
    //using uint256Constraints for uint256;
    
    //using stringUtilities for string;
    
    bytes32 public constant ROLE_MINTER = keccak256("SafeERC20Mint.ROLE_MINTER");
    bytes32 public constant ROLE_BURNER = keccak256("SafeERC20Mint.ROLE_BURNER");
    
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
        //string memory version,
        uint256 initialSupply
    )internal 
        //ERC20AccessControlToken(name,symbol,0)
        SafeERC20BurnableToken(
            name,
            symbol
        )
        PausableAccessControl()
    {
        //tokenCap.requireGreaterThanOrEqual(
            //initialSupply,
            //_NAME.concatenate("initial supply > cap")
        //);
        
        address sender = _msgSender();
        
        _setupRole(ROLE_MINTER, sender);
        _setupRole(ROLE_BURNER, sender);
        
        //_registerInterface(type(iSafeERC20Mint).interfaceId);
        
        if(initialSupply > 0){
            _mint(sender, initialSupply);
        }
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
        
        super._beforeTokenTransfer(
            from,
            to,
            amount
        );
    }
}