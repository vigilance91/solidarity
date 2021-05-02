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
        mixinAllowance.initialize();
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
    /// @dev get allowance of spender which has been previously approved by msg.sender
    function allowanceFor(
        address spender
    )external view virtual override returns(
        uint256
    ){
        return mixinAllowance.allowanceFor(
            _msgSender(),
            spender
        );
    }
    function _approve(
        address owner,
        address spender,
        uint256 amount
    )internal virtual returns(
        bool
    ){
        mixinAllowance.approve(
            owner,
            spender,
            amount
        );
        //after storing amount in allowance, must transfer value to self,
        //so that this contract can send the funds on spender requests
        (bool success, ) = payable(address(this)).call{value:amount}('');
        
        success.requireTrue('_approve failed');
        
        return true;
    }
    /// @return revokedAllowance {uint256} total allowance revoked
    function _revokeAllowance(
        address owner,
        address spender
    )internal returns(
        uint256 revokedAllowance
    ){
        revokedAllowance = mixinAllowance.revoke(owner, spender);
        (bool success, ) = payable(owner).call{value:revokedAllowance}('');
        
        success.requireTrue('revoke failed');
    }
    ///
    /// @dev See {mixinAllowance.approve}
    /// transfer value from caller to this contract to hold as custodian of the ETH value (like an escrow) for `spender`,
    /// so that owner can not accidentally spend the assigned allowance they have granted `spender`,
    /// without first explicitly revoking `spender`s allowace, returning the funds to `owner`
    /// 
    /// Additional Requirements:
    ///     - `spender` cannot be this contract
    ///
    function approve(
        address spender
    )external payable virtual override returns(
        bool
    ){
        return _approve(
            _msgSender(),
            spender,
            msg.value
        );  //amount);
    }
    /// @dev convenience wrapper to get the curent available ETH allowance
    /// approved by this contract for `spender`
    function thisEthAllowanceFor(
        address spender
    )public view virtual returns(
        uint256
    ){
        return mixinAllowance.allowanceFor(address(this),spender);
    }
    ///
    /// @dev caller revokes `spender`s allowance, returning the ETH to caller
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
        return mixinAllowance.increaseAllowance(
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
    )internal virtual returns(
        uint256
    ){
        return mixinAllowance.decreaseAllowance(
            owner,
            spender,
            subtractedValue
        );
    }
}