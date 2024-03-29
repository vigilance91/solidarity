// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
//
import "https://github.com/vigilance91/solidarity/libraries/msg/value/msgValueConstraints.sol";
///
/// @title Msg Value Constraints Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/12/2021, All Rights Reserved
/// @dev provides support to constrain the state of the EVM based on the value passed with an external transaction msg
///
abstract contract MsgValueConstraintsABC
{
    using msgValueConstraints for uint256;
    
    ////string internal _domainNameSeperator;
    string private constant _NAME = ' MsgValueConstraintsABC: ';
    //
    //string private constant _ERR_EQUAL = string(
        //abi.encodePacked(
            //_NAME,
            //'=='
        //)
    //);
    //string private constant _ERR_NOT_EQUAL = string(
        //abi.encodePacked(
            //_NAME,
            //'!='
        //)
    //);
    //
    //string private constant _ERR_GREATER_THAN = string(
        //abi.encodePacked(
            //_NAME,
            //'>'
        //)
    //);
    //string private constant _ERR_GREATER_THAN_OR_EQUAL = string(
        //abi.encodePacked(
            //_NAME,
            //'>='
        //)
    //);
    //
    //string private constant _ERR_LESS_THAN = string(
        //abi.encodePacked(
            //_NAME,
            //'<'
        //)
    //);
    //string private constant _ERR_LESS_THAN_OR_EQUAL = string(
        //abi.encodePacked(
            //_NAME,
            //'<='
        //)
    //);
    
    ////string private constant _ERR_IS_ZERO = string(
        //abi.encodePacked(
            //_NAME,
            //'== 0'
        //)
    //);
    
    constructor(
    )internal
    {
    }
    function _requireMsgValueEqual(
        uint256 rhs
    )internal view
    {
        rhs.requireMsgValueEqual(
            //_ERR_NOT_EQUAL
        );
    }
    function _requireMsgValueNotEqual(
        uint256 rhs
    )internal view
    {
        rhs.requireMsgValueNotEqual(
            //_ERR_EQUAL
        );
    }
    /**
    * >
    */
    function _requireMsgValueGreaterThan(
        uint256 rhs
    )internal view
    {
        rhs.requireMsgValueGreaterThan(
            //_ERR_LESS_THAN_OR_EQUAL
        );
    }
    /**
    * >=
    */
    function _requireMsgValueGreaterThanOrEqual(
        uint256 rhs
    )internal view
    {
        rhs.requireMsgValueGreaterThanOrEqual(
            //_ERR_LESS_THAN
        );
    }
    /**
    * <
    */
    function _requireMsgValueLessThan(
        uint256 rhs
    )internal view
    {
        rhs.requireMsgValueLessThan(
            //_ERR_GREATER_THAN_OR_EQUAL
        );
    }
    /**
    * <=
    */
    function _requireMsgValueLessThanOrEqual(
        uint256 rhs
    )internal view
    {
        rhs.requireMsgValueLessThanOrEqual(
            //_ERR_GREATER_THAN
        );
    }
    function _requireMsgValueGreaterThanZero(
    )internal view
    {
        msgValueConstraints.requireMsgValueGreaterThanZero(
            //_ERR_IS_ZERO
        );
    }
    function _requireMsgValueIsZero(
    )internal view
    {
        msgValueConstraints.requireMsgValueIsZero(
            //_ERR_NON_ZERO
        );
    }
    /*
    function _requireMsgValueGreaterThanZeroAndEqual(
        uint256 rhs
    )internal view
    {
        rhs.msgValueGreaterThanZeroAndEqual().requireTrue(
        );
    }
    
    function requireMsgValueGreaterThanZeroAndNotEqual(
        uint256 rhs
    )internal view
    {
        rhs.msgValueGreaterThanZeroAndNotEqual(rhs);
    }
    
    function _requireMsgValueNonZeroAndGreaterThan(
        uint256 rhs
    )internal view
    {
        msgValueLogic.msgValueGreaterThanZero().requireTrue(
        );
        rhs.msgValueGreaterThan().requireTrue(
        );
    }
    function _requireMsgValueGreaterThanOrEqualNonZero(
        uint256 rhs
    )internal view
    {
        rhs.msgValueGreaterThanOrEqualAnd().requireTrue(
        );
    }
    */
    function _requireMsgValueEqualAndNonZero(
        uint256 rhs
    )internal view
    {
        rhs.requireMsgValueEqualAndNonZero(
        );
    }
    function _requireMsgValueNotEqualAndNonZero(
        uint256 rhs
    )internal view
    {
        rhs.requireMsgValueNotEqualAndNonZero(
        );
    }
    function _requireMsgValueLessThanAndNonZero(
        uint256 rhs
    )internal view
    {
        rhs.requireMsgValueLessThanAndNonZero(
        );
    }
    function _requireMsgValueLessThanOrEqualAndNonZero(
        uint256 rhs
    )internal view
    {
        rhs.requireMsgValueLessThanAndNonZero(
        );
    }
}
/*
contract MsgValueTest is MsgValueConstraintsABC
{
    constructor(
    )public //nonReentrant //payable
        MsgValueConstraintsABC()
    {
        //_requireMsgValueGreaterThanZero();
    }
    event Deposit(uint256);

    receive(
    )external payable
    {
        _requireMsgValueLessThanOrEqualAndNonZero(
            1000
        );

        emit Deposit(msg.value);
    }
    function sendEth(
    )external payable{
        (bool success, ) = payable(address(this)).call{value:msg.value}("");
        
        require(success, 'transfer failed');
    }
    function bal(
    )external view returns(
        uint256
    ){
        return address(this).balance;
    }
}
*/