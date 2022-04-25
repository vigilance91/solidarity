// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC-165 Batched Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 25/3/2022, All Rights Reserved
///
interface iERC165Batched
{
    function supportsInterfaces(
        bytes4[] calldata interfaceIds
    )external view returns(
        bool[] memory
    );
}