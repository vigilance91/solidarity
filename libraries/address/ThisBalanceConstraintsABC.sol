// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";

//import "https://github.com/vigilance91/solidarity/libraries/address/this/thisBalanceConstraints.sol";
import "./thisBalanceConstraints.sol";
/// 
/// @title This (calling contract) Balance Constraints Abstract Base Contract
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// @dev this uint256 balance constraints abstract base contract
/// 
abstract contract ThisUint256BalanceLogicABC
{
    using thisBalanceLogic for uint256;

    //string private constant _NAME = ' ThisUint256BalanceLogicABC: ';
    
    /// @return {bool} true if this.balance > 0 otherwise false
    function _thisBalanceGreaterThanZero(
    )internal view returns(
        bool
    ){
        return thisBalanceLogic.thisBalanceGreaterThanZero(
            //_NAME
        );
    }
    /// @return {bool} true if this.balance == 0 otherwise false
    function _thisBalanceIsZero(
    )internal view returns(
        bool
    ){
        return thisBalanceLogic.thisBalanceIsZero(
        );
    }
    /// @return {bool} true if this.balance == `rhs` otherwise false
    function _thisBalanceEqual(
        uint256 rhs
    )internal view returns(
        bool
    ){
        return rhs.thisBalanceEqual(
        );
    }
    /// @return {bool} true if this.balance != `rhs` otherwise false
    function _thisBalanceNotEqual(
        uint256 rhs
    )internal view returns(
        bool
    ){
        return rhs.thisBalanceNotEqual(

        );
    }
    /// @return {bool} true if this.balance > `rhs` otherwise false
    function _thisBalanceGreaterThan(
        uint256 rhs
    )internal view returns(
        bool
    ){
        return rhs.thisBalanceGreaterThan(

        );
    }
    /// @return {bool} true if this.balance >= `rhs` otherwise false
    function _thisBalanceGreaterThanOrEqual(
        uint256 rhs
    )internal view returns(
        bool
    ){
        return rhs.thisBalanceGreaterThanOrEqual(

        );
    }
    /// @return {bool} true if this.balance < `rhs` otherwise false
    function _thisBalanceLessThan(
        uint256 rhs
    )internal view returns(
        bool
    ){
        return rhs.thisBalanceLessThan(

        );
    }
    /// @return {bool} true if this.balance <= `rhs` otherwise false
    function _thisBalanceLessThanOrEqual(
        uint256 rhs
    )internal view returns(
        bool
    ){
        return rhs.thisBalanceLessThanOrEqual(
        );
    }
}
/// 
/// @title This (calling contract contract) Balance Logic Abstract Base Contract
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// 
abstract contract ThisAddressBalanceLogicABC
{
    using thisBalanceLogic for address;
    
    //string private constant _NAME = ' ThisAddressBalanceLogicABC: ';
    constructor(
    )internal
    {
    }
    /// @return {bool} true if this.balance == 0 otherwise false
    function _thisBalanceIsZero(
    )internal view returns(
        bool
    ){
        return thisBalanceLogic.thisBalanceIsZero(
            //_NAME
        );
    }
    /// @return {bool} true if this.balance != 0 otherwise false
    function _thisBalanceNotEqual(
        address rhs
    )internal view returns(
        bool
    ){
        return rhs.thisBalanceNotEqual(
            //_NAME
        );
    }
    /// @return {bool} true if this.balance > `rhs`.balance otherwise false
    function _thisBalanceGreaterThan(
        address rhs
    )internal view returns(
        bool
    ){
        return rhs.thisBalanceGreaterThan(
            //_NAME
        );
    }
    /// @return {bool} true if this.balance >= `rhs`.balance otherwise false
    function _thisBalanceGreaterThanOrEqual(
        address rhs
    )internal view returns(
        bool
    ){
        return rhs.thisBalanceGreaterThanOrEqual(
            //_NAME
        );
    }
    /// @return {bool} true if this.balance < `rhs`.balance otherwise false
    function _thisBalanceLessThan(
        address rhs
    )internal view returns(
        bool
    ){
        return rhs.thisBalanceLessThan(
            //_NAME
        );
    }
    /// @return {bool} true if this.balance <= `rhs`.balance otherwise false
    function _thisBalanceLessThanOrEqual(
        address rhs
    )internal view returns(
        bool
    ){
        return rhs.thisBalanceLessThanOrEqual(
            //_NAME
        );
    }
    
    //function isNotZero(
        //address account
    //) internal view
    //{
        //account.isNotZero().requireTrue(
            //"balance must not be 0"
        //);
    //}
    
    /// @return {bool} true if this.balance > 0 && this.balance == `rhs`.balance otherwise false
    function _thisBalanceGreaterThanZeroAndEqual(
        address rhs
    )internal view returns(
        bool
    ){
        return rhs.thisBalanceGreaterThanZeroAndEqual(
        );
    }
    /// @return {bool} true if this.balance > 0 && this.balance != `rhs`.balance otherwise false
    function _thisBalanceGreaterThanZeroAndNotEqual(
        address rhs
    )internal view returns(
        bool
    ){
        return rhs.thisBalanceGreaterThanZeroAndNotEqual(
            //_NAME
        );
    }
    /**
    *array functions
    */
    //function requireBalanceGreaterThanZeroAndNotEqualArray(
        //address self,
        //address[] memory container
    //)internal view
    //{
        ////logicConstraints.requireTrue(
            ////container.length > 0
        ////);
        
        //for(uint256 i = 0; i < container.length; i++){
            //address rhs = container[i];
            ////self.balanceGreaterThanZeroAndNotEqual(rhs).requireTrue();
            ////self.balanceNotEqual(rhs).requireTrue();
        //}
    //}
}
/// 
/// @title This (calling contract contract) Balance Contraints Abstract Base Contract
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// @notice trivial utilities for constraining the state of the EVM (using require)
/// for address types, reverting on failure.
/// 
abstract contract ThisUint256BalanceConstraintsABC
{
    using thisBalanceConstraints for uint256;
    
    //string private constant _NAME = ' ThisUint256BalanceConstraintsABC: ';
    //
    //amounts, rhs of type uint256
    //
    /// @dev require this.balance == `rhs`
    function _requireThisBalanceEqual(
        uint256 rhs
    )internal view
    {
        rhs.requireThisBalanceEqual(
        );
    }
    /// @dev require this.balance != `rhs`
    function _requireThisBalanceNotEqual(
        uint256 rhs
    )internal view
    {
        rhs.requireThisBalanceNotEqual(

        );
    }
    /// @dev require this.balance == 0
    function _requireThisBalanceIsZero(
    )internal view
    {
        thisBalanceConstraints.requireThisBalanceIsZero(

        );
    }
    /// @dev require this.balance > 0
    function _requireThisBalanceGreaterThanZero(
    )internal view
    {
        thisBalanceConstraints.requireThisBalanceGreaterThanZero(

        );
    }
    /// @dev require this.balance > `rhs`
    function _requireThisBalanceGreaterThan(
        uint256 rhs
    )internal view
    {
        rhs.requireThisBalanceGreaterThan(

        );
    }
    /// @dev require this.balance >= `rhs`
    function _requireThisBalanceGreaterThanOrEqual(
        uint256 rhs
    )internal view
    {
        rhs.requireThisBalanceGreaterThanOrEqual(

        );
    }
    /// @dev require this.balance < `rhs`
    function _requireThisBalanceLessThan(
        uint256 rhs
    )internal view
    {
        rhs.requireThisBalanceLessThan(

        );
    }
    /// @dev require this.balance <= `rhs`
    function _requireThisBalanceLessThanOrEqual(
        uint256 rhs
    )internal view
    {
        rhs.requireThisBalanceLessThanOrEqual(

        );
    }
}
/*
abstract contract PayableThisUint256BalanceABC
{
    using uint256Constraints for uint256;

    constructor(
        uint256 minimumWei
    )internal payable
    {
        minimumWei.requireGreaterThanZero();
        
        _requireMsgValueGreaterThanOrEqual(
            minimumWei
        );
    }
}
*/
/*
abstract contract PayableRangeThisUint256BalanceConstraintsABC
{
    constructor(
        uint256 minimumWei,
        uint256 maximumWei
    )internal payable
        PayableThisUint256BalanceConstraintsABC(minimumWei)
    {
        _requireMsgValueLessThanOrEqual(
            maximumWei
        );
    }
}
*/
/// 
/// @title This (calling contract contract) Balance Contraints Abstract Base Contract
/// @author Tyler R. Drury - 1/3/2021, All Rights Reserved
/// @notice trivial utilities for constraining the state of the EVM (using require)
/// for address types, reverting on failure.
/// 
abstract contract ThisAddressBalanceConstraintsABC
{
    using thisBalanceConstraints for address;
    
    //string private constant _NAME = ' ThisAddressBalanceConstraintsABC: ';
    constructor(
    )internal
    {
    }
    //function requireBalanceEqual(
        //address rhs
    //) internal view
    //{
        //rhs.requireThisBalanceEqual(
            //"lhs.balance != rhs.balance"
        //);
    //}
    
    /// @dev this.balance != `rhs`
    function _requireThisBalanceNotEqual(
        address rhs
    )internal view
    {
        rhs.requireThisBalanceNotEqual(
            //_NAME
        );
    }
    /// @dev this.balance > `rhs`
    function _requireThisBalanceGreaterThan(
        address rhs
    )internal view
    {
        rhs.requireThisBalanceGreaterThan(
            //_NAME
        );
    }
    /// @dev this.balance >= `rhs`
    function _requireThisBalanceGreaterThanOrEqual(
        address rhs
    )internal view
    {
        rhs.requireThisBalanceGreaterThanOrEqual(
            //_NAME
        );
    }
    /// @dev this.balance < `rhs`
    function _requireThisBalanceLessThan(
        address rhs
    )internal view
    {
        rhs.requireThisBalanceLessThan(
            //_NAME
        );
    }
    /// @dev this.balance <= `rhs`
    function _requireThisBalanceLessThanOrEqual(
        address rhs
    )internal view
    {
        rhs.requireThisBalanceLessThanOrEqual(
            //_NAME
        );
    }
    /// @dev this.balance > 0
    function _requireThisBalanceGreaterThanZero(
    )internal view
    {
        thisBalanceConstraints.requireThisBalanceGreaterThanZero(
            //_NAME
        );
    }
    /// @dev require this.balance > 0
    //function isNotZero(
        //address account
    //)internal view
    //{
        //thisBalanceConstraints.requireThisBalanceGreaterThanZero(
            //"balance must not be 0"
        //);
    //}
    /// @dev require this.balance == 0
    //function isZero(
    //)internal view
    //{
        //thisBalanceConstraints.requireThisBalanceIsZero(
            //"balance must be 0"
        //);
    //}
    /// @dev require this.balance > 0 && this.balance == rhs
    function _requireThisBalanceGreaterThanZeroAndEqual(
        address rhs
    )internal view
    {
        rhs.requireThisBalanceGreaterThanZeroAndEqual(
        );
    }
    /// @dev require this.balance > 0 && this.balance != rhs
    function _requireThisBalanceGreaterThanZeroAndNotEqual(
        address rhs
    )internal view
    {
        rhs.requireThisBalanceGreaterThanZeroAndNotEqual(
            //_NAME
        );
    }
}