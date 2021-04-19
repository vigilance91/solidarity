// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/Pausable.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControl.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/SafeERC20BurnableToken.sol";
///
/// @title Safe ERC20 Preset Mint
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/4/2021, All Rights Reserved
/// @dev {ERC20} token, including:
///     - ability for holders to burn (destroy) their tokens
///     - a minter role that allows for token minting (creation)
///     - a pauser role that allows to stop all token transfers
///
/// By default, this contract rejects all transfers to any contract address (including this one),
/// which does not implement iERC20Receiver,
/// ERC20 token transfers to wallet addresses are not affected.
///
/// This contract uses {AccessControl} to lock permissioned functions using the
/// different roles - head to its documentation for details
///
/// The account that deploys the contract will be granted the minter and pauser roles,
/// as well as the default admin role,
/// which will let it grant both minter and pauser roles to other accounts
///
contract SafeERC20PresetMint is SafeERC20BurnableToken,
    AccessControl,  //ERC20AccessControlToken
    Pausable
{
    using Address for address;
    
    using LogicConstraints for bool;
    
    //using stringUtilities for string;
    
    bytes32 public constant MINTER_ROLE = keccak256("ERC20.MINT.MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("ERC20.MINT.PAUSER_ROLE");
    //bytes32 public constant BURNER_ROLE = keccak256("ERC20.MINT.PAUSER_ROLE");
    
    //string private constant CONTRACT_NAME = 'ERC20PresetMint: ';
    ///
    /// @dev Grants `DEFAULT_ADMIN_ROLE`, `MINTER_ROLE` and `PAUSER_ROLE` to the
    /// account that deploys the contract
    /// See {ERC20.constructor}
    ///
    constructor(
        string memory name,
        string memory symbol
    )public
        SafeERC20BurnableToken(
            name,
            symbol
        )
        Pausable()
    {
        address sender = _msgSender();
        
        _setupRole(DEFAULT_ADMIN_ROLE, sender);
        _setupRole(MINTER_ROLE, sender);
        _setupRole(PAUSER_ROLE, sender);
        //_setupRole(BURNER_ROLE, sender);
    }
    function _requireHasRole(
        address account,
        bytes32 role
        //string memory msg
    )internal view
    {
        hasRole(role, account).requireTrue(
            //CONTRACT_NAME.concatenate(msg)
        );
    }
    modifier onlyRole(
        bytes32 role
        //string memory msg
    ){
        _requireHasRole(_msgSender(), role);
        _;
    }
    
    //modifier safeTransferERC20(
        //address from,
        //address to,
        //uint256 amount
    //){
        //_requireCanReceiveERC20(to);
        //_;
        //_requireOnERC20Received(to, from, amount);
    //}
    
    //transfer tokens owned by this contract to `recipient`
    //Requirements:
    //  -callable only by this contract Owner or internally
    function safeTransferTo(
        address recipient,
        uint256 amount
    )external onlyOwner returns(
        bool
    ){
        address(this).requireNotEqual(recipient);
        
        //_requireCanReceiveERC20(recipient);
        
        _transfer(
            address(this),
            recipient,
            amount
        );
        
        //_requireOnERC20Received(recipient, address(this), amount);
        
        return true;
    }
    ///
    /// @dev Creates `amount` new tokens for `to`
    /// See {ERC20._mint}
    /// Requirements:
    ///     - the caller must have the `MINTER_ROLE`
    ///
    function mint(
        address to,
        uint256 amount
    )public virtual
        //onlyRole(MINTER_ROLE)
    {
        _requireHasRole(
            _msgSender(),
            MINTER_ROLE
            //CONTRACT_NAME.concatenate("must have minter role to mint")
        );
        
        _mint(to, amount);
    }
    ///
    /// @dev Pauses all token transfers
    /// See {ERC20Pausable} and {Pausable._pause}
    ///
    /// Requirements:
    ///     - the caller must have the `PAUSER_ROLE`
    ///
    /**
    function pause(
    )public virtual
        //onlyRole(PAUSER_ROLE)
    {
        _requireHasRole(
            _msgSender(),
            PAUSER_ROLE
            //CONTRACT_NAME.concatenate("must have pauser role to pause")
        );
        _pause();
    }
    ///
    /// @dev Unpauses all token transfers
    /// See {ERC20Pausable} and {Pausable._unpause}
    ///
    /// Requirements:
    ///     - the caller must have the `PAUSER_ROLE`
    ///
    function unpause(
    )public virtual
        //onlyRole(PAUSER_ROLE)
    {
        _requireHasRole(
            _msgSender(),
            PAUSER_ROLE
            //CONTRACT_NAME.concatenate("must have pauser role to unpause")
        );
        _unpause();
    }
    */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    )internal virtual override //(
        //SafeERC20Token
    //)
    {
        paused().requireFalse(
            "SafeERC20PresetMint: can not transfer while paused"
        );
        
        super._beforeTokenTransfer(
            from,
            to,
            amount
        );
    }
}