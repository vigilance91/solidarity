// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC-165 Compliant Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 24/3/2021, All Rights Reserved
///
interface iERC165
{
    function supportsInterface(
        bytes4 interfaceId
    )external view returns(
        bool
    );
}