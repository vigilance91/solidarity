// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/blacklist/iBlacklist.sol";

//import "https://github.com/vigilance91/solidarity/contracts/accessControl/frameworkAccessControl.sol";
///
/// @title Framework Blacklist Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
///
library frameworkBlacklist
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using frameworkERC165 for address;
    using frameworkAccessControl for address;
    
    string private constant _NAME = ' frameworkBlacklist: ';
    string private constant _ERR_STR_ADRS = ', address: ';
    
    string private constant _ERR_INTERFACE_NOT_IMPLEMENTED = string(
        abi.encodePacked(
            _NAME,
            'iBlacklist not implemented',
            _ERR_STR_ADRS
        )
    );
    
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
    
    string private constant _ERR_CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            "call failed",
            _ERR_STR_ADRS
        )
    );
    string private constant _ERR_STATIC_CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            "static call failed",
            _ERR_STR_ADRS
        )
    );
    //
    //function strgin stubs
    //
    string private constant _STUB_IS_BANNED = 'isBanned(address)';
    string private constant _STUB_IS_BANNED_ARRAY = 'isBanned(address[])';
    
    string private constant _STUB_BAN = 'ban(address)';
    string private constant _STUB_BAN_ARRAY = 'ban(address[])';
    
    string private constant _STUB_REVOKE_BAN = 'revokeBan(address)';
    string private constant _STUB_REVOKE_BAN_ARRAY = 'revokeBan(address[])';
    
    //bytes private constant _CALLER_ADDRESS_HASH_SIGNATURE = abi.encodeWithSignature(
        //'callerAddressHash()'
    //);
    
    //bytes private constant _ROLE_ADMIN_SIGNATURE = abi.encodeWithSignature(
        //'ROLE_ADMIN()'
    //);
    
    bytes private constant _ROLE_BANNED_SIGNATURE = abi.encodeWithSignature(
        'ROLE_BANNED()'
    );
    
    bytes private constant _GET_BANNED_MEMBER_COUNT_SIGNATURE = abi.encodeWithSignature(
        'getBannedMemberCount()'
    );
    
    bytes4 private constant _iBLACKLIST_ID = type(iBlacklist).interfaceId;
    
    function _requireSupportsInterface(
        address target
    )private view
    {
        target.supportsInterface(_iBLACKLIST_ID).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_INTERFACE_NOT_IMPLEMENTED,
                    target
                )
            )
        );
    }
    
    function _requireBanned(
        address target,
        address account
    )internal view
    {
        isBanned(target, account).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_NOT_BLACKLISTED,
                    account
                )
            )
        );
    }
    function _requireBanned(
        address target,
        address[] memory accounts
    )internal view
    {
        bool[] memory ret = isBanned(target, accounts);
        
        for(uint i; i < accounts.length; i++){
            ret[i].requireTrue(
                string(
                    abi.encodePacked(
                        _ERR_NOT_BLACKLISTED,
                        accounts[i]
                    )
                )
            );
        }
    }
    function _requireNotBanned(
        address target,
        bytes32 role,
        address[] memory accounts
    )internal view
    {
        bool[] memory ret = isBanned(target, accounts);
        
        for(uint i; i < accounts.length; i++){
            ret[i].requireFalse(
                string(
                    abi.encodePacked(
                        _ERR_IS_BLACKLISTED,
                        accounts[i]
                    )
                )
            );
        }
    }
    //function _requireHasAdminRole(
        //bytes32 role,
        //address account
    //)internal view
    //{
        //hasRole(target, _roleAt(role).adminRole, account).requireTrue(
            ////"sender must be an admin"
        //);
    //}
    //function _requireNotHasAdminRole(
        //address target,
        //bytes32 role,
        //address account
    //)internal view
    //{
        //hasRole(target, _roleAt(role).adminRole, account).requireFalse(
            ////"sender must not be an admin"
        //);
    //}
    /**
    modifier onlyBanned(
        bytes32 role
    )internal view
    {
        _requireHasRole(role, _msgSender());
        _;
    }
    modifier onlyNotBanned(
        bytes32 role
    ){
        _requireNotHasRole(role, _msgSender());
    }
    */
    ///
    ///read-only/staticcall interface
    ///
    
    ///
    /// @return ret {bool} true if account is whitelisted, granted access to network
    ///
    function isBanned(
        address target,
        address account
    )internal view returns(
        bool ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                _STUB_IS_BANNED,
                account
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_STATIC_CALL_FAILED,
                    target
                )
            )
        );
        
        (ret) = abi.decode(result, (bool));
    }
    /// 
    /// @return ret {bool} true if account is blacklisted, denying network access
    ///
    function isBanned(
        address target,
        address[] memory accounts
    )internal view returns(
        bool[] memory ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                _STUB_IS_BANNED_ARRAY,
                accounts
            )
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_STATIC_CALL_FAILED,
                    target
                )
            )
        );
        
        (ret) = abi.decode(result, (bool[]));
    }
    */
    ///
    ///mutable interface
    ///
    
    ///
    /// @dev Grants `role` to `account`
    /// If `account` had not been already granted `role`, emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///
    function ban(
        address target,
        address account
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                _STUB_BAN,
                account
            )
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
    }
    ///
    /// @dev Grants `role` to each account in `accounts`
    /// If `account` had not been already granted `role`, emits multiple {RoleGranted} events
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role
    ///     - atomic, each account in `accounts` must not have previously been assigned `role`
    ///
    function ban(
        address target,
        address[] memory accounts
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                _STUB_BAN_ARRAY,
                accounts
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
    }
    ///
    /// @dev Revokes `role` from `account`
    /// If `account` had been granted `role`, emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///
    function revokeBan(
        address target,
        address account
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                _STUB_REVOKE_BAN,
                account
            )
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
    }
    ///
    /// @dev Revokes `role` from each accoun in `accounts`
    /// If `account` had been granted `role`, emits multiple {RoleRevoked} events
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role
    ///     - atomic, each account in `accounts` must have previously been assigned `role`
    ///
    function revokeBan(
        address target,
        address[] memory accounts
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                _STUB_REVOKE_BAN_ARRAY,
                accounts
            )
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
    }
    
    function roleBanned(
        address target
    )internal view returns(
        bytes32 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _ROLE_BANNED_SIGNATURE
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_STATIC_CALL_FAILED,
                    target
                )
            )
        );
        
        (ret) = abi.decode(result, (bytes32));
    }
    
    function getBannedMemberCount(
        address target
    )internal view returns(
        uint256 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _GET_BANNED_MEMBER_COUNT_SIGNATURE
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_STATIC_CALL_FAILED,
                    target
                )
            )
        );
        
        (ret) = abi.decode(result, (uint256));
    }
}

