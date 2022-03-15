// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

interface iERC173View
{
    function owner(
    )external view returns(
        address
    );
    //function ownerPayable(
    //)external view returns(
        //address payable
    //);
}

interface iERC173Mutable
{
    function renounceOwnership(
    )external;
    
    function transferOwnership(
        address newOwner
    )external;
}
///
/// @title ERC-173 Ownership interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/3/2021, All Rights Reserved
///
interface iERC173 //is iERC173View, iERC173Mutable
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