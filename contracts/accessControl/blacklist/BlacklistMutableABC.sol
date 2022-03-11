// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControlViewABC.sol";
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
abstract contract BlacklistMutableABC is BlacklistViewABC
{
    using EnumerableSet for EnumerableSet.AddressSet;
    
    using logicConstraints for bool;
    using addressConstraints for address;

    string private constant _NAME = ' - BlacklistMutableABC: ';
    
    string private constant _ERR_STR_ADRS = ", address: ";
    
    //bytes32 private _NAMESPACE_HASH = bytes32(uint256(keccak256('solidarity.accessControl.')) - 1);
    
    //bytes32 private constant _STORAGE_SLOT = _NAMESPACE_HASH ^ bytes32(uint256(
        //keccak256('BlacklistABC.STORAGE_SLOT')
    //) - 1);
    //
    constructor(
    )internal
        BlacklistViewABC()  //_STORAGE_SLOT)
    {
    }
    
    function _ban(
        address account
    )internal
    {
        _requireNotBanned(account);
        
        _grantRole(ROLE_BANNED, account);
        
        _incrementNonce(account);
    }
    function _revokeBan(
        address account
    )internal
    {
        _requireBanned(account);
        
        _revokeRole(ROLE_BANNED, account);
        
        _incrementNonce(account);
    }
}
/*
contract Blacklist is BlacklistMutableABC,
    //iBlacklist
{
    constructor(
    )internal
        BlacklistMutableABC()
    {
    }
}

contract BlacklistBatched is Blacklist,
    iBlacklistBatched
{
    constructor(
    )internal
        Blacklist()
    {
    }
}
*/