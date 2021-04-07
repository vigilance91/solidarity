// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC-173 Ownership interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/3/2021, All Rights Reserved
///
interface iERC173
{
    function owner(
    )external view returns(
        address
    );
    //function ownerPayable(
    //)external view returns(
        //address payable
    //);
    
    function renounceOwnership(
    )external;
    
    function transferOwnership(
        address newOwner
    )external;
}