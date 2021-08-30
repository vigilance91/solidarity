// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/encoder/abiEncoderERC165.sol";
import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/encoder/iEncoderERC165.sol";
///
/// @title ERC-165 Transaction Encoder Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
///
abstract contract EncoderERC165 is iEncoderERC165
    //ERC165
{
    using abiEncoderERC165 for bytes4;
    
    bytes4 private constant _INTERFACE_ID = type(iEncoderERC165).interfaceId;

    constructor(
    )internal
        //ERC165()
    {
        //_registerInterface(_INTERFACE_ID);
    }
    //function _supportedInterfaces(
    //)internal view returns(
        //mapping(bytes4=>bool) storage
    //){
        //return mixinERC165.supportedInterfaces();
    //}
    ///
    /// @return {bytes}
    ///
    function supportsInterface(
        bytes4 interfaceId
    )public pure override returns(
        bytes memory
    ){
        return interfaceId.supportsInterface();
    }
}