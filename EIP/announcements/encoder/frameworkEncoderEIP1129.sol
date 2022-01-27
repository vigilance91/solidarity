// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/EIP/announcements/encoder/iEncoderEIP1129.sol";
///
/// @dev EIP-1129 Announcements Transaction Encoder Framework Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
///
library frameworkEncoderEIP1129
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    bytes4 private constant _INTERFACE_ID = type(iEncoderEIP1129).interfaceId;
    
    function _requireSupportsInterface(
        address encoder
    )private
    {
        encoder.requireNotNull();
        encoder.isContract().requireTrue(
            'address not a contract'
        );
        
        encoder.supportsInterface(_INTERFACE_ID).requireTrue(
            'contract does not implement iEncoderEIP1753'
        );
    }
    function numberOfPosts(
        address encoder
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1129(encoder).numberOfPosts();
    }
    ///get the author hash, post hash and post content for the post with postNumber
    function readPost(
        address encoder,
        uint256 postNumber
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1129(encoder).readPost(postNumber);
    }
    ///
    ///mutable interface
    ///
    //DEPRECATED this same behaviour is achieved by AccessControl via, grantRole(ROLE_POSTER)
    //function givePostingPermission(
        //address encoder,
        //address _newAnnouncer,
        //bool _postingPrivileges,
        //string _posterName
    //)internal onlyOwner returns(
        //bytes memory
    //){
    //}
    
    function postAnnouncement(
        address encoder,
        string memory post
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1129(encoder).postAnnouncement(post);
    }
    
    function editAnnouncement(
        address encoder,
        uint256 postNumber,
        string memory newMessage,
        string memory reason
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1129(encoder).editAnnouncement(
            postNumber,
            newMessage,
            reason
        );
    }
    
    function removeAnnouncement(
        address encoder,
        uint256 postNumber,
        string memory reason
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1129(encoder).removeAnnouncement(
            postNumber,
            reason
        );
    }
}