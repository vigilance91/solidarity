// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/addressToString.sol";
import "https://github.com/vigilance91/solidarity/libraries/string/stringUtilities.sol";

///
/// @title EIP1129 Announcement Utility Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 8/4/2021, All Rights Reserved
/// @dev Based On:
///     Ethereum Improvments Proposal: Standard DAPP Announcements - https://eips.ethereum.org/EIPS/eip-1129
library announcement
{
    using SafeMath for uint;
    
    using bytes32Logic for bytes32;
    using stringUtilities for string;
    
    struct data{
        //announcer.Announcer poster;
        bytes32 authorHash;   //unique hash, used to verify the author and/or platform
        bytes32 postHash;   //unique hash, used to verify the author and/or platform
        string author;
        //
        string post;
        //uint createdTime;    //timestamp of post
        //uint createdBlock;   //block number of post
    }
    
    function initialize(
        data storage self,
        address blogAddress,
        string memory posterName,
        string memory post
    )internal returns(
        data memory
    ){
        string HEX = msg.sender.hexadecimal();
        
        self = new data(
            blogAddress.hexadecimal().saltAndHash(
                HEX
            ),
            //keccak256(bytes(post.saltAndHash(HEX))),
            //msg.sender,
            posterName,
            post,
            //now,
            //block.number
        );
        
        //msg.sender.emitInialized(
            //post
        //);
    }
    function isAuthor(
        data storage self
        //address blogAddress
    )internal view returns(
        bool
    ){
        return self.authorHash.equal(
            blogAddress.hexadecimal().saltAndHash(
                msg.sender.hexadecimal()
            )
        );
    }
    function postAge(
        data storage self
    )internal view returns(
        uint
    ){
        return now.sub(
            self.createdTime
        );
    }
    function postBlockAge(
        data storage self
    )internal view returns(
        uint
    ){
        return block.number.sub(
            self.createdBlock
        );
    }
    //function postBlockAdjustedAge(
        //data storage self
    //)internal returns(
        //uint
    //){
        //return now;
            //block.number
        //);
    //}
}