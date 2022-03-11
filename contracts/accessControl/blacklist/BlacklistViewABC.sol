// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/EnumerableSet.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Address.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControlABC.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
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
abstract contract BlacklistViewABC is ContractConstraintsABC,
    NoncesABC,
    AccessControlABC
{
    using EnumerableSet for EnumerableSet.AddressSet;
    
    using logicConstraints for bool;
    using addressConstraints for address;

    string private constant _NAME = ' - BlacklistViewABC: ';
    
    string private constant _ERR_STR_ADRS = ", address: ";
    
    string private constant _ERR_IS_BLACKLISTED = string(
        abi.encodePacked(
            _NAME,
            "black-listed",
            _ERR_STR_ADRS
        )
    );
    
    string private constant _ERR_NOT_BLACKLISTED = string(
        abi.encodePacked(
            _NAME,
            "not black-listed: ",
            _ERR_STR_ADRS
        )
    );
    //bytes32 private _NAMESPACE_HASH = bytes32(uint256(keccak256('solidarity.accessControl.')) - 1);
    
    //bytes32 private constant _STORAGE_SLOT = keccak256('BlacklistABC.STORAGE_SLOT');
    //
    //bytes32 public constant ROLE_BLACKLIST_ADMIN = _NAMESPACE_HASH ^ bytes32(uint256(
        //keccak256('BlacklistABC.role.ADMIN')) -1
    //);     //has both assignor and revoker rights but can not assign other admins
    //
    //bytes32 public constant ROLE_ASSIGNOR = _NAMESPACE_HASH ^ bytes32(uint256(
        //keccak256('blacklistABC.role.ASSIGNOR')
    //));     //can issue bans
    
    //bytes32 public constant ROLE_REVOKER = _NAMESPACE_HASH ^ bytes32(uint256(
        //keccak256('BlacklistABC.role.REVOKER')
    //));   //can revoke bans
    //
    //bytes32 public constant ROLE_BANNED = _NAMESPACE_HASH ^ bytes32(uint256(
    bytes32 public constant ROLE_BANNED = keccak256('solidarity.accessControl.blacklistABC.role.BANNED');       //role assigned to banned addresses
    
    constructor(
    )internal
        ContractConstraintsABC()
        NoncesABC()
        AccessControlABC(
            //_STORAGE_SLOT
        )
        //NonPayable()
    {
    }
    
    function _isBanned(
        address account
    )internal view returns(
        bool
    ){
        return _hasRole(ROLE_BANNED, account);
    }
    //function _isBanner(
        //address accounts
    //)internal view returns(
        //bool
    //){
        //return hasRole(ROLE_BANNER, account);
    //}
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
            string(
                abi.encodePacked(
                    _ERR_IS_BLACKLISTED,
                    account
                )
            )
        );
    }
    function _requireNotBanned(
        address account
    )internal view
    {
        //contract can not ban this contract
        //account.requireNotNullAndNotThis();
        
        _isBanned(account).requireFalse(
            string(
                abi.encodePacked(
                    _ERR_NOT_BLACKLISTED,
                    account
                )
            )
        );
    }
    //
    //this contract roles
    //
    function _requireThisBanned(
    )internal view
    {
        _requireBanned(
            _this()
        );
    }
    function _requireThisNotBanned(
    )internal view
    {
        _requireNotBanned(
            _this()
        );
    }
    //
    function _bannedAddressCount(
    )internal view returns(
        uint256
    ){
        return _roleAt(ROLE_BANNED).members.length();
    }
}