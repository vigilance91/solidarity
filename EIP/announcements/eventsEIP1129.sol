// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

///Ethereum Improvments Proposal: Smart Contract Interface for Licences[sic]: https://eips.ethereum.org/EIPS/eip-1753
///
library eventsEIP1129Announcements
{
    event NewAnnouncement(
        bytes32 postKey,
        bytes32 authorHash,
        bytes32 messageHash,
        string message,
        uint time,
        uint blockNumber
    );
    
    event EditAnnouncement(
        bytes32 postKey,
        bytes32 authorHash,
        //bytes32 previousMessageHash,
        bytes32 newMessageHash,
        string newMessage,
        string reason,
        uint time,
        uint blockNumber
    );
    
    event RemovedAnnouncement(
        bytes32 postKey,
        bytes32 authorHash,
        bytes32 messageHash,
        string reason,
        bytes32 removerHash,
        uint time,
        uint blockNumber
    );
    function emitNewAnnouncement(
        bytes32 postKey,
        bytes32 authorHash,
        bytes32 messageHash,
        string memory message
    )public
    {
        emit NewAnnouncement(
            postKey,
            authorHash,
            messageHash,
            message,
            now,
            block.number
        );
    }
    
    function emitEditAnnouncement(
        bytes32 postKey,
        bytes32 authorHash,
        //bytes32 previousMessageHash,
        bytes32 newMessageHash,
        string memory newMessage,
        string memory reason
    )public
    {
        emit EditAnnouncement(
            postKey,
            authorHash,
            //previousMessageHash,
            newMessageHash,
            newMessage,
            reason,
            now,
            block.number
        );
    }
    
    function emitRemovedAnnouncement(
        bytes32 postKey,
        bytes32 authorHash,
        bytes32 messageHash,
        string memory reason,
        bytes32 removerHash
    )public
    {
        emit RemovedAnnouncement(
            postKey,
            authorHash,
            messageHash,
            reason,
            removerHash,
            now,
            block.number
        );
    }
}

///DEPRECATED; functionality provided by AccessControl.sol
/**
library eventsEIP1129PosterRole
{
    ///
    ///Poster Role
    ///
    event GrantPosterRole(
        address admin,
        address account,
        uint time,
        uint blockNumber
    );
    event RevokePosterRole(
        address admin,
        address account,
        string memory reason,
        uint time,
        uint blockNumber
    );
    function emitGrantPosterRole(
        address account
    )public
    {
        emit GrantPosterRole(
            msg.sender
            account,
            now,
            block.number
        );
    }
    function emitRevokePosterRole(
        address account,
        string memory reason
    )public
    {
        emit RevokePosterRole(
            msg.sender
            account,
            string memory reason,
            now,
            block.number
        );
    }
}
*/

///
///Editor Role
///DEPRECATED; functionality provided by AccessControl.sol
///
/**
library eventsEIP1129EditorRole
{
    event GrantEditorRole(
        address admin,
        address account,
        uint time,
        uint blockNumber
    );
    event RevokeEditorRole(
        address admin,
        address account,
        string memory reason,
        uint time,
        uint blockNumber
    );
    function emitGrantEditorRole(
        address account
    )public
    {
        emit GrantEditorRole(
            msg.sender
            account,
            now,
            block.number
        );
    }
    function emitRevokeEditorRole(
        address account,
        string memory reason
    )public
    {
        emit RevokeLicenseAuthority(
            msg.sender
            account,
            reason,
            now,
            block.number
        );
    }
}
*/