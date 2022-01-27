// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC-173 Ownership Transaction Encoder Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
///
interface iEncoderERC173
{
    function owner(
    )external pure returns(
        bytes memory
    );
    //function ownerPayable(
    //)external view returns(
        //bytes memory
    //);
    
    function renounceOwnership(
    )external pure returns(
        bytes memory
    );
    
    function transferOwnership(
        address newOwner
    )external pure returns(
        bytes memory
    );
}