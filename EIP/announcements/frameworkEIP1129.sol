// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/frameworkAccessControl.sol";

import "https://github.com/vigilance91/solidarity/EIP/announcements/iEIP1129.sol";
///
/// @title EIP1129 Framework Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/5/2021, All Rights Reserved
/// @dev based on Ethereum Improvments Proposal: Standard DAPP Announcements - https://eips.ethereum.org/EIPS/eip-1129
///
library frameworkEIP1129
{
    using frameworkERC165 for address;
    
    using frameworkAccessControl for address;
    
    using logicConstraints for bool;
    
    bytes private constant _NUMBER_OF_POST_SIGNATURE = abi.encodeWithSignature(
        'numberOfPosts()'
    );
    bytes private constant _ROLE_POSTER_SIGNATURE = abi.encodeWithSignature(
        'ROLE_POSTER()'
    );
    bytes private constant _ROLE_EDITOR_SIGNATURE = abi.encodeWithSignature(
        'ROLE_EDITOR()'
    );
    bytes4 private constant _iEIP1129_ID = type(iEIP1129).interfaceId;
    
    //function castEIP1129
        //address announcements
    //)internal pure returns(
        //iEIP1129
    //){
        //_requireSupportsInterfaceEIP1129(announcements);
        //
        //return iEIP1129(announcements);
    //}
    //function thisCastEIP1129(
    //)internal pure returns(
        //iEIP1129
    //){
        //return castEIP1129(
            //address(this)
        //);
    //}
    ///
    ///read-only interface
    ///
    function _supportsInterface(
        address target
    )internal view returns(
        bool ret
    ){
        return target.supportsInterface(_iEIP1129_ID);
    }
    function _requireSupportsInterface(
        address target
    )internal view
    {
        _supportsInterface(target).requireTrue(
            'contract does not implement iEIP1129'
        );
        //return false;
    }
    //
    //roles
    //
    function rolePoster(
        address target
    )public view returns(
        bytes32 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _ROLE_POSTER_SIGNATURE
        );
        success.requireTrue('static call failed');
        
        (ret) = abi.decode(result, (bytes32));
    }
    function roleEditor(
        address target
    )public view returns(
        bytes32 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _ROLE_EDITOR_SIGNATURE
        );
        success.requireTrue('static call failed');
        
        (ret) = abi.decode(result, (bytes32));
    }
    
    function hasRolePoster(
        address target,
        address account
    )public view returns(
        bool ret
    ){
        bytes32 ROLE = rolePoster(target);
        
        return target.hasRole(
            ROLE,
            account
        );
    }
    function hasRoleEditor(
        address target,
        address account
    )public view returns(
        bool ret
    ){
        bytes32 ROLE = roleEditor(target);
        
        return target.hasRole(
            ROLE,
            account
        );
    }
    function numberOfPosts(
        address target
    )public view returns(
        uint256 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _NUMBER_OF_POST_SIGNATURE
        );
        success.requireTrue('call failed');
        
        (ret) = abi.decode(result, (uint256));
    }
    ///get the author hash, post hash and post content for the post with postNumber
    function readPost(
        address target,
        uint256 postNumber
    )public view returns(
        bytes32 authorHash,
        bytes32 postHash,
        string memory post
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                'readPost(uint256)',
                postNumber
            )
        );
        success.requireTrue('call failed');
        
        (authorHash,postHash,post) = abi.decode(
            result,
            (bytes32,bytes32,string)
        );
    }
    ///
    ///mutable interface
    ///
    function postAnnouncement(
        address target,
        string memory post
    )public
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                'postAnnouncement(string)',
                post
            )
        );
        success.requireTrue('call failed');
    }
    
    function editAnnouncement(
        address target,
        uint256 postNumber,
        string memory newMessage,
        string memory reason
    )public
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                'editAnnouncement(uint256,string,string)',
                postNumber,
                newMessage,
                reason
            )
        );
        success.requireTrue('call failed');
    }
    
    function removeAnnouncement(
        address target,
        uint256 postNumber,
        string memory reason
    )public
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                'removeAnnouncement(uint256,string)',
                postNumber,
                reason
            )
        );
        success.requireTrue('call failed');
    }
}

