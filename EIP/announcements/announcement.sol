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
    
    using Bytes32Logic for bytes32;
    
    using addressToString for address;
    using addressToString for address payable;
    
    using stringUtilities for string;
    
    struct data{
        //announcer.Announcer poster;
        //bytes32 domainNameSeperator;
        bytes32 authorHash;   //unique hash, used to verify the author and/or platform
        bytes32 postHash;   //unique hash, used to verify the author and/or platform
        string author;
        
        string post;
        
        uint createdTime;    //timestamp of post
        uint createdBlock;   //block number of post
    }
    //string private constant _NAME = ' announcement: ';
    bytes32 private constant _TYPED_HASH = keccak256('solidarity.EIP.1129.announcement(uint256 chainId,bytes32 authorHash,bytes32 postHash,string author,string post,uint createdTime,uint createdBlock)');
    //bytes32 private constant _VERSION_FULL_TYPED_HASH = keccak256('solidarity.mixinVersion(uint256 chainId,uint256 major,uint256 minor,bytes32 hash,bytes versionBytes,string versionString)');
    bytes32 private constant _DOMAIN_NAME_SEPERATOR_HASH = keccak256('eip.1129.announcement.domainNameSeperator(address self,bytes32 slot,bytes32 hash)');
    
    function _chainId(
    )private pure returns(
        uint256 chainId
    ){
        assembly{
            chainId := chainid()
        }
    }
    function _encodeDomainNameSeperator(
        address self,
        bytes32 slot,
        bytes32 announcementHash
    )private pure returns(
        bytes memory
    ){
        return abi.encodePacked(
            _DOMAIN_NAME_SEPERATOR_HASH,
            self,
            slot,
            announcementHash
            //block.number
        );
    }
    //function _domainNameSeperator(
        //bytes32 slot,
        //bytes32 announcementHash
    //)private pure returns(
        //bytes32
    //){
        //return _domainNameSeperator(
            //address(this),
            //slot,
            //announcementHash
        //);
    //}
    function _domainNameSeperator(
        address self,
        bytes32 slot,
        bytes32 announcementHash
    )private pure returns(
        bytes32
    ){
        return keccak256(
            _encodeDomainNameSeperator(
                self,
                slot,
                announcementHash
            )
        );
    }
    function encodeAnnouncement(
        data storage s
    )internal pure returns(
        bytes memory
    ){
        return abi.encodePacked(
            _TYPED_HASH,
            _chainId(),
            a.authorHash,
            a.postHash,
            a.author,
            a.post,
            a.createdTime,
            a.createdBlock
        );
    }
    //function encodeAnnouncement(
        //bytes32 authorHash,   //unique hash, used to verify the author and/or platform
        //bytes32 postHash,   //unique hash, used to verify the author and/or platform
        //string memory author,
        ////
        //string memory post,
        ////
        //uint createdTime,
        //uint createdBlock
    //)internal pure returns(
        //bytes memory
    //){
        //return abi.encodePacked(
            //_TYPED_HASH,
            //_chainId(),
            //authorHash,
            //postHash,
            //author,
            //post,
            //createdTime,
            //createdBlock
        //);
    //}
    function decodeAnnouncement(
        bytes memory data
    )internal pure returns(
        data memory
    ){
        bytes32 typedHash;
        uint256 chainId;
        
        (
            typedHash,
            chainId,
            authorHash,
            postHash,
            author,
            post,
            createdTime,
            createdBlock
            minorVersion
        ) = abi.decode(
            data,
            (bytes32, uint256, bytes32, bytes32, string, string, uint, uint)
        );
        
        //cid.requireEqual(_chainId());
        typedHash.requireEqual(_TYPED_HASH);
    }
    
    //function decodeVersion(
        //bytes memory data,
        //data storage self
    //)internal pure returns(
        //data storage
    //){
        //bytes32 typedHash;
        //uint256 cid;
        //
        //(
            //typesHash,
            //cid,
            //self.authorHash,
            //self.postHash,
            //self.author,
            //self.post,
            //self.createdTime,
            //self.createdBlock
        //) = abi.decode(
            //data,
            //(bytes32, uint256, bytes32, bytes32, string, string, uint, uint)
        //);
        //
        //cid.requireEqual(_chainId());
        //typedHash.requireEqual(_TYPED_HASH);
        //
        //return self;
    //}
    function announcementHash(
        data storage self
    )internal pure returns(
        bytes32
    ){
        return keccak256(
            encodeVersion(
                //self.domainNameSeperator,
                self.authorHash,
                self.postHash,
                self.author,
                self.post,
                self.createdTime,
                self.createdBlock
            )
        );
    }
    /**
    function initialize(
        data storage self,
        address blogAddress,
        string memory posterName,
        string memory post
    )internal returns(
        data memory
    ){
        _requireNotInitiailzed(self);
        
        string memory HEX = msg.sender.hexadecimal();
        
        self = data(
            blogAddress.hexadecimal().saltAndHash(
                HEX
            ),
            HEX.saltAndHash(post),
            //msg.sender,
            posterName,
            post,
            block.timestamp,
            block.number
        );
        
        //msg.sender.emitInialized(
            //post
        //);
    }
    function reset(
        data storage self,
        address blogAddress,
        string memory posterName,
        string memory post
    )internal returns(
        data memory
    ){
        _requireInitiailzed(self);
        
        string memory HEX = msg.sender.hexadecimal();
        
        self = data(
            blogAddress.hexadecimal().saltAndHash(
                HEX
            ),
            HEX.saltAndHash(post),
            //msg.sender,
            posterName,
            post,
            block.timestamp,
            block.number
        );
        
        //msg.sender.emitResetAnnouncement(
            //post
        //);
    }
    function remove(
        data storage self
    )internal
    {
        _requireInitiailzed(self);
        
        //msg.sender.emitDeallocated(
            //self
        //);
        
        delete a.authorHash;
        delete a.postHash;
        delete a.author;
        delete a.post;
        delete a.createdTime;
        delete a.createdBlock;
    }
    */
    function isAuthor(
        data storage self,
        address blogAddress
    )internal view returns(
        bool
    ){
        //return self.authorHash.equal(
            //abi.encodePacked(
                //blogAddress.hexadecimal().saltAndHash(
                //msg.sender.hexadecimal()
            //)
        //);
        
        return self.authorHash.equal(
            blogAddress.hexadecimal().saltAndHash(
                msg.sender.hexadecimal()
            )
        );
    }
    //function postEquals(
        //data storage self,
        //address blogAddress,
        //string memory post
    //)internal returns(
        //bool
    //){
        //string memory HEX = msg.sender.hexadecimal();
        //return self.postHash ^ HEX.saltAndHash(self.post) == 0;
    //}
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