library frameworkBlacklistView
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using frameworkERC165 for address;
    using frameworkAccessControl for address;
    
    string private constant _NAME = ' frameworkBlacklistView: ';
    string private constant _ERR_STR_ADRS = ', address: ';
    
    string private constant _ERR_INTERFACE_NOT_IMPLEMENTED = string(
        abi.encodePacked(
            _NAME,
            'iBlacklist not implemented',
            _ERR_STR_ADRS
        )
    );
    
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
    
    string private constant _ERR_STATIC_CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            ".staticcall failed",
            _ERR_STR_ADRS
        )
    );
    //
    //function strgin stubs
    //
    string private constant _STUB_IS_BANNED = 'isBanned(address)';
    string private constant _STUB_IS_BANNED_ARRAY = 'isBanned(address[])';
    
    //bytes private constant _CALLER_ADDRESS_HASH_SIGNATURE = abi.encodeWithSignature(
        //'callerAddressHash()'
    //);
    
    //bytes private constant _ROLE_ADMIN_SIGNATURE = abi.encodeWithSignature(
        //'ROLE_ADMIN()'
    //);
    
    bytes private constant _ROLE_BANNED_SIGNATURE = abi.encodeWithSignature(
        'ROLE_BANNED()'
    );
    
    bytes private constant _GET_BANNED_MEMBER_COUNT_SIGNATURE = abi.encodeWithSignature(
        'getBannedMemberCount()'
    );
    
    bytes4 private constant _iBLACKLIST_ID = type(iBlacklist).interfaceId;
    //bytes4 internal constant IID_BLACKLIST_VIEW = type(iBlacklistView).interfaceId;
    
    function _requireSupportsInterface(
        address target
    )private view
    {
        target.supportsInterface(_iBLACKLIST_ID).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_INTERFACE_NOT_IMPLEMENTED,
                    target
                )
            )
        );
    }
    
    function _requireBanned(
        address target,
        address account
    )internal view
    {
        isBanned(target, account).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_NOT_BLACKLISTED,
                    account
                )
            )
        );
    }
    function _requireBanned(
        address target,
        address[] memory accounts
    )internal view
    {
        bool[] memory ret = isBanned(target, accounts);
        
        for(uint i; i < accounts.length; i++){
            ret[i].requireTrue(
                string(
                    abi.encodePacked(
                        _ERR_NOT_BLACKLISTED,
                        accounts[i]
                    )
                )
            );
        }
    }
    function _requireNotBanned(
        address target,
        bytes32 role,
        address[] memory accounts
    )internal view
    {
        bool[] memory ret = isBanned(target, accounts);
        
        for(uint i; i < accounts.length; i++){
            ret[i].requireFalse(
                string(
                    abi.encodePacked(
                        _ERR_IS_BLACKLISTED,
                        accounts[i]
                    )
                )
            );
        }
    }
    //function _requireHasAdminRole(
        //bytes32 role,
        //address account
    //)internal view
    //{
        //hasRole(target, _roleAt(role).adminRole, account).requireTrue(
            ////"sender must be an admin"
        //);
    //}
    //function _requireNotHasAdminRole(
        //address target,
        //bytes32 role,
        //address account
    //)internal view
    //{
        //hasRole(target, _roleAt(role).adminRole, account).requireFalse(
            ////"sender must not be an admin"
        //);
    //}
    /**
    modifier onlyBanned(
        bytes32 role
    )internal view
    {
        _requireHasRole(role, _msgSender());
        _;
    }
    modifier onlyNotBanned(
        bytes32 role
    ){
        _requireNotHasRole(role, _msgSender());
    }
    */
    ///
    ///read-only/staticcall interface
    ///
    
    ///
    /// @return ret {bool} true if account is whitelisted, granted access to network
    ///
    function isBanned(
        address target,
        address account
    )internal view returns(
        bool ret
    ){
        //target.requireSupportsInterfaceBlacklistView();
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                _STUB_IS_BANNED,
                account
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_STATIC_CALL_FAILED,
                    target
                )
            )
        );
        
        (ret) = abi.decode(result, (bool));
    }
    /// 
    /// @return ret {bool} true if account is blacklisted, denying network access
    ///
    function isBanned(
        address target,
        address[] memory accounts
    )internal view returns(
        bool[] memory ret
    ){
        //target.requireSupportsInterfaceBlacklistView();
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                _STUB_IS_BANNED_ARRAY,
                accounts
            )
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_STATIC_CALL_FAILED,
                    target
                    //accounts
                )
            )
        );
        
        (ret) = abi.decode(result, (bool[]));
    }
    function roleBanned(
        address target
    )internal view returns(
        bytes32 ret
    ){
        //target.requireSupportsInterfaceBlacklistView();
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _ROLE_BANNED_SIGNATURE
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_STATIC_CALL_FAILED,
                    target
                )
            )
        );
        
        (ret) = abi.decode(result, (bytes32));
    }
    
    function getBannedMemberCount(
        address target
    )internal view returns(
        uint256 ret
    ){
        //target.requireSupportsInterfaceBlacklistView();
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _GET_BANNED_MEMBER_COUNT_SIGNATURE
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_STATIC_CALL_FAILED,
                    target
                )
            )
        );
        
        (ret) = abi.decode(result, (uint256));
    }
}


