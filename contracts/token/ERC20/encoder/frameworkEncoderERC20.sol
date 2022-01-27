// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/encoder/iEncoderERC20.sol";
///
/// @title ERC20 Encoder Framework Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
///
library frameworkEncoderERC20
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    //string private constant _NAME = ' frameworkERC20: ';
    
    //bytes private constant _ERC20_RECEIVE_SIGNATURE = abi.encodeWithSignature('canReceiveERC20()');
    
    bytes4 private constant _INTERFACE_ID = type(iEncoderERC20).interfaceId;
    //bytes4 private constant _iSTATIC_TOKEN_SUPPLY_ID = type(iStaticTokenSupply).interfaceId;
    //bytes4 private constant _iTOKEN_IDENTIFIER_ID = type(iTokenIdentifier).interfaceId;
    
    function _requireSupportsInterface(
        address token
    )private
    {
        token.requireNotNull();
        token.isContract().requireTrue(
            'address not a contract'
        );
        
        token.supportsInterface(_INTERFACE_ID).requireTrue(
            'contract does not implement iEncoderERC20'
        );
    }
    /**
    function _requireSupportsTokenIdentifierInterface(
        address token
    )private
    {
        token.requireNotNull();
        token.isContract().requireTrue(
            'address not a contract'
        );
        
        token.supportsInterface(_iTOKEN_IDENTIFIER_ID).requireTrue(
            'contract does not implement iTokenIdentifier'
        );
    }
    function _requireSupportsTokenIdentifierInterface(
        address token
    )private
    {
        token.requireNotNull();
        token.isContract().requireTrue(
            'address not a contract'
        );
        
        token.supportsInterface(_iSTATIC_TOKEN_SUPPLY_ID).requireTrue(
            'contract does not implement iTokenSupply'
        );
    }
    */
    /// @return {string} token name
    //function name(
        //address token
    //)public view returns(
        //string memory
    //){
        //_requireSupportsTokenIdentifierInterface(token);
        //
        //return iTokenIdentifier(token).name();
    //}
    /// @return {string} tokens symbol, 2-6 characters
    //function symbol(
        //address token
    //)public view returns(
        //string memory
    //){
        //_requireSupportsTokenIdentifierInterface(token);
        //
        //return iTokenIdentifier(token).symbol();
    //}
    /// @return {uint256} amount of tokens in existence
    //function totalSupply(
        //address token
    //)public view returns(
        //uint256
    //){
        //_requireSupportsTokenSupplyInterface(token);
        //
        //return iStaticTokenSupply(token).totalSupply();
    //}
    
    /// @return {uint256} amount of tokens owned by `account`
    function balanceOf(
        address token,
        address account
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(token);
        
        return iEncoderERC20(token).balanceOf(account);
        /**
        (bool success, bytes memory result) = recipient.staticcall(
            abi.encodeWithSignature(
                'balanceOf(address)',
                account
            )
        );
        
        success.requireTrue('balanceOf: call failed');
        
        (uint256 ret) = abi.decode(result, (uint256));
        
        return ret;
        */
    }
    ///
    /// @dev Moves `amount` tokens from the caller's account to `recipient`
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    function transfer(
        address token,
        address recipient,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(token);
        
        return iEncoderERC20(token).transfer(recipient, amount);
    }
    ///
    /// @dev return {uint256} amount of tokens `spender` is allowed to spend/withdrawl on behalf of `owner` through {transferFrom}
    ///
    /// NOTE:
    ///     this value is zero by default and
    ///     changes when {approve}, {increaseAllownace}, {decreaseAllowance} or {transferFrom} are called
    ///
    function allowance(
        address token,
        address owner,
        address spender
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(token);
        
        return iEncoderERC20(token).allownace(owner,spender);
    }
    ///
    /// @dev Sets `amount` as the allowance of `spender` over the caller's tokens
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    function approve(
        address token,
        address spender,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(token);
        
        return iEncoderERC20(token).approve(spender, amount);
    }
    ///
    /// @dev Move `amount` tokens from `sender` to `recipient`
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    function transferFrom(
        address token,
        address sender,
        address recipient,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(token);
        
        return iEncoderERC20(token).transferFrom(sender, recipient, amount);
    }
}