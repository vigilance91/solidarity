// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

//import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

//import "https://github.com/vigilance91/solidarity/libraries/msg/sender/msgSenderLogic.sol";
/// 
/// @title msg.sender Contraints
/// @author Tyler R. Drury - 27/4/2021, All Rights Reserved
/// @notice trivial utilities for constraining the state of the EVM (using require)
/// based on the value of msg.sender
/// 
library msgSenderConstraints
{
    using LogicConstraints for bool;
    //using addressConstraints for address payable;
    
    function requireSenderEqual(
        address rhs
    )internal view
    {
        msgSenderLogicEqual(rhs).requireTrue(
        );
    }
    function requireSenderNotEqual(
        address rhs
    )internal view
    {
        msgSenderLogicNotEqual(rhs).requireTrue(
        );
    }
    //function requireSenderNotNull(
    //)internal pure
    //{
        //msg.sender.requireNotNull(
        //);
    //}
    function requireSenderIsContract(
    )internal pure returns(
        bool
    ){
        msgSenderLogic.isContract().requireTrue(
        );
    }
    function senderIsNotContract(
    )internal pure returns(
        bool
    ){
        return msgSenderLogic.isNotContract().requireTrue(
        );
    }
}