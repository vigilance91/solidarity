// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";
///
/// @title Contract Constraints Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev provides support to constrain the state of the EVM based on contract addresses,
/// specifically this contract (or those which derive from it)
///
abstract contract ContractConstraintsABC
{
    using AddressConstraints for address;
    //using SafeMath for uint256;
    //
    address internal _this;
    //address payable _thisPayable;
    
    constructor(
    )internal
    {
        _this = address(this);
        //_thisPayable = payable(_this);
    }
    /**
    //disable accepting ether transfers
    receive(
    )external virtual payable //nonReentrant
    {
        LogicContraints.alwaysRevert("receive() deleted");
    }
    //disable proxying
    fallback(
    )external virtual payable //nonReentrant
    {
        LogicContraints.alwaysRevert("fallback() deleted");
    }
    */
    //function _thisPayable(
    //)internal returns(
        //address payable
    //){
        //return _thisPayable;
        //return payable(_this);
    //}
    ///
    /// Contract base calls to Require statements in library
    ///
    function _requireNull(
        address account
    )internal pure
    {
        account.requireNull();
    }
    function _requireNotNull(
        address account
    )internal pure
    {
        account.requireIsNotNull();
    }
    function _requireNotThis(
        address account
    )internal view
    {
        _this.requireNotEqual(account);
    }
    function _requireNotThisAndNotNull(
        address account
    )internal view
    {
        _this.requireIsNotThisAndNotNull(account);
    }
    function _requireAddressessNotThisAndNotNull(
        address lhs,
        address rhs
    )internal view
    {
        _this.requireAddressessNotThisAndNotNull(lhs,rhs);
    }
}