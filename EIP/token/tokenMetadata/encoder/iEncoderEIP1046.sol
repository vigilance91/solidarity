// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP-1046 ERC20 Token Metadata Extension Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 7/4/2021, All Rights Reserved
/// @dev https://eips.ethereum.org/EIPS/eip-1046 by: Tommy Nicholas, Matt Russo, John Zettler, Matt Condon
///
interface iEncoderEIP1046
{
    function tokenURI(
    )external view returns(
        bytes memory
    );
}