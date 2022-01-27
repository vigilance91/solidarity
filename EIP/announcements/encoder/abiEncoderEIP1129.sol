// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

///
/// @dev EIP-1129 Announcements Transaction ABI Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
///
library abiEncoderEIP1129
{
    //
    //getter stubs
    //
    bytes internal constant SIG_NUMBER_OF_POSTS = abi.encodeWithSignature(
        'numberOfPosts()'
    );
    
    string internal constant STUB_READ_POST = 'readPost(uint256)';
    //
    //mutable stubs
    //
    string internal constant STUB_POST_ANNOUNCEMENT = 'postAnnouncement(string)';
    string internal constant STUB_EDIT_ANNOUNCEMENT = 'editAnnouncement(uint256,string,string)';
    string internal constant STUB_REMOVE_ANNOUNCEMENT = 'removeAnnouncement(uint256,string)';
    ///
    /// get the author hash, post hash and post content for the post with postNumber
    /// 
    function readPost(
        uint256 postNumber
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_READ_POST,
            postNumber
        );
    }
    ///
    ///mutable interface
    ///
    //DEPRECATED this same behaviour is achieved by AccessControl via, grantRole(ROLE_POSTER)
    //function givePostingPermission(
        //address _newAnnouncer,
        //bool _postingPrivileges,
        //string _posterName
    //)internal onlyOwner returns(
        //bool success
    //);
    
    function postAnnouncement(
        string memory post
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_POST_ANNOUNCEMENT,
            post
        );
    }
    
    function editAnnouncement(
        uint256 postNumber,
        string memory newMessage,
        string memory reason
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_EDIT_ANNOUNCEMENT,
            postNumber,
            newMessage,
            reason
        );
    }
    
    function removeAnnouncement(
        uint256 postNumber,
        string memory reason
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_REMOVE_ANNOUNCEMENT,
            postNumber,
            reason
        );
    }
}