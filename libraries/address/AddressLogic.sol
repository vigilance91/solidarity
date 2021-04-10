// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
///
/// @title Address Logic Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 18/2/2021, All Rights Reserved
/// @notice trivial library for logical or bitwise operations on addresses not provided natively by Solidity
///
library AddressLogic
{
    address public constant NULL = address(0);
    // compare addresses and address related logic/binary/bitwise operations
    function equal(
        address lhs,
        address rhs
    )public pure returns(
        bool
    ){
        //return uint256(lhs) ^ uint256(rhs) == 0;
        return lhs == rhs;
    }
    
    function notEqual(
        address lhs,
        address rhs
    )public pure returns(
        bool
    ){
        //return uint256(lhs) ^ uint256(rhs) != 0;
        return lhs != rhs;
    }
    
    function isNull(
        address lhs
    )public pure returns(
        bool
    ){
        return equal(lhs, NULL);
    }
    
    function isNotNull(
        address lhs
    )public pure returns(
        bool
    ){
        return notEqual(
            lhs,
            NULL
        );
    }
    function isNotNullAndNotEqual(
        address lhs,
        address rhs
    )public pure returns(
        bool
    ){
        return isNotNull(
            lhs
        ) && isNotNull(
            rhs
        ) && notEqual(lhs,rhs);
    }
    
    function isNotNullAndAreEqual(
        address lhs,
        address rhs
    )public pure returns(
        bool
    ){
        return isNotNull(
            lhs
        ) && isNotNull(
            rhs
        ) && equal(lhs,rhs);
    }
    //function isMsgSender(
        //address account
    //) public view returns(
        //bool
    //){
        //return isNotNullAndAreEqual(msg.sender, account);
    //}
    function isNotMsgSender(
        address account
    )public view returns(
        bool
    ){
        return isNotNullAndNotEqual(msg.sender, account);
    }
    //function isNotThisAndNotNullArray(
        //address self,
        //address[] memory container
    //)public pure
    //{
        //bool ret = true;
        
        //for(uint256 i = 0; i < container.length; i++){
            //address rhs = container[i];
            //if(!isNotThisAndNotNull(self, rhs) || equal(self, rhs)){
                //ret = false;
                //break;
            //}
        //}
        //return ret;
    //}
    /**
    //function and(
        //address lhs,
        //address rhs
    //)public pure returns(
        //address
    //){
        //return address(uint256(lhs) & uint256(rhs));
    //}
    //function or(
        //address lhs,
        //address rhs
    //)public pure returns(
        address
    //){
        //return address(uint256(lhs) | uint256(rhs));
    //}
    //function xor(
        //address lhs,
        //address rhs
    //)public pure returns(
        //address
    //){
        //return address(uint256(lhs) ^ uint256(rhs));
    //}
    //function not(
        //address lhs
    //)public pure returns(
        address
    //){
        //return address(!uint256(lhs));
    //}
    */   
}