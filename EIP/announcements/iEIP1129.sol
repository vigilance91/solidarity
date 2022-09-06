// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
/// 
/// @title EIP1129 Announcements View Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 23/12/2021, All Rights Reserved
/// @dev Bsed On:
///     Ethereum Improvments Proposal: Standard DAPP Announcements - https://eips.ethereum.org/EIPS/eip-1129
///
interface iEIP1129View
{
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
}
///
/// @title EIP1129 Announcements Mutable Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 23/12/2021, All Rights Reserved
/// @dev Bsed On:
///     Ethereum Improvments Proposal: Standard DAPP Announcements - https://eips.ethereum.org/EIPS/eip-1129
///
interface iEIP1129Mutable
{
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

/*
interface iEIP1129ViewBatched
{
    ///get the author hash, post hash and post content for the post with postNumber
    function readPosts(
        uint256[] calldata postNumbers
    )external view returns(
        //mixinEIP1129.readPostData[] memory
        bytes32[] memory authorHashes,
        bytes32[] memory postHashes,
        string[] memory memory posts
    );
}
interface iEIP1129MutableBatched
{
    function postAnnouncement(
        string[] calldata posts
    )external;
    
    function editAnnouncement(
        uint256[] calldata postNumbers,
        string[] calldata memory newMessages,
        string[] calldata memory reasons
    )external;
    
    function removeAnnouncement(
        uint256[] calldata postNumbers,
        string[] calldata reasons
    )external;
}
*/
///
/// @title EIP1129 Announcements Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 8/4/2021, All Rights Reserved
/// @dev Bsed On:
///     Ethereum Improvments Proposal: Standard DAPP Announcements - https://eips.ethereum.org/EIPS/eip-1129
///
interface iEIP1129 is iEIP1129View,
    iEIP1129Mutable
{
}