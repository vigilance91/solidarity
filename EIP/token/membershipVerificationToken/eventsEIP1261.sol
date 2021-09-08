// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.7.0;
pragma experimental ABIEncoderV2;
///
/// @title EIP1261 Events
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/7/2021, All Rights Reserved
/// @dev emitter and events relavent to ERC1261 standard
///
library eventsEIP1261
{
    /// @dev on token assignment
    event membershipAssigned(
        address target,
        uint[] memory attributeIndexes
        //uint time,
        //uint block
    );

    /// @dev on membership revoked
    event membershipRevoked(
        address target
        //uint time,
        //uint block
    );

    /// @dev membership forfeited
    event membershipForfeited(
        address target
        //uint time,
        //uint block
    );

    /// @dev membership request accepted
    event embershipApproved(
        address target,
        uint[] memory attributeIndexes
    );

    /// @dev membership request
    event membershipRequested(
        address target
        //uint time,
        //uint block
    );

    /// @dev member data modified, doesn't emit when a new membership is created and data is assigned
    event modifiedAttributes(
        address target,
        uint attributeIndex,
        uint attributeValueIndex
        //uint time,
        //uint block
    );

    ///
    ///emitter functions
    ///
    function emitMembershipAssigned(
        address target,
        uint[] memory attributeIndexes
    )internal
    {
        emit membershipAssigned(
            target,
            attributeIndexes
            //block.timestamp
            //block.number
        );
    }

    /// @dev on membership revoked
    function emitMembershipRevoked(
        address target
    )internal
    {
        emit membershipRevoked(
            target
            //block.timestamp
            //block.number
        );
    }

    /// @dev membership forfeited
    function emitMembershipForfeited(
        address target
    )internal
    {
        emit membershipForfeited(
            target
            //block.timestamp
            //block.number
        );
    }

    /// @dev membership request accepted
    function emitMembershipApproved(
        address target,
        uint[] memory attributeIndices
    )internal
    {
        emit membershipApproved(
            target,
            attributeIndices
            //block.timestamp
            //block.number
        );
    }

    /// @dev membership request
    function emitMembershipRequested(
        address target
    )internal
    {
        emit membershipRequested(
            target
            //block.timestamp
            //block.number
        );
    }

    /// @dev member data modified, doesn't emit when a new membership is created and data is assigned
    function emitModifiedAttributes(
        address target,
        uint attributeIndex,
        uint attributeValueIndex
    )internal view
    {
        emit modifiedAttributes(
            target,
            attributeIndex,
            attributeValueIndex
            //block.timestamp
            //block.number
        );
    }
}