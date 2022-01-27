// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/SafeERC20Token.sol";

/**
interface iERC20Burnable is iERC20
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
/// @title Safe ERC20 Burnable Token
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev non-standard {ERC20} extension allowing token holders to destroy both their own
/// tokens and those that they have been granted an allowance for,
/// in a way that can be recognized off-chain (via event analysis)
///
/// inspired by OpenZepplin's token/ERC20/ERC20Burnable.sol, available here:
///     https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/token/ERC20/ERC20Burnable.sol
///
/// This contract has been completely rewritten from the ground up and implements solidarity's SafeERC20Token,
/// as well as addresses major logic flaws or potential security issues pressent in OpenZepplin's ERC20 implementation,
/// such as:
///     - reverting on a caller transfering tokens to themself
///     - reverting on explicit transfers to the null address
///     - performs checks on allowance functions to verify pre and post operation state
///     - reverts when attempting an unrecoverable token transfer to a non-wallet, contract address, which does not support ERC20 token transfers
///
/// thus, this software is licensed under Solidarity's Apache-2.0 license
///
/// Vigilance does not claim any ownership of the original source material by OpenZepplin and acknowldeges
/// OpenZepplin's rights in regards to ERC20Burnable.sol, as the inspiration for this contract.
///
/// As such, this contract is published as free and open source software, as permitted by the Apache-2.0 license.
/// Vigilance does not profit from the use or distribution of this contract.
///
abstract contract SafeERC20BurnableToken is SafeERC20Token
    //iERC20Burnable
{
    using SafeMath for uint256;
    
    using uint256Constraints for uint256;
    using addressConstraints for address;
    
    constructor(
        string memory name,
        string memory symbol
        //uint256 totalSupply
    )internal SafeERC20Token(name, symbol)
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