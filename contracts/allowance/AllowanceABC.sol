// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";

import "https://github.com/vigilance91/solidarity/contracts/allowance/iAllowance.sol";
import "https://github.com/vigilance91/solidarity/contracts/allowance/mixinAllowance.sol";
///
/// @title Allowance Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev Allowance interface implementation,
///
/// Note:
///     this implementation is agnostic in regards to implementing transferFrom,
///     and is the responsibility of the deriving contract to implement other such allowance
///     related methods themselves, making this ABC versitile and usable for repressenting
///     not just an allowance of tokens but any value repressented by a uint256 (such as ETH),
///     and could be used to extend virtually any contract with the capacity for allowances of an arbitrary nature
///     allowinf for much more rich composition
///
abstract contract AllowanceABC is Context,
    iAllowance
{
    using LogicConstraints for bool;
    
    using uint256Constraints for uint256;
    using AddressConstraints for address;
    
    using SafeMath for uint256;
    
    constructor(
    )internal Context()
    {
    }
    ///
    /// @dev Get the current allownace `owner` has granted `spender`,
    /// if this value is 0, `spender` has not been granted an allowance by `owner`
    /// See {mixinAllowance.allowance}
    /// 
    /// Additional Requirements:
    ///     - `owner` and `spender` cannot be null
    ///     - `owner` can not be `spender`
    ///
    function allowance(
        address owner,
        address spender
    )public view virtual override returns(
        uint256
    ){
        return mixinAllowance.allowanceFor(owner,spender);
    }
    function _approve(
        address owner,
        address spender,
        uint256 amount
    )internal returns(
        bool
    ){
        mixinAllowance.approve(
            owner,
            spender,
            amount
        );
        return true;
    }
    function _revokeAllowance(
        address owner,
        address spender
    )internal
    {
        mixinAllowance.revokeAllowance(owner, spender);
    }
    ///
    /// @dev See {mixinAllowance.approve}
    /// 
    /// Additional Requirements:
    ///     - `spender` cannot be this contract
    ///
    function approve(
        address spender,
        uint256 amount
    )external virtual override returns(
        bool
    ){
        return _approve(_msgSender(), spender, amount);
    }
    ///
    /// Additional Requirements:
    ///     - `spender` cannot be null
    ///     - `spender` cannot be caller
    ///     - `spender` must have a non-zero allowance
    ///
    function revokeAllowance(
        address spender
    )external virtual override
    {
        _revokeAllowance(_msgSender(), spender);
    }
    ///
    /// @dev See {mixinERC20.decreaseAllowance}
    /// 
    /// Additional Requirements:
    ///     - `spender` cannot be this contract
    ///     - `spender` must have a non-zero allowance to increase it, otherwise first call allow(),
    ///         then call increase/decrease as required
    ///
    function _increaseAllowance(
        address owner,
        address spender,
        uint256 addedValue
    )internal virtual returns(
        uint256
    ){
        return mixinAllowance().increaseAllowance(
            owner,
            spender,
            addedValue
        );
    }
    ///
    /// @dev See {mixinERC20.decreaseAllowance}
    /// Additional Requirements:
    ///     - `spender` cannot be null
    ///     - `spender` must already have a non-zero allowance of at least `subtractedValue`
    ///
    function _decreaseAllowance(
        address owner,
        address spender,
        uint256 subtractedValue
    )public virtual returns(
        uint256
    ){
        return mixinAllowance().decreaseAllowance(
            owner,
            spender,
            subtractedValue
        );
    }
}