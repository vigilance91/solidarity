// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoverV2;

import "./ERC20Snapshot.sol";
import "./iStaticSupplyCap.sol";
///
/// @title ERC20StaticSupplyCap
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 23/4/2021, All Rights Reserved
/// @dev {ERC20} extension adding a static supply cap
///
abstract contract ERC20StaticSupplyCapToken is iStaticSupplyCap
    //ERC20StaticSupplyABC    //ERC20Snapshot
{
    using SafeMath for uint256;

    //using AddressLogic for address;
    //using uint256Constraints for uint256;
    
    string private constant CONTRACT_NAME = ' StaticSupplyCapABC: ';
    
    uint256 private _cap;
    ///
    /// @dev Sets the value of the `cap` (his value is immutable),
    /// and can not be set after construction
    ///
    constructor(
        //uint256 initialSupply
        uint256 tokenCap
    )internal
        ERC20StaticSupplyABC(tokenCap)
    {
        //tokenCap.requireGreaterThanZero(
            //CONTRACT_NAME.concatenate("cap is 0")
        //);
        require(
            totalSupply() > 0,
            "cap must be greater than 0"
        );
    }
    /// @dev with a static supply cap token, the token cap is the total supply
    function cap(
    )public view returns(
        uint256
    ){
        return _cap;
    }
    //@return {tuple} balance of and market cap of this token in one call
    //function balanceOfToCap(
        //address account
    //)public view override returns(
        //uint256 numerator,
        //uint256 denominator
    //){
        //return (balaneOf(account, totalSupply());
    //}
    //@return {tuple} balance of and market cap of this token in one call
    //function balanceOfToCap(
    //)public view override returns(
        //uint256 numerator,
        //uint256 denominator
    //){
        //return (balaneOf(_msgSender(), totalSupply());
    //}
    //@return {tuple} get current circulating supply and market cap of this token in one call
    //useful for determining the total percentage of circulating tokens (using a off-block chain computation of: numerator / denominator)
    //notice if numerator is < denominator, since Ethereum has no float-point numbers,
    //the result, if calculated by the EVM, would only ever either an integer value of 0 or 1,
    //with 0 being less than the total supply in circulation and 1 being the total suppl is in circulation
    //function totalSupplyToCap(
    //)external view returns(
        //uint256 numerator,
        //uint256 denominator
    //){
        //return (
            //totalSupply(),
            //_cap
        //);
    //}
    /**
    ///
    /// @dev total supply released on creation
    ///
    /// Requirements:
    ///     - tokens cannot be minted
    ///     - tokens cannot be burned
    ///
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    )internal virtual override
    {
        super._beforeTokenTransfer(
            from,
            to,
            amount
        );
        //when minting or burning tokens
        if(from.isNull() || to.isNull()){
            //LogicConstraints.alwaysRevert(
                //_NAME.concatenate("token supply cap cannot mutate")
            //);
            require(
                totalSupply().add(amount) <= _cap,
                "cap exceeded"
            );
        }
    }
    */
}