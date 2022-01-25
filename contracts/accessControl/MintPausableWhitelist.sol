// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/PausableWhitelist.sol";

//interface iPausableMintWhitelist is PausableWhitelist
//{
//  function hasRoleMinter(
//        address account
//    )external;
//    
//    function hasRoleBurner(
//        address account
//    )external;
//}

///
/// @title Mint Pausable Whitelist
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 22/4/2021, All Rights Reserved
///
abstract contract MintPausableWhitelist is PausableWhitelist
{
    //string private constant _NAME = ' MintPausableWhitelistAccessControl: ';
    
    bytes32 public constant ROLE_MINTER = keccak256("Solidarity.MINT_PAUSABLE_WHITELIST.ROLE_MINTER");
    bytes32 public constant ROLE_BURNER = keccak256("Solidarity.MINT_PAUSABLE_WHITELIST.ROLE_BURNER");
    
    constructor(
    )internal 
        PausableWhitelist()
    {
        address sender = _msgSender();
        
        _setupRole(ROLE_MINTER, sender);
        //_setupRole(ROLE_BURNER, sender);
    }
    
    function hasRoleMinter(
        address account
    )public virtual
    {
        return hasRole(ROLE_MINTER, account);
    }
    function hasRoleBurner(
        address account
    )public virtual
    {
        return hasRole(ROLE_BURNER, account);
    }
    //function _requireRoleMinter(
        //address account
    //)internal view
    //{
        //return hasRole(ROLE_MINTER, account).requireTrue(
            //'denied: is not minter'
        //);
    //}
    //function _requireRoleBurner(
        //address account
    //)internal view
    //{
        //hasRole(ROLE_BURNER, account).requireTrue(
            //'denied: is not burner'
        //);
    //}
    //function _requireNotRoleMinter(
        //address account
    //)internal view
    //{
        //return hasRole(ROLE_MINTER, account).requireFalse(
            //'denied: cannot be minter'
        //);
    //}
    //function _requireNotRoleBurner(
        //address account
    //)internal view
    //{
        //hasRole(ROLE_BURNER, account).requireFalse(
            //'denied: cannot be burner'
        //);
    //}
    
    //function permitMinterRole(
        //bytes32 signerHash,
        //bytes memory signature
    //)external
    //{
        //
    //}
    //function permitBurnerRole(
        //bytes32 signerHash,
        //bytes memory signature
    //)external
    //{
        //
    //}
}