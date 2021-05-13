// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/mortal/ERC20/MortalPermissionERC20Token.sol";

/**
interface iMortalERC20Burnable is iMortalERC20
{
    function burn(
        uint256 amount
    )external;
    
    function burnFrom(
        address account,
        uint256 amount
    )external;
}
*/

///
/// @title Mortal Permission ERC20 Burnable Token
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 13/5/2021, All Rights Reserved
/// @dev non-standard {ERC20} extension of SafeERC20BurnableToken which supports Apoptosis
///
abstract contract MortalPermissionERC20BurnableToken is MortalPermissionERC20Token
    //iERC20Burnable
{
    using SafeMath for uint256;
    
    using uint256Constraints for uint256;
    using AddressConstraints for address;
    
    constructor(
        string memory name,
        string memory symbol
        //uint256 totalSupply
    )internal MortalPermissionERC20Token(name, symbol)
    {
        //_registerInterface(type(iERC20Burnable).interfaceId);
        
        //if(totalSupply > 0){
            //_mint(_msgSender(), totalSupply);
        //}
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
    )external virtual nonReentrant
    {
        _burn(
            _msgSender(),
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
    )external virtual nonReentrant
    {
        address sender = _msgSender();
        
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
}