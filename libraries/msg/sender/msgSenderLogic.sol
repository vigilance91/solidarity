// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;

import "https://github.com/vigilance91/solidarity/libraries/address/addressLogic.sol";

/// @title msg.sender Logic
/// @author Tyler R. Drury - 27/4/2021, All Rights Reserved
/// @notice trivial library for logical operations on the sender of a message to a contract,
/// which is not provided natively by Solidity
library MsgSenderBalanceUint256Logic
{
    using addressLogic for uint256;
    using Address for address payable;
    /**
    *RHS operatnd type uint256
    */
    function senderEqual(
        address account
    )internal pure returns(
        bool ret
    ){
        return msg.sender.equal(account);
    }
    // lhs.balance != rhs.balance
    function senderNotEqual(
        address account
    )internal pure returns(
        bool
    ){
        return msg.sender.notEqual(account);
    }
    //function senderNotNull(
    //)internal pure returns(
        //bool ret
    //){
        //return msg.sender.notNull();
    //}
    
    function senderIsContract(
    )internal pure returns(
        bool
    ){
        //senderNotNull();
        return msg.sender.isContract();
    }
    function senderIsNotContract(
    )internal pure returns(
        bool
    ){
        return msg.sender.isContract() == false;
    }
}