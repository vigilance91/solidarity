// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/nonces/mixinNonces.sol";
///
/// @title Nonces Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 7/5/2021, All Rights Reserved
/// @dev provides the derived implementation with account based nonces and the corresponding internal operations
///
abstract contract NoncesABC
{
    using addressToString for address;
    using uint256ToString for uint256;
    
    using stringUtilities for string;
    
    constructor(
    )internal{
    }
    function _currentNonce(
        address account
    )internal view returns(
        uint256
    ){
        return mixinNonces.currentNonce(account);
    }
    function _nonces(
    )internal view returns(
        mapping(address=>Counters.Counter) storage
    ){
        return mixinNonces.nonces(); //[account].nonces;
    }
    
    function _incrementNonce(
        address account
    )internal
    {
        return mixinNonces.increment(account);
    }
    
    //function _decrementNonce(
        //address account
    //)internal
    //{
        //return mixinNonces.decrement(account);
    //}
    
    function _asHexAndSalt(
        address account
    )internal view returns(
        string memory
    ){
        return account.hexadecimal().concatenate(
            _currentNonce(account).hexadecimal()
        );
    }
}