library frameworkBlacklistMutable
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using frameworkERC165 for address;
    using frameworkAccessControl for address;
    
    string private constant _NAME = ' frameworkBlacklistMutable: ';
    string private constant _ERR_STR_ADRS = ', address: ';
    
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
    
    string private constant _ERR_CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            "call failed",
            _ERR_STR_ADRS
        )
    );
    //
    //function stubs
    //
    string internal constant STUB_BAN = 'ban(address)';
    string internal constant STUB_BAN_ARRAY = 'ban(address[])';
    
    string internal constant STUB_REVOKE_BAN = 'revokeBan(address)';
    string internal constant STUB_REVOKE_BAN_ARRAY = 'revokeBan(address[])';
    
    bytes4 private constant _iBLACKLIST_ID = type(iBlacklist).interfaceId;
    //bytes4 private constant IID_BLACKLIST_MUTABLE = type(iBlacklistMutable).interfaceId;
    ///
    /// @dev Grants `role` to `account`
    /// If `account` had not been already granted `role`, emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///
    function ban(
        address target,
        address account
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                _STUB_BAN,
                account
            )
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
    }
    ///
    /// @dev Grants `role` to each account in `accounts`
    /// If `account` had not been already granted `role`, emits multiple {RoleGranted} events
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role
    ///     - atomic, each account in `accounts` must not have previously been assigned `role`
    ///
    function ban(
        address target,
        address[] memory accounts
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                _STUB_BAN_ARRAY,
                accounts
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
    }
    ///
    /// @dev Revokes `role` from `account`
    /// If `account` had been granted `role`, emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///
    function revokeBan(
        address target,
        address account
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                _STUB_REVOKE_BAN,
                account
            )
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
    }
    ///
    /// @dev Revokes `role` from each accoun in `accounts`
    /// If `account` had been granted `role`, emits multiple {RoleRevoked} events
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role
    ///     - atomic, each account in `accounts` must have previously been assigned `role`
    ///
    function revokeBan(
        address target,
        address[] memory accounts
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                _STUB_REVOKE_BAN_ARRAY,
                accounts
            )
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
    }
}