library frameworkEIP1129View
{
    using frameworkERC165 for address;
    
    using frameworkAccessControl for address;
    
    using logicConstraints for bool;
    
    bytes private constant _NUMBER_OF_POST_SIGNATURE = abi.encodeWithSignature(
        'numberOfPosts()'
    );
    bytes private constant _ROLE_POSTER_SIGNATURE = abi.encodeWithSignature(
        'ROLE_POSTER()'
    );
    bytes private constant _ROLE_EDITOR_SIGNATURE = abi.encodeWithSignature(
        'ROLE_EDITOR()'
    );
    bytes4 private constant _iEIP1129_ID = type(iEIP1129).interfaceId;
    //bytes4 private constant IID_EIP1129_VIEW = type(iEIP1129View).interfaceId;
    
    
    string internal constant _NAME = ' frameworkEIP1129View: ';
    string internal constant _ERR_STR_TARGET = ', target: ';
    
    string internal constant _ERR_STATIC_CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            '.staticcall failed',
            _ERR_STR_TARGET
        )
    );
    
    //function castEIP1129
        //address announcements
    //)internal pure returns(
        //iEIP1129
    //){
        //_requireSupportsInterfaceEIP1129(announcements);
        //
        //return iEIP1129(announcements);
    //}
    //function thisCastEIP1129(
    //)internal pure returns(
        //iEIP1129
    //){
        //return castEIP1129(
            //address(this)
        //);
    //}
    ///
    ///read-only interface
    ///
    function _supportsInterface(
        address target
    )internal view returns(
        bool ret
    ){
        return target.supportsInterface(_iEIP1129_ID);
    }
    function _requireSupportsInterface(
        address target
    )internal view
    {
        _supportsInterface(target).requireTrue(
            'contract does not implement iEIP1129'
        );
        //return false;
    }
    //
    //roles
    //
    function rolePoster(
        address target
    )internal view returns(
        bytes32 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _ROLE_POSTER_SIGNATURE
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
    function roleEditor(
        address target
    )internal view returns(
        bytes32 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _ROLE_EDITOR_SIGNATURE
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
    
    function hasRolePoster(
        address target,
        address account
    )internal view returns(
        bool ret
    ){
        bytes32 ROLE = rolePoster(target);
        
        return target.hasRole(
            ROLE,
            account
        );
    }
    function hasRoleEditor(
        address target,
        address account
    )internal view returns(
        bool ret
    ){
        bytes32 ROLE = roleEditor(target);
        
        return target.hasRole(
            ROLE,
            account
        );
    }
    function numberOfPosts(
        address target
    )internal view returns(
        uint256 ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            _NUMBER_OF_POST_SIGNATURE
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
    ///get the author hash, post hash and post content for the post with postNumber
    function readPost(
        address target,
        uint256 postNumber
    )internal view returns(
        bytes32 authorHash,
        bytes32 postHash,
        string memory post
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                'readPost(uint256)',
                postNumber
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
        
        (authorHash,postHash,post) = abi.decode(
            result,
            (bytes32,bytes32,string)
        );
    }
}

library frameworkEIP1129Mutable
{
    string internal constant _NAME = ' frameworkEIP1129Mutable: ';
    string internal constant _ERR_STR_TARGET = ', target: ';
    
    string internal constant _ERR_CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            '.call failed',
            _ERR_STR_TARGET
        )
    );
    function postAnnouncement(
        address target,
        string memory post
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                'postAnnouncement(string)',
                post
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
    
    function editAnnouncement(
        address target,
        uint256 postNumber,
        string memory newMessage,
        string memory reason
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                'editAnnouncement(uint256,string,string)',
                postNumber,
                newMessage,
                reason
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
    
    function removeAnnouncement(
        address target,
        uint256 postNumber,
        string memory reason
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                'removeAnnouncement(uint256,string)',
                postNumber,
                reason
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

library frameworkEIP1129Delegate
{
    string internal constant _NAME = ' frameworkEIP1129Delegate: ';
    string internal constant _ERR_STR_DELEGATE = ', delegate: ';
    
    string internal constant _ERR_CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            '.delegatecall failed',
            _ERR_STR_DELEGATE
        )
    );
    
    function postAnnouncement(
        address target,
        string memory post
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.delegatecall(
            abi.encodeWithSignature(
                'postAnnouncement(string)',
                post
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
    
    function editAnnouncement(
        address target,
        uint256 postNumber,
        string memory newMessage,
        string memory reason
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.delegatecall(
            abi.encodeWithSignature(
                'editAnnouncement(uint256,string,string)',
                postNumber,
                newMessage,
                reason
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
    
    function removeAnnouncement(
        address target,
        uint256 postNumber,
        string memory reason
    )internal
    {
        _requireSupportsInterface(target);
        
        (bool success, ) = target.delegatecall(
            abi.encodeWithSignature(
                'removeAnnouncement(uint256,string)',
                postNumber,
                reason
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