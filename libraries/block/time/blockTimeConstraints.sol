// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";

import "https://github.com/vigilance91/solidarity/libraries/block/time/blockTimeLogic.sol";
/// 
/// @title chronological Constraints Library based on utilizing both block.timestamp and block.height for determining timepoints
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/3/2021, All Rights Reserved
///
library blockTimeConstraints
{
    using logicConstraints for bool;
    
    using blockTimeLogic for uint;
    
    string private constant _NAME = " - blockTimeConstraints: ";
    
    /// >
    function requireBlockTimeGreaterThan(
        uint rhs
        //uint avgBlockDuration
    )internal view returns(
        bool
    ){
        rhs.blockTimeNowGreaterThan().requireTrue(
            //''
        );
    }
    function requireBlockTimeGreaterThanOrEqual(
        uint rhs
        //uint avgBlockDuration
    )internal view returns(
        bool
    ){
        rhs.blockTimeNowGreaterThanOrEqual().requireTrue(
            //''
        );
    }
    /// <
    function requireBlockTimeLessThan(
        uint rhs
        //uint avgBlockDuration
    )internal view returns(
        bool
    ){
        rhs.blockTimeNowLessThan().requireTrue(
            //''
        );
    }
    function requireBlockTimeLessThanOrEqual(
        uint rhs
        //uint avgBlockDuration
    )internal view returns(
        bool
    ){
        rhs.blockTimeNowLessThanOrEqual().requireTrue(
            //''
        );
    }
    ///
    ///optional message overloads
    ///
    function requireBlockTimeGreaterThan(
        uint rhs,
        //uint avgBlockDuration,
        string memory message
    )internal view returns(
        bool
    ){
        rhs.blockTimeNowGreaterThan().requireTrue(
            message
        );
    }
    function requireBlockTimeGreaterThanOrEqual(
        uint rhs,
        //uint avgBlockDuration,
        string memory message
    )internal view returns(
        bool
    ){
        rhs.blockTimeNowGreaterThanOrEqual().requireTrue(
            message
        );
    }
    /// <
    function requireBlockTimeLessThan(
        uint rhs,
        //uint avgBlockDuration,
        string memory message
    )internal view returns(
        bool
    ){
        rhs.blockTimeNowLessThan().requireTrue(
            message
        );
    }
    function requireBlockTimeLessThanOrEqual(
        uint rhs,
        //uint avgBlockDuration,
        string memory message
    )internal view returns(
        bool
    ){
        rhs.blockTimeNowLessThanOrEqual().requireTrue(
            message
        );
    }
}