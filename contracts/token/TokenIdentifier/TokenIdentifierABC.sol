// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";

import "./iTokenIdentifier.sol";
import "./mixinTokenIdentifier.sol";
///
/// @title Token Intentifier ABC
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev abstract base contract for a Token composed of a name and a symbol
///
abstract contract TokenIdentifierABC is iTokenIdentifier
{
    //using LogicConstraints for bool;
    using AddressConstraints for address;
    
    constructor(
        string memory name,
        string memory symbol
    )internal
    {
        mixinTokenIdentifier.initialize(
            name,
            symbol
        );
    }
    /**
    function _tokenIdentifierStorage(
    )private pure returns(
        mixinTokenIdentifier.TokenIdentifierStorage storage
    ){
        return mixinTokenIdentifier.storageTokenIdentifier();
    }
    */
    /// @return {string} full name of the token
    function name(
    )public view override returns(
        string memory
    ){
        return mixinTokenIdentifier.name();
    }
    /// @return {string} short version of the name/token symbol, shuld be 2-6 letters
    function symbol(
    )public view override returns(
        string memory
    ){
        return mixinTokenIdentifier.symbol();
    }
}