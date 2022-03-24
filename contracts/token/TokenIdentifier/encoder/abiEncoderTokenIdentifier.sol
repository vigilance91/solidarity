// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC20 Transaction ABI Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 27/8/2021, All Rights Reserved
/// convenience library for creating encoded signatures for low-level address call operations
///
library abiEncoderTokenIdentifier
{
    //string private constant _NAME = ' abiEncoderTokenIdentifier: ';
    //
    //void getter signatures, these signatures are always the same, so precompute them
    //
    bytes public constant SIG_NAME = abi.encodeWithSignature('name()');
    bytes public constant SIG_SYMBOL = abi.encodeWithSignature('symbol()');
    //
    ////string public constant _STUB_INITIALIZE = 'initialize(string,string)';
    //string public constant _STUB_INITIALIZE_BYTES = 'initialize(bytes)';
    /* 
    /// @return {bytes} signature used for a call to a external address or proxy which support the TokenIdentifier interface
    /// 
    function name(
    )internal pure returns(
        bytes memory
    ){
        return SIG_NAME;
    }
    ///
    /// @return {bytes} signature used for a call to a external address or proxy which support the TokenIdentifier interface
    ///
    function symbol(
    )internal pure returns(
        bytes memory
    ){
        return SIG_SYMBOL;
    }
    //function initialize(
        //bytes calldata data
    //)internal pure returns(
        //bytes memory
    //){
        //return ;
    //}
    
    //function initialize(
        //string calldata name,
        //string calldata symbol
    //)internal pure returns(
        //bytes memory
    //){
        //return ;
    //}
    */
}