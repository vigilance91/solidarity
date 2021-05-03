// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/token/ERC20/ERC20StaticSupplyToken.sol";
//import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/StaticSupplyCapABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/PausableAccessControl.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/ERC20ReceiverConstraintsABC.sol";
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
abstract contract SafeERC20StaticSupplyToken is ERC20StaticSupplyToken,
    PausableAccessControl
    ERC20ReceiverConstraintsABC
    //StaticSupplyCapABC
{
    using SafeMath for uint256;

    using frameworkERC165 for address;
    //using LogicConstraints for bool;
    //using AddressLogic for address;
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
        //SafeERC20AccessControlToken(name,symbol,0)
        ERC20StaticSupplyToken(
            name,
            symbol,
            tokenCap
        )
        PausableAccessControl()
        ERC20ReceiverConstraintsABC()
        //StaticSupplyCapABC(
            //tokenCap
        //)
    {
        //tokenCap.requireGreaterThanZero(
            //_NAME.concatenate("token must have non-zero supply")
        //);
        //
        //address sender = _msgSender();
        
        //_increaseSupply(tokenCap);
        //_setBalanceOf(sender, tokenCap);
        
        //assert(balanceOf(sender) == tokenCap);
        
        ////_registerInterface(type(iBurnable).interfaceId);
        ////_registerInterface(type(iERC20StaticSupplyToken).interfaceId);
    }
    function _externalSafeTransfer(
        address token,
        address recipient,
        uint256 amount
    )internal
    {
        token.supportsInterface(type(iERC20).interfaceId).requireTrue(
            'external token contract is not ERC20 compliant'
        );
        
        _requireCanReceiveERC20(recipient);
        
        iERC20(token).transfer(recipient, amount);
        
        _requireOnERC20Received(recipient, address(this), amount);
    }
    /**
    //like _externalSafeTransfer but exclusively transfers `amount` of tokens to this contract's owner
    function externalSafeTransferToOwner(
        address token,
        uint256 amount
    )external nonReentrant
    {
        //owner().requireNotNull("owner cannot be null");
        
        _externalSafeTransfer(
            token,
            owner(),
            amount
        );
    }
    /**
    /// @dev msg sender approves owner for an allowance of amount from an external contract `token`
    function externalSafeApproveOwner(
        address token,
        uint256 amount
    )external nonReentrant
    {
        //owner().requireNotNull("owner cannot be null");
        
        _externalSafeApprove(
            token,
            _msgSender(),
            owner(),
            amount
        );
    }
    */
    */
    //transfer from this contract to address `to`, must either be a wallet or an iERC20Receiver implementer
    //Requirements:
    //  - reverts if `to` is NULL or is a contract which does not implement ERC165 AND iERC20Receiver
    //
    function safeTransferTo(
        address to,
        uint256 amount
    )external onlyOwner nonReentrant
    {
        _transfer(
            address(this),
            to,
            amount
        );
    }
    //Requirements:
    //  - reverts if this contract's owner is NULL
    //  - reverts if owner is a contract which does not implement ERC165 AND iERC20Receiver
    //
    function safeTransferToOwner(
        uint256 amount
    )external onlyOwner nonReentrant
    {
        _transfer(
            address(this),
            owner(),
            amount
        );
    }
    /**
    //transfer an allowance of `amount`, if available, from `from` to this contract
    function safeTransferFrom(
        address from,
        uint256 amount
    )external onlyOwner
    {
        _transferFrom(
            from,
            address(this),
            amount
        );
    }
    */
    /// 
    /// @dev See {ERC20._transfer}
    /// 
    /// Additional Requirements:
    ///     - `recipient`  must be either a non-zero wallet address or a contract which implements ERC165 AND iERC20Receiver
    ///
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    )internal virtual override
        //_emitTransfer(sender,recipient,amount)
    {
        _requireCanReceiveERC20(recipient);
        
        super._transfer(
            sender,
            recipient,
            amount
        );
        
        _requireOnERC20Received(recipient, sender, amount);
    }
    ///
    ///Requirements:
    ///     - `spender` must be either a wallet address or a contract which implements ERC165 AND iERC20Receiver
    ///
    function _approve(
        address owner,
        address spender,
        uint256 amount
    )internal virtual override
    {
        _requireCanReceiveERC20(spender);
        
        super._approve(
            owner,
            spender,
            amount
        );
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
        
        if(from == address(0)){
            LogicConstraints.alwaysRevert(
                //_NAME.concatenate("cannot mint tokens")
                "cannot mint tokens"
            );
        }
        else if(to == address(0)){
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