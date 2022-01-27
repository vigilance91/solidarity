// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/libraries/logicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/block/chronoConstraints.sol";
/// 
/// @title chronological Constraints Library based on utilizing both block.timestamp and block.height for determining timepoints
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/3/2021, All Rights Reserved
///
library chronoConstraints
{
    using logicConstraints for bool;
    
    using blockTimeLogic for uint;
    
    string private constant _NAME = " - blocktimeConstraints: ";
    
    /// >
    function requireblockTimeNowGreaterThan(
        uint rhs,
        uint avgBlockDuration
    )internal pure returns(
        bool
    ){
        rhs.blockTimeNowGreaterThan(avgBlockDuration).requireTrue(
            //''
        );
    }
    function requireChronoNowGreaterThanOrEqual(
        uint rhs,
        uint avgBlockDuration
    )internal pure returns(
        bool
    ){
        rhs.blockTimeNowGreaterThanOrEqual(avgBlockDuration).requireTrue(
            //''
        );
    }
    /// <
    function requireChronoNowLessThan(
        uint rhs,
        uint avgBlockDuration
    )internal pure returns(
        bool
    ){
        rhs.blockTimeNowLessThan(avgBlockDuration).requireTrue(
            //''
        );
    }
    function requireChronoNowLessThanOrEqual(
        uint rhs,
        uint avgBlockDuration
    )internal pure returns(
        bool
    ){
        rhs.blockTimeNowLessThanOrEqual(avgBlockDuration).requireTrue(
            //''
        );
    }
    ///
    ///optional message overloads
    ///
    function requireblockTimeNowGreaterThan(
        uint rhs,
        uint avgBlockDuration,
        string memory message
    )internal pure returns(
        bool
    ){
        rhs.blockTimeNowGreaterThan(avgBlockDuration).requireTrue(
            message
        );
    }
    function requireChronoNowGreaterThanOrEqual(
        uint rhs,
        uint avgBlockDuration,
        string memory message
    )internal pure returns(
        bool
    ){
        rhs.blockTimeNowGreaterThanOrEqual(avgBlockDuration).requireTrue(
            message
        );
    }
    /// <
    function requireChronoNowLessThan(
        uint rhs,
        uint avgBlockDuration,
        string memory message
    )internal pure returns(
        bool
    ){
        rhs.blockTimeNowLessThan(avgBlockDuration).requireTrue(
            message
        );
    }
    function requireChronoNowLessThanOrEqual(
        uint rhs,
        uint avgBlockDuration,
        string memory message
    )internal pure returns(
        bool
    ){
        rhs.blockTimeNowLessThanOrEqual(avgBlockDuration).requireTrue(
            message
        );
    }
}