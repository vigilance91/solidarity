// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/frameworkERC20.sol";

//import "https://github.com/vigilance91/solidarity/ERC/token/ERC20/iERC20.sol";
///
/// @title Batched ERC20 Transaction Framework Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 11/12/2021, All Rights Reserved
///
library frameworkBatchedERC20
{
    //using logicConstraints for bool;
    //using addressConstraints for address;
    
    //using Address for address;
    
    using frameworkERC20 for address;
    
    //string private constant _NAME = ' frameworkBatchedERC20: ';
    
    //bytes private constant _ERC20_RECEIVE_SIGNATURE = abi.encodeWithSignature('canReceiveERC20()');
    
    //bytes4 private constant _iERC20_ID = type(iERC20).interfaceId;
    //bytes4 private constant _iSTATIC_TOKEN_SUPPLY_ID = type(iStaticTokenSupply).interfaceId;
    //bytes4 private constant _iTOKEN_IDENTIFIER_ID = type(iTokenIdentifier).interfaceId;
    
    //function _requireNonZeroAndEqual(
        //uint lhs,
        //uint rhs
    //){
        //lhs.requireGreaterThanZero();
        //lhs.requireEqual(rhs);
    //}
    /// @return {string} token name
    function names(
        address[] memory tokens
    )internal view returns(
        string[] memory names
    ){
        tokens.length.requireGreaterThanZero();
        
        names = new string[](tokens.length);
        
        for(uint i; i < tokens.length; i++){
            names[i] = tokens[i].name();
        }
    }
    /// @return {string} tokens symbol, 2-6 characters
    function symbols(
        address[] memory tokens
    )internal view returns(
        string[] memory symbols
    ){
        tokens.length.requireGreaterThanZero();
        
        symbols = new string[](tokens.length);
        
        for(uint i; i < tokens.length; i++){
            symbols[i] = token.symbol();
        }
    }
    /// @return {uint256} amount of tokens in existence
    function totalSupply(
        address[] memory tokens
    )internal view returns(
        uint256[] memory totalSupplies
    ){
        tokens.length.requireGreaterThanZero();
        
        totalSupplies = new uint256[](tokens.length);
        
        for(uint256 i; i < tokens.length; i++){
            totalSupplies[i] = token.totalSupply();
        }
    }
    
    /// @return {uint256} amount of tokens owned by `account` for each token in `tokens`
    function balanceOf(
        address[] memory tokens,
        address account
    )internal view returns(
        uint256[] memory balances
    ){
        tokens.length.requireGreaterThanZero();
        
        balances = new uint256[](tokens.length);
        
        for(uint256 i; i < tokens.length; i++){
            balances[i] = tokens[i].balanceOf(account);
        }
    }
    /// @return {uint256} get amount of `token` for each account in `account`
    function balanceOf(
        address token,
        address[] memory accounts
    )internal view returns(
        uint256[] memory balances
    ){
        accounts.length.requireGreaterThanZero();
        
        balances = new uint256[](accounts.length);
        
        for(uint256 i; i < accounts.length; i++){
            balances[i] = token.balanceOf(accounts[i]);
        }
    }
    // @return {uint256[]} for each token in `tokens` get the balance of the corresponding index in `accounts`
    function balanceOf(
        address[] memory tokens,
        address[] memory accounts
    )internal view returns(
        uint256[] memory balances
    ){
        //_requireNonZeroAndEqual(tokens.length, accounts.length);
        tokens.length.requireGreaterThanZero();
        tokens.requireEqual(
            accounts.length
            //_NAME.concatenate("")
        );
        
        balances = new uint256[](tokens.length);
        
        for(uint i; i < tokens.length; i++){
            balances[i] = tokens[i].balanceOf(accounts[i]);
        }
    }
    ///
    /// @dev atomic for each token in tokens, moves `amount` of tokens from the calling contract to `recipient`
    ///
    function transfer(
        address[] memory tokens,
        address recipient,
        uint256 amount
    )internal returns(
        bool
    ){
        tokens.length.requireGreaterThanZero();
        
        for(uint i; i < tokens.length; i++){
            tokens[i].transfer(recipient, amount).requireTrue(
                //NAME.concatenate("batch transfer failed)
            );
        }
        
        return true;
    }
    /// 
    /// @dev atomic for each token in tokens, moves `amount` of tokens from the calling contract to `recipient`
    /// 
    function transfer(
        address[] memory tokens,
        address[] memory recipients,
        uint256 amount
    )internal returns(
        bool
    ){
        //_requireNonZeroAndEqual(tokens.length, recipients.length);
        
        for(uint i; i < tokens.length; i++){
            tokens[i].transfer(recipients[i], amount).requireTrue(
                //NAME.concatenate("batch transfer failed)
            );
        }
        
        return true;
    }
    ///
    /// @dev atomic for each token in tokens, moves `amount` of tokens from the calling contract to `recipient`
    ///
    function transfer(
        address[] memory tokens,
        address recipient,
        uint256[] memory amounts
    )internal returns(
        bool
    ){
        //_requireNonZeroAndEqual(tokens.length, amounts.length);
        tokens.length.requireGreaterThanZero();
        tokens.length.requireEqual(
            amounts.length
        );
        
        for(uint i; i < tokens.length; i++){
            tokens[i].transfer(recipient, amounts[i]).requireTrue(
                //NAME.concatenate("batch transfer failed)
            );
        }
        
        return true;
    }
    ///
    /// @dev atomic transfer each `recipient` in `recipients` `amount` of `token` from the calling contract
    ///
    function transfer(
        address token,
        address[] memory recipients,
        uint256 amount
    )internal returns(
        bool
    ){
        recipients.length.requireGreaterThanZero();
        //ret = new bool[](0);
        
        for(uint i; i < tokens.length; i++){
            token.transfer(recipient, amount).requireTrue(
                //NAME.concatenate("batch transfer failed)
            );
        }
        
        return true;
    }
    ///
    /// @dev atomic transfer each `recipient` in `recipients` `amount` of `token` from the calling contract
    ///
    function transfer(
        address token,
        address[] memory recipients,
        uint256[] memory amounts
    )internal returns(
        bool
    ){
        //_requireNonZeroAndEqual(recipients.length, amounts.length);
        recipients.length.requireGreaterThanZero();
        recipients.length.requireEqual(
            amounts.length
        );
        //ret = new bool[](0);
        
        for(uint i; i < tokens.length; i++){
            token.transfer(recipients[i], amounts[i]).requireTrue(
                //NAME.concatenate("batch transfer failed)
            );
        }
        
        return true;
    }
    function transfer(
        address[] memory tokens,
        address[] memory recipient,
        uint256[] memory amounts
    )internal returns(
        bool
    ){
        //_requireNonZeroAndEqual(tokens.length, recipients.length);
        tokens.length.requireEqual(recipients.length);
        tokens.length.requireEqual(amounts.length);
        
        for(uint i; i < tokens.length; i++){
            tokens[i].transfer(recipients[i], amounts[i]).requireTrue(
                //NAME.concatenate("batch transfer failed)
            );
        }
        
        return true;
    }
    ///
    /// @dev return {uint256} amount of tokens `spender` is allowed to spend/withdrawl on behalf of `owner` through {transferFrom}
    ///
    /// NOTE:
    ///     this value is zero by default and
    ///     changes when {approve}, {increaseAllownace}, {decreaseAllowance} or {transferFrom} are called
    ///
    function allowance(
        address[] memory tokens,
        address owner,
        address spender
    )internal view returns(
        uint256[] memory allowances
    ){
        tokens.length.requireGreaterThanZero();
        
        allowances = new uint256[](0);
        
        for(uint i; i < tokens.length; i++){
            allowances[i] = tokens[i].allowance(owner, spender);
        }
    }
    ///
    /// @dev return {uint256} amount of tokens `spender` is allowed to spend/withdrawl on behalf of `owner` through {transferFrom}
    ///
    function allowance(
        address token,
        address[] memory owners,
        address spender
    )internal view returns(
        uint256[] memory allowances
    ){
        owners.length.requireGreaterThanZero();
        
        allowances = new uint256[](0);
        
        for(uint i; i < owners.length; i++){
            allowances[i] = token.allowance(
                owners[i],
                spender
            );
        }
    }
    ///
    /// @dev return {uint256} amount of tokens `spender` is allowed to spend/withdrawl on behalf of `owner` through {transferFrom}
    ///
    function allowance(
        address token,
        address owner,
        address[] memory spenders
    )internal view returns(
        uint256[] memory allowances
    ){
        spenders.length.requireGreaterThanZero();
        
        allowances = new uint256[](spenders.length);
        
        for(uint i; i < owners.length; i++){
            allowances[i] = token.allowance(
                owner,
                spenders[i]
            );
        }
    }
    function allowance(
        address[] memory tokens,
        address[] memory owners,
        address spender
    )internal view returns(
        uint256[] memory allowances
    ){
        //_requireNonZeroAndEqual(tokens.length, owners.length);
        tokens.length.requireGreaterThanZero();
        tokens.length.requireEqual(
            owners.length
            //_NAME.concatenate("")
        );
        
        allowances = new uint256[](tokens.length);
        
        for(uint i; i < tokens.length; i++){
            allowances[i] = tokens[i].allowance(
                owners[i],
                spender
            );
        }
    }
    function allowance(
        address[] memory tokens,
        address owner,
        address[] memory spenders
    )internal view returns(
        uint256[] memory allowances
    ){
        //_requireNonZeroAndEqual(tokens.length, spenders.length);
        tokens.length.requireGreaterThanZero();
        tokens.length.requireEqual(
            spenders.length
            //_NAME.concatenate("")
        );
        
        allowances = new uint256[](tokens.length);
        
        for(uint i; i < tokens.length; i++){
            allowances[i] = tokens[i].allowance(
                owner,
                spenders[i]
            );
        }
    }
    function allowance(
        address[] memory tokens,
        address[] memory owners,
        address[] memory spenders
    )internal view returns(
        uint256[] memory allowances
    ){
        //_requireNonZeroAndEqual(tokens.length, owners.length);
        tokens.length.requireGreaterThanZero();
        tokens.length.requireEqual(
            owners.length
            //_NAME.concatenate("")
        );
        tokens.length.requireEqual(
            spender.length
            //_NAME.concatenate("")
        );
        
        allowances = new uint256[](tokens.length);
        
        for(uint i; i < tokens.length; i++){
            allowances[i] = tokens[i].allowance(
                owners[i],
                spenders[i]
            );
        }
    }
    ///
    /// @dev Sets `amount` as the allowance of `spender` over the caller's tokens
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    function approve(
        address[] memory tokens,
        address spender,
        uint256 amount
    )internal returns(
        bool
    ){
        tokens.length.requireGreaterThanZero();
        
        for(uint i; i < tokens.length; i++){
            tokens[i].approve(spender, amount);
        }
        
        return true;
    }
    ///
    /// @dev Sets `amount` as the allowance of `spender` over the caller's tokens
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    function approve(
        address token,
        address[] memory spenders,
        uint256 amount
    )internal returns(
        bool
    ){
        spenders.length.requireGreaterThanZero();
        
        for(uint i; i < spenders.length; i++){
            token.approve(spenders[i], amount);
        }
        
        return true;
    }
    ///
    /// @dev Sets `amount` as the allowance of `spender` over the caller's tokens
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    function approve(
        address token,
        address[] memory spenders,
        uint256[] memory amounts
    )internal returns(
        bool
    ){
        //_requireNonZeroAndEqual(spenders.length, amounts.length);
        spenders.length.requireGreaterThanZero();
        spenders.length.requireEqual(amounts.length);
        
        for(uint i; i < spenders.length; i++){
            token.approve(spenders[i], amounts[i]);
        }
        
        return true;
    }
    ///
    /// @dev Sets `amount` as the allowance of `spender` over the caller's tokens
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    function approve(
        address[] memory tokens,
        address[] memory spenders,
        uint256 amount
    )internal returns(
        bool
    ){
        //_requireNonZeroAndEqual(tokens.length, spenders.length);
        tokens.length.requireGreaterThanZero();
        tokens.length.requireEqual(spenders.length);
        
        for(uint i; i < tokens.length; i++){
            tokens[i].approve(spenders[i], amount); //.requireTrue(
                //"_NAME.concatenate("")
            //);
        }
    }
    ///
    /// @dev Sets `amount` as the allowance of `spender` over the caller's tokens
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    function approve(
        address[] memory tokens,
        address spender,
        uint256[] memory amounts
    )internal returns(
        bool
    ){
        //_requireNonZeroAndEqual(tokens.length, amounts.length);
        tokens.length.requireGreaterThanZero();
        tokens.length.requireEqual(amounts.length);
        
        for(uint i; i < tokens.length; i++){
            tokens[i].approve(spender, amounts[i]); //.requireTrue(
                //"_NAME.concatenate("")
            //);
        }
        
        return true;
    }
    ///
    /// @dev Sets `amount` as the allowance of `spender` over the caller's tokens
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    function approve(
        address[] memory tokens,
        address[] memory spenders,
        uint256[] memory amounts
    )internal returns(
        bool
    ){
        //_requireNonZeroAndEqual(tokens.length, spenders.length);
        tokens.length.requireGreaterThanZero();
        tokens.length.requireEqual(spenders.length);
        tokens.length.requireEqual(amounts.length);
        
        for(uint i; i < tokens.length; i++){
            tokens[i].approve(spenders[i], amounts[i]); //.requireTrue("approve failed");
        }
        
        return true;
    }
    ///
    /// @dev Move `amount` tokens from `sender` to `recipient` for each token in `tokens`
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    function transferFrom(
        address[] memory tokens,
        address sender,
        address recipient,
        uint256 amount
    )internal
    {
        tokens.length.requireGreaterThanZero();
        
        for(uint i; i < tokens.length; i++){
            tokens[i].transferFrom(
                sender,
                recipient,
                amount
            ).requireTrue(
                //_NAME.concatenate("")
            );
        }
    }
    //transferFrom multiple `senders` `amount` of `token` to a single `recipient`
    function transferFrom(
        address token,
        address[] memory senders,
        address recipient,
        uint256 amount
    )internal returns(
        bool
    ){
        senders.length.requireGreaterThanZero();
        
        for(uint i; i < senders.length; i++){
            token.transferFrom(
                senders[i],
                recipient,
                amount
            ).requireTrue(
                //_NAME.concatenate("")
            );
        }
        
        return true;
    }
    //transferFrom single `token` from multiple {sender, amount} pairs, to a single `recipient`
    function transferFrom(
        address token,
        address[] memory senders,
        address recipient,
        uint256[] memory amounts
    )internal returns(
        bool
    ){
        senders.length.requireGreaterThanZero();
        
        for(uint i; i < senders.length; i++){
            token.transferFrom(
                senders[i],
                recipient,
                amounts[i]
            ).requireTrue(
                //_NAME.concatenate("")
            );
        }
        
        return true;
    }
    //transferFrom single `sender`, single `token`, for multiple {recipient, amount} pairs
    function transferFrom(
        address token,
        address sender,
        address[] memory recipients,
        uint256[] memory amounts
    )internal returns(
        bool
    ){
        //_requireNonZeroAndEqual(tokens.length, amounts.length);
        recipients.length.requireGreaterThanZero();
        recipients.length.requireEqual(amounts);
        
        for(uint i; i < senders.length; i++){
            token.transferFrom(
                sender,
                recipients[i],
                amounts[i]
            ).requireTrue(
                //_NAME.concatenate("")
            );
        }
        
        return true;
    }
    //transferFrom single `sender` for each token in `tokens`, for multiple recipients with the same amount
    function transferFrom(
        address[] memory tokens,
        address sender,
        address[] memory recipients,
        uint256 amount
    )internal returns(
        bool
    ){
        //_requireNonZeroAndEqual(tokens.length, recipients.length);
        tokens.length.requireGreaterThanZero();
        tokens.length.requireEqual(recipients);
        
        for(uint i; i < senders.length; i++){
            token.transferFrom(
                sender,
                recipients[i],
                amount
            ).requireTrue(
                //_NAME.concatenate("")
            );
        }
        
        return true;
    }
    //transferFrom multiple {sender, amount} for a single `recipient` for each token in `tokens`
    function transferFrom(
        address[] memory tokens,
        address[] memory senders,
        address recipient,
        uint256[] memory amounts
    )internal returns(
        bool
    ){
        //_requireNonZeroAndEqual(tokens.length, spenders.length);
        tokens.length.requireGreaterThanZero();
        tokens.length.requireEqual(senders);
        tokens.length.requireEqual(amounts);
        
        for(uint i; i < senders.length; i++){
            token.transferFrom(
                senders[i],
                recipient,
                amounts[i]
            ).requireTrue(
                //_NAME.concatenate("")
            );
        }
        
        return true;
    }
    //transferFrom multiple {sender, recipient, amount} for a single `token`
    function transferFrom(
        address token,
        address[] memory senders,
        address[] memory recipients,
        uint256[] memory amounts
    )internal returns(
        bool
    ){
        //_requireNonZeroAndEqual(spenders.length, recipients.length);
        senders.length.requireGreaterThanZero();
        senders.length.requireEqual(recipients.length);
        senders.length.requireEqual(amounts.length);
        
        for(uint i; i < senders.length; i++){
            token.transferFrom(
                senders[i],
                recipients[i],
                amounts[i]
            ).requireTrue(
                //_NAME.concatenate("")
            );
        }
        
        return true;
    }
    //transferFrom for each {token, sender, recipient, amount} in `tokens`, `senders`, `recipients`, `amounts`
    // tokens, senders, recipients, amounts must have the same length
    function transferFrom(
        address[] memory tokens,
        address[] memory senders,
        address[] memory recipients,
        uint256[] memory amounts
    )internal returns(
        bool
    ){
        //_requireNonZeroAndEqual(spenders.length, recipients.length);
        senders.length.requireGreaterThanZero();
        senders.length.requireEqual(recipients.length);
        senders.length.requireEqual(amounts.length);
        
        for(uint i; i < senders.length; i++){
            tokens[i].transferFrom(
                senders[i],
                recipients[i],
                amounts[i]
            ).requireTrue(
                //_NAME.concatenate("")
            );
        }
        
        return true;
    }
}