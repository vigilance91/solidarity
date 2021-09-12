// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/announcements/encoder/iEncoderEIP1129.sol";
import "https://github.com/vigilance91/solidarity/EIP/announcements/encoder/abiEncoderEIP1129.sol";
///
/// @title EIP-1129 Announcements Transaction Encoder Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
/// 
abstract contract EncoderEIP1129ABC is iEncoderEIP1129
{
    //using abiEncoderEIP1129 for uint256;
    
    constructor(
    )internal
    {
    }
    ///
    /// @return {bytes}
    /// 
    function numberOfPosts(
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEIP1129.SIG_NUMBER_OF_POSTS;
    }
    ///
    /// @return {bytes}
    /// 
    function readPost(
        uint256 postNumber
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEIP1129.readPost(
            postNumber
        );
    }
    ///
    /// @return {bytes}
    /// 
    function postAnnouncement(
        string memory post
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEIP1129.postAnnouncement(
            post
        );
    }
    ///
    /// @return {bytes}
    /// 
    function editAnnouncement(
        uint256 postNumber,
        string memory newMessage,
        string memory reason
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEIP1129.editAnnouncement(
            postNumber,
            newMessage,
            reason
        );
    }
    ///
    /// @return {bytes}
    /// 
    function removeAnnouncement(
        uint256 postNumber,
        string memory reason
    )public pure override returns(
        bytes memory
    ){
        return abiEncoderEIP1129.removeAnnouncement(
            postNumber,
            reason
        );
    }
}