// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/mortal/ERC20/MortalERC20BurnableToken.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/supplyCap/StaticSupplyCapABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/PausableAccessControl.sol";

//interface iERC20Mint is iERC20,
// iPausable
//{
//}

///
/// @title Mortal ERC20 Static Cap Mint Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 6/5/2021, All Rights Reserved
/// @dev ERC20 token with pausable token transfers and a static (immutable) supply cap
/// the supply cap can not be changed after contract deployment,
/// new tokens can still be minted so long as the total supply remains less than supply cap
/// and token transfers to contracts which do NOT implement ERC20Receiver interface will fail and revert state,
/// preventing the unrecoverable loss of tokens
///
abstract contract MortalERC20StaticCapMint is MortalERC20BurnableToken,
    PausableAccessControl,
    StaticSupplyCapABC
{
    using SafeMath for uint256;

    //using LogicConstraints for bool;
    //using AddressLogic for address;
    //using uint256Constraints for uint256;
    
    //using stringUtilities for string;
    
    bytes32 public constant ROLE_MINTER = keccak256("SafeERC20StaticCapMint.ROLE_MINTER");
    bytes32 public constant ROLE_BURNER = keccak256("SafeERC20StaticCapMint.ROLE_BURNER");
    
    //string private constant _NAME = ' SafeERC20StaticCapMint: ';
    
    constructor(
        string memory name,
        string memory symbol,
        //uint initialSupply
        uint256 tokenCap
    )internal 
        //ERC20AccessControlToken(name,symbol,0)
        MortalERC20BurnableToken(
            name,
            symbol
            //tokenCap
        )
        PausableAccessControl()
        StaticSupplyCapABC(
            tokenCap
        )
    {
        //tokenCap.requireGreaterThanZero(
            //_NAME.concatenate("cap is 0")
        //);
        //tokenCap.requireGreaterThan(
            //currentSupply,
            //_NAME.concatenate("initial supply > cap")
        //);
        address sender = _msgSender();
        
        _setupRole(ROLE_MINTER, sender);
        _setupRole(ROLE_BURNER, sender);
        
        ////_registerInterface(type(iSafeERC20StaticCapMint).interfaceId);
        
        //initialSupply.requireLessThanOrEqual(tokenCap);
        //
        //if(initialSupply > 0){
            //_mint(sender, initialSupply);
        //}
    }
    ///
    /// @dev Creates `amount` new tokens for `to`
    /// See {ERC20._mint}
    /// 
    /// Requirements:
    ///     - the caller must have the `ROLE_MINTER`
    ///
    function mint(
        address to,
        uint256 amount
    )external virtual nonReentrant
        //onlyRole(ROLE_MINTER)
    {
        require(
            hasRole(ROLE_MINTER, _msgSender())
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
        
        if(from == address(0)){
            //LogicConstraints.alwaysRevert(
                //_NAME.concatenate("token supply cap cannot mutate")
            //);
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