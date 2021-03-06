// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/EnumerableSet.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Address.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControl.sol";
///
/// @title Access Control Blacklist Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/5/2021, All Rights Reserved
/// @dev inspired by OpenZeppelin's AccessControl contract at:
///    https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/access/AccessControl.sol
/// 
/// Maintain an enumerable map containing all black-listed addresses, to be denied service
///
/// These addresses are usually associated with known malicious users,
/// fake/impostor tokens, malicious or buggy contracts with known hacks,
/// or those with other known and demonstrated security vulnerabilities or exploits
/// for a list of known malicious, bug or otherwise vulnerable tokens can be found here:
///     https://tokensniffer.com/
///
abstract contract BlacklistABC is AccessControl
{
    using EnumerableSet for EnumerableSet.AddressSet;
    
    using LogicConstraints for bool;
    using AddressConstraints for address;

    string private constant _NAME = ' BlacklistABC: ';
    
    bytes32 public constant ROLE_BANNED = keccak256('solidarity.blacklist.role.banned');
    
    constructor(
    )internal AccessControl()
    {
    }
    
    function _isBanned(
        address account
    )internal view returns(
        bool
    ){
        return hasRole(ROLE_BANNED, account);
    }
    ///
    ///constraints
    ///
    function _requireBanned(
        address account
    )internal view
    {
        //prevent accidentally banning this contract
        //account.requireNotNullAndNotThis();
        
        _isBanned(account).requireTrue(
            //"address is banned"
        );
    }
    function _requireNotBanned(
        address account
    )internal view
    {
        //contract can not ban this contract
        //account.requireNotNullAndNotThis();
        
        _isBanned(account).requireFalse(
            //"address is not banned"
        );
    }
    function _bannedAddressCount(
    )internal view returns(
        uint256
    ){
        return _roleAt(ROLE_BANNED).members.length();
    }
    function _ban(
        address account
    )internal
    {
        _requireNotBanned(account);
        
        _grantRole(ROLE_BANNED, account);
    }
    function _revokeBan(
        address account
    )internal
    {
        _requireBanned(account);
        
        _revokeRole(ROLE_BANNED, account);
    }
}