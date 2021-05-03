// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/token/ERC20/SafeERC20BurnableToken.sol";
import "https://github.com/vigilance91/solidarity/ERC/token/ERC20/mutableCap/MutableCapABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/PausableAccessControl.sol";

//interface iSafeERC20MutableCapMint is iERC20,
// iPausable
//{
//}

///
/// @title ERC20 Token Mint Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev ERC20 compliant token mint which is pausable, with a dynamic (mutable) supply cap
/// the supply cap can be increased, decreased or explicitly set after contract deployment
/// typically either by the contract owner, an admin or a trusted address othewise designated to do so
///
/// Setting a new cap explicitly or decreasing the supply cap below the total supply available
/// will cause the transaction to revert, requiring the burning of tokens (using burn or burnFrom)
/// before the supply cap can be further decreased
///
abstract contract SafeERC20MutableCapMint is SafeERC20BurnableToken,  //ERC20MutableSupplyCapToken
    PausableAccessControl
    MutableSupplyCapABC
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
        
        //_registerInterface(type(iPausable).interfaceId);
        ////_registerInterface(type(iSafeERC20MutableCapMint).interfaceId);
        
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
            hasRole(MINTER_ROLE, _msgSender())
            //_NAME.concatenate("must have minter role to mint")
        );
        _mint(to, amount);
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