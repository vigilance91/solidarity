// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;


import "https://github.com/vigilance91/solidarity/contracts/tokentoken/TokenSupply/supplyCap/StaticSupplyCapABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/tokentoken/TokenSupply/supplyCap/iMutableSupplyCap.sol";

//interface iERC20MutableSupplyCapToken is iERC20,
//  iMutableSupplyCap
//{  
//}
///
/// @title ERC20MutableSupplyCapToken
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 23/4/2021, All Rights Reserved
/// @dev {ERC20} extension with a mutable supply cap
///
abstract contract MutableSupplyCapABC is StaticSupplyCapABC,
    iMutableSupplyCap
{
    using SafeMath for uint256;

    //using AddressLogic for address;
    using uint256Constraints for uint256;
    
    string private constant _NAME = ' MutableSupplyCapABC: ';
    ///
    /// @dev Sets the value of the `cap` (his value is immutable),
    /// and can not be set after construction
    ///
    constructor(
        uint256 tokenCap
    )internal
        StaticSupplyCapABC(
            tokenCap
        )
    {
        //_registerInterface(type(iMutableSupplyCap).interfaceId);
    }
    function _increaseCapBy(
        uint256 amountBy
    )internal view returns(
        uint256
    ){
        amountBy.requireGreaterThanZero();
        uint256 previousCap = _cap;
        
        _cap = previousCap.add(
            amountBy
            //'increaseCapBy, overflow'
        );
        
        //assert(_cap > previousCap && _cap > totalSupply());
        
        return _cap;
    }
    function _decreaseCapBy(
        uint256 amountBy
    )internal view returns(
        uint256
    ){
        amountBy.requireGreaterThanZero();
        uint256 previousCap = _cap;
        
        previousCap.requireGreaterThanOrEqual(amountBy);
        
        uint256 newCap = previousCap.sub(
            amountBy
            //'decreaseCapBy: underflow'
        );
        //cannot reduce token cap below current total supply, without first burning tokens
        newCap.requireGreaterThanOrEqual(
            totalSupply()
        );
        
        _cap = newCap;
        
        //assert(_cap < previousCap && _cap >= totalSupply());
        
        return _cap;
    }
    /**
    function increaseCapBy(
        uint256 amountBy
    )public view onlyAdminOrOwner override returns(
        uint256
    ){
        return _increaseCapBy(amountBy);
    }
    function decreaseCapBy(
        uint256 amountBy
    )public view onlyAdminOrOwner override returns(
        uint256
    ){
        return _decreaseCapBy(amountBy);
    }
    
    function setCap(
        uint256 newCap
    )public view onlyAdminOrOwner override returns(
        uint256
    ){
        newCap.requireGreaterThanZero();
        _cap.requireNotEqual(newCap);
        
        if(newCap > _cap){
            _increaseCapBy(newCap.sub(_cap));
        }
        else if(newCap < _cap){
            _decreaseCapBy(_cap.sub(newCap));
        }
        
        return _cap;
    }
    */
}