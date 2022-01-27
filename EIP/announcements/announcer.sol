// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//Ethereum Improvments Proposal: Standard DAPP Announcements - https://eips.ethereum.org/EIPS/eip-1129
library announcer
{
    using stringUtilities for string;
    //using bytes32Logic for bytes32;
    
    struct data{
        bytes32 posterHash;
    }
    
    function initialize(
        address platform,
        address poster
    )internal
    {
        return new data(
            platform.hexadecimal().saltAndHash(
                poster.hexadecimal()
            )
        );
    }
}