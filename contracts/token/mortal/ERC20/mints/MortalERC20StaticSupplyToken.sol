// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/token/mortal/ERC20/MortalERC20Token.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/supplyCap/StaticSupplyCapABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/PausableAccessControl.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/ERC20ReceiverConstraintsABC.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";
///
/// @title Safe ERC20 Static Supply Token Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev ERC20 compliant token implementation which is pausable,
/// and has a static total supply (does not change after contract deployment),
/// and performs safe token transfers, preventing loss of tokens sent to contracts which do not implement iERC20Receiver
///
/// NOTE:
///     this contract never mints or burns tokens (which is why it is not a token not a mint),
///     since the supply is static, the total supply is immediately minted (to the deploying address) and available upon deployment
///
abstract contract MortalERC20StaticSupplyToken is MortalERC20Token,
    PausableAccessControl,
    StaticSupplyCapABC
{
    using SafeMath for uint256;

    using frameworkERC165 for address;
    //using LogicConstraints for bool;
    using AddressLogic for address;
    //using uint256Constraints for uint256;
    
    //using stringUtilities for string;
    
    //string private constant _NAME = ' SafeERC20StaticSupplyToken: ';
    
    ///
    /// @dev explicitly prevent proxying
    /// NOTE:
    ///     since this contracts methods are external with ReentrancyGuard, not public,
    ///     this will automatically prevent proxying but cauases obscure and hard to track down errors
    ///     so, simply prevent proxying here and any attempt to call a function not declared in this implementation
    ///     will always revert here, no need to figure out issues with function visibility, modifiers, execution context, etc
    /// 
    //fallback(
    //)external view nonReentrant payable{
        //LogicConstraints.alwaysRevert('proxying disabled');
    //}
    
    constructor(
        string memory name,
        string memory symbol,
        uint256 tokenCap
    )internal 
        MortalERC20Token(
            name,
            symbol
            //tokenCap
        )
        PausableAccessControl()
        StaticSupplyCapABC(
            tokenCap
        )
    {
        address sender = _msgSender();
        
        mixinTokenSupply.increaseTotalSupply(tokenCap);
        _setBalanceOf(sender, tokenCap);
        
        assert(_balanceOf(sender) == tokenCap);
        
        ////_registerInterface(type(iSafeERC20StaticSupplyToken).interfaceId);
    }
    ///
    /// @dev See {ERC20._beforeTokenTransfer}
    ///
    /// Requirements:
    ///     - the contract must not be paused
    ///     - tokens can't be minted
    ///     - tokens can't be burned
    ///
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    )internal virtual override
        //whenNotPaused()
    {
        require(
            !paused()
            //_NAME.concatenate("paused")
        );
        
        if(from.isNull()){
            LogicConstraints.alwaysRevert(
                //_NAME.concatenate("cannot mint tokens")
                "cannot mint tokens"
            );
        }
        else if(to.isNull()){
            LogicConstraints.alwaysRevert(
                //_NAME.concatenate("cannot burn tokens")
                "cannot burn tokens"
            );
        }
        
        super._beforeTokenTransfer(
            from,
            to,
            amount
        );
    }
}