// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @dev Interface for encoding Apoptosis function call payloads
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/4/2021, All Rights Reserved
///
interface iEncoderApoptosis
{
    /// @return {bytes} payload for calling apoptosis on an external contract or proxy
    function apoptosis(
    )external pure returns(
        bytes memory
    );
}