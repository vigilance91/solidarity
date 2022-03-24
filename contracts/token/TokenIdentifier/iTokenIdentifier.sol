// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title iTokenIdentifier
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev iTokenIdentifier interface
///
interface iTokenIdentifier
{
    /// @return {string} long name of token
    function name(
    )external view returns(
        string memory
    );
    /// @return {string} short identifier of token, should be 2-6 letters
    function symbol(
    )external view returns(
        string memory
    );
}

//interface iInitializableTokenIdentifier is iTokenIdentifier
//{
    //function initilaize(bytes calldata data) external;
//}