// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC20 Transaction ABI Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 27/8/2021, All Rights Reserved
/// convenience library for creating encoded signatures for low-level address call operations
///
library abiEncoderERC20
{
    //using frameworkERC165 for address;
    
    //string private constant _NAME = ' encoderERC20: ';
    
    //bytes private constant _ERC20_RECEIVE_SIGNATURE = abi.encodeWithSignature('canReceiveERC20()');
    
    //bytes4 private constant _iERC20_ID = type(iERC20).interfaceId;
    //bytes4 private constant _iSTATIC_TOKEN_SUPPLY_ID = type(iStaticTokenSupply).interfaceId;
    //bytes4 private constant _iTOKEN_IDENTIFIER_ID = type(iTokenIdentifier).interfaceId;
    //
    //getter stubs
    //
    //string internal constant _STUB_NAME = 'name()';
    //string internal constant _STUB_SYMBOL = 'symbol()';
    string internal constant _STUB_TOTAL_SUPPLY = 'totalSupply()';
    //
    //void getter signatures, these signatures are always the same, so precompute them
    //
    //bytes public constant SIG_NAME = abi.encodeWithSignature(_STUB_NAME);
    //bytes public constant SIG_SYMBOL = abi.encodeWithSignature(_STUB_SYMBOL);
    bytes public constant SIG_TOTAL_SUPPLY = abi.encodeWithSignature(_STUB_TOTAL_SUPPLY);
    //
    //
    //
    string public constant STUB_BALANCE_OF = 'balanceOf(address)';
    string public constant STUB_ALLOWANCE = 'allowance(address,address)';
    //
    string public constant STUB_APPROVE = 'approve(address,uint256)';
    string public constant STUB_TRANSFER = 'transfer(address,uint256)';
    string public constant STUB_TRANSFER_FROM = 'transferFrom(address,address,uint256)';
    
    /// @return {uint256} amount of tokens in existence
    //function totalSupply(
        //address token
    //)public pure returns(
        //uint256
    //){
        //_requireSupportsTokenSupplyInterface(token);
        //
        //return iStaticTokenSupply(token).totalSupply();
    //}
    
    /// @return {uint256} amount of tokens owned by `account`
    function balanceOf(
        address account
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_BALANCE_OF,
            account
        );
    }
    ///
    /// @dev Moves `amount` tokens from the caller's account to `recipient`
    /// @return {bool} true if the operation succeeded, otherwise false
    ///
    function transfer(
        address recipient,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_TRANSFER,
            recipient,
            amount
        );
    }
    ///
    /// @return {bytes} binary encoded transaction payload repressenting an `allowance` call to an ERC20 token
    ///
    function allowance(
        address owner,
        address spender
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_ALLOWANCE,
            owner,
            spender
        );
    }
    ///
    /// @return {bytes} binary encoded transaction payload repressenting a `approve` call to an ERC20 token
    ///
    function approve(
        address spender,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_APPROVE,
            spender,
            amount
        );
    }
    ///
    /// @return {bytes} binary encoded transaction payload repressenting a `transferFrom`  call to an ERC20 token
    ///
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_TRANSFER_FROM,
            sender,
            recipient,
            amount
        );
    }
}