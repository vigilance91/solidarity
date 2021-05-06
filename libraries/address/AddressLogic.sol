// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
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
    )internal pure returns(
        bool
    ){
        //return uint256(lhs)._xor(uint256(rhs)) == 0;
        return lhs == rhs;
    }
    
    function notEqual(
        address lhs,
        address rhs
    )internal pure returns(
        bool
    ){
        //return uint256(lhs)._xor(uint256(rhs)) != 0;
        return lhs != rhs;
    }
    
    function isNull(
        address lhs
    )internal pure returns(
        bool
    ){
        return equal(lhs, NULL);
    }
    
    function isNotNull(
        address lhs
    )internal pure returns(
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
    )internal pure returns(
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
    )internal pure returns(
        bool
    ){
        return isNotNull(
            lhs
        ) && isNotNull(
            rhs
        ) && equal(lhs,rhs);
    }
    //function callerIsThisContract(
    //)internal returns(
        //bool ret
    //){
        //assembly{
            //ret := eq(caller(),address())
        //}
    //}
    //function callerEquals(
        //address account
    //)internal returns(
        //bool ret
    //){
        //assembly{
            //ret := eq(caller(),account)
        //}
    //}
    
    function isNotMsgSender(
        address account
    )internal view returns(
        bool
    ){
        return isNotNullAndNotEqual(msg.sender, account);
    }
    //function isNotThisAndNotNullArray(
        //address self,
        //address[] memory container
    //)internal pure
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
    function balanceWei(
        address account
    )internal returns(
        uint256 ret
    ){
        //account.requireNotNull();
        assembly{
            ret := balance(account)
        }
    }
    function balanceEth(
        address account
    )internal returns(
        uint256 ret
    ){
        //account.requireNotNull();
        assembly{
            let BAL := balance(account)
            
            if(lt(BAL, 1e18)){
                ret := 0
                //stop()
            }
            if(or(gt(BAL, 1e18),eq(BAL,1e18))){
                ret := div(BAL, 1e18)
            }
        }
    }
    */
    /**
    //function _and(
        //address lhs,
        //address rhs
    //)internal pure returns(
        //address
    //){
        //return address(
            //uint256(lhs)._and(uint256(rhs))
        //);
    //}
    //function _or(
        //address lhs,
        //address rhs
    //)internal pure returns(
        address
    //){
        //return address(
            //uint256(lhs)._or(uint256(rhs))
        //);
    //}
    //function _xor(
        //address lhs,
        //address rhs
    //)internal pure returns(
        //address
    //){
        //return address(
            //uint256(lhs)._xor(uint256(rhs))
        //);
    //}
    //function _not(
        //address lhs
    //)internal pure returns(
        address
    //){
        //return address(!uint256(lhs));
    //}
    */   
}