library frameworkBlacklistDelegate
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using frameworkERC165 for address;
    
    //using frameworkBlacklistInterfaceSupport for address;
    using frameworkAccessControl for address;
    
    string private constant _NAME = ' frameworkBlacklistDelegate: ';
    string private constant _ERR_STR_DELEGATE = ', delegate: ';
    
    string private constant _ERR_CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            ".delegatecall failed",
            _ERR_STR_DELEGATE
        )
    );
    //
    //function stubs
    //
    string internal constant _STUB_BAN = 'ban(address)';
    string internal constant _STUB_BAN_ARRAY = 'ban(address[])';
    
    string internal constant _STUB_REVOKE_BAN = 'revokeBan(address)';
    string internal constant _STUB_REVOKE_BAN_ARRAY = 'revokeBan(address[])';
    
    bytes4 private constant _iBLACKLIST_ID = type(iBlacklist).interfaceId;
    //bytes4 private constant IID_BLACKLIST_MUTABLE = type(iBlacklistMutable).interfaceId;
    ///
    /// @dev Grants `role` to `account`
    /// If `account` had not been already granted `role`, emits a {RoleGranted} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///
    function ban(
        address target,
        address account
    )internal
    {
        //target.requireSupportsInterfaceBlacklistMutable();
        _requireSupportsInterface(target);
        
        (bool success, ) = target.delegatecall(
            abi.encodeWithSignature(
                _STUB_BAN,
                account
            )
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
    }
    ///
    /// @dev Grants `role` to each account in `accounts`
    /// If `account` had not been already granted `role`, emits multiple {RoleGranted} events
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role
    ///     - atomic, each account in `accounts` must not have previously been assigned `role`
    ///
    function ban(
        address target,
        address[] memory accounts
    )internal
    {
        //target.requireSupportsInterfaceBlacklistMutable();
        _requireSupportsInterface(target);
        
        (bool success, ) = target.delegatecall(
            abi.encodeWithSignature(
                _STUB_BAN_ARRAY,
                accounts
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
    }
    ///
    /// @dev Revokes `role` from `account`
    /// If `account` had been granted `role`, emits a {RoleRevoked} event
    ///
    /// Requirements:
    ///     - the caller must have ``role``'s admin role
    ///
    function revokeBan(
        address target,
        address account
    )internal
    {
        //target.requireSupportsInterfaceBlacklistMutable();
        _requireSupportsInterface(target);
        
        (bool success, ) = target.delegatecall(
            abi.encodeWithSignature(
                _STUB_REVOKE_BAN,
                account
            )
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
    }
    ///
    /// @dev Revokes `role` from each accoun in `accounts`
    /// If `account` had been granted `role`, emits multiple {RoleRevoked} events
    ///
    /// Requirements:
    ///     - the caller must have `role`'s admin role
    ///     - atomic, each account in `accounts` must have previously been assigned `role`
    ///
    function revokeBan(
        address target,
        address[] memory accounts
    )internal
    {
        //target.requireSupportsInterfaceBlacklistMutable();
        _requireSupportsInterface(target);
        
        (bool success, ) = target.delegatecall(
            abi.encodeWithSignature(
                _STUB_REVOKE_BAN_ARRAY,
                accounts
            )
        );
        
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
    }
}