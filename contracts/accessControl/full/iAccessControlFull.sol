// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/iAccessControl.sol";
import "https://github.com/vigilance91/solidarity/contracts/accessControl/batched/iAccessControlBatched.sol";
///
/// @title Full Access Control View Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 24/3/2022, All Rights Reserved
/// @dev batched and non-batched view interface for role-based access control mechanisms
///
interface iAccessControlFullView is iAccessControlView,
    iAccessControlBatchedView
{
}
///
/// @title Full Access Control Mutable Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 24/3/2022, All Rights Reserved
/// @dev batched and non-batched mutable interface for role-based access control mechanisms
///
interface iAccessControlFullMutable is iAccessControlMutable,
    iAccessControlBatchedMutable
{
}
///
/// @title Access Control Batched Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 24/3/2022, All Rights Reserved
/// @dev batched and non-batched mutable and view interface for role-based access control mechanisms
///
interface iAccessControlFull is iAccessControlFullView,
    iAccessControlFullMutable
{
}