// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP1129 Announcements Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 8/4/2021, All Rights Reserved
/// @dev Bsed On:
///     Ethereum Improvments Proposal: Standard DAPP Announcements - https://eips.ethereum.org/EIPS/eip-1129
///
interface iEIP1129
{
    ///
    ///read-only interface
    ///
    ///total number of posts
    function numberOfPosts(
    )external view returns(
        uint256
    );
    ///get the author hash, post hash and post content for the post with postNumber
    function readPost(
        uint256 postNumber
    )external view returns(
        bytes32 authorHash,
        bytes32 postHash,
        string memory post
    );
    ///
    ///mutable interface
    ///
    //DEPRECATED this same behaviour is achieved by AccessControl via, grantRole(ROLE_POSTER)
    //function givePostingPermission(
        //address _newAnnouncer,
        //bool _postingPrivileges,
        //string _posterName
    //)external onlyOwner returns(
        //bool success
    //);
    
    function postAnnouncement(
        string memory post
    )external;
    
    function editAnnouncement(
        uint256 postNumber,
        string memory newMessage,
        string memory reason
    )external;
    
    function removeAnnouncement(
        uint256 postNumber,
        string memory reason
    )external;
}