// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControl.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";
//import "https://github.com/vigilance91/solidarity/libraries/eventsEIP1129.sol";
import "https://github.com/vigilance91/solidarity/EIP/announcements/iEIP1129.sol";
//import "./eventsEIP1129.sol";
import "https://github.com/vigilance91/solidarity/EIP/announcements/EnumerableAnnouncementMap.sol";
///
/// @title EIP1129 Announcements Mixin Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 8/4/2021, All Rights Reserved
/// @dev Based on:
///     Ethereum Improvments Proposal: Standard DAPP Announcements - https://eips.ethereum.org/EIPS/eip-1129
library mixinEIP1129
{
    using EnumerableAnnouncementMap for EnumerableAnnouncementMap.Map;
    //struct EIP1129Storage{
        //EnumerableAnnouncementMap announcements;
    //}
    
    bytes32 private constant STORAGE_SLOT = keccak256('EIP-1129.mixin.storage.slot');
    
    function dataStore(
    )internal pure returns(
        EnumerableAnnouncementMap.Map storage ret
    ){
        bytes32 position = STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
    function remove(
        bytes32 key,
        bytes32 removerHash,
        string memory reason
    )internal returns(
        bool
    ){
        return dataStore().remove(
            key,
            removerHash,
            reason
        );
    }
    /// @return {bool} true if the key is in the map, O(1)
    function contains(
        bytes32 key
    )internal view returns(
        bool
    ){
        return dataStore().contains(key);
    }
    function _length(
    )internal view returns(
        uint256
    ){
        return dataStore()._length();
    }
    function at(
        uint256 index
    )internal view returns(
        bytes32,
        announcement.data memory
    ){
        return dataStore().at(index);
    }
}
///
/// @title EIP1129 Announcements Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 8/4/2021, All Rights Reserved
/// @dev EIP1129 Standard Announcement contract children additionally support:
/// introspection (ERC165) and are Ownable (ERC173)
///
abstract contract EIP1129 is Context,
    AccessControl,
    //ContractSecrets,
    iEIP1129
{
    using SafeMath for uint256;
    
    using logicConstraints for bool;
    
    using addressToString for address;
    using addressToString for address payable;
    using stringUtilities for string;
    
    using EnumerableAnnouncementMap for EnumerableAnnouncementMap.Map;
    //Metadata registry framework
    //using frameworkEIP926 for address;
    
    //using eventsEIP1129Announcements for bytes32;
    //VSN_METADATA_REGISTRY is a Singleton,
    //deployed with the same address on every network
    //address public constant VSN_METADATA_REGISTRY = 0x;
    
    bytes32 public constant ROLE_POSTER = keccak256("EIP-1129.announcement.poster.role");
    bytes32 public constant ROLE_EDITOR = keccak256("EIP-1129.announcement.editor.role");
    
    constructor(
    )internal
        Context()
        AccessControl()
    {
        address sender = _msgSender();
        
        _setupRole(ROLE_POSTER, sender);
        _setupRole(ROLE_EDITOR, sender);
        //
        //this contract is authorized to post and edit posts autonomously
        //address _this = address(this);
        //_setupRole(ROLE_POSTER, _this);
        //_setupRole(ROLE_EDITOR, _this);
    }
    function _mutableAnnouncements(
    )internal pure returns(
        EnumerableAnnouncementMap.Map storage
    ){
        return mixinEIP1129.dataStore();
    }
    function _readOnlyAnnouncements(
    )internal pure returns(
        EnumerableAnnouncementMap.Map storage
    ){
        return mixinEIP1129.dataStore();
    }
    //function indices(
    //)public pure returns(
        //bytes32[] storage
    //){
        //return mixinEIP1129.indices();
    //}
    //function indices(
    //)public pure returns(
        //announcement.data[] storage
    //){
        //return mixinEIP1129.indices();
    //}
    //function announcements(
    //)public pure returns(
        //announcement.data[] storage
    //){
        //return mixinEIP1129.announcements();
    //}
    //function slice(
        //uint256 startIndex,
        //uint256 endIndex
    //)public pure returns(
        //mixinEIP1129.MapEntry[] memory
    //){
        //return mixinEIP1129.slice(startIndex, endIndex);
    //}
    ///
    ///Access Control
    ///
    function _hasPosterRole(
        address client
    )internal view returns(
        bool
    ){
        return hasRole(ROLE_POSTER, client);
    }
    function _hasEditorRole(
        address client
    )internal view returns(
        bool
    ){
        return hasRole(ROLE_EDITOR, client);
    }
    ///
    ///modifiers (note: use liberally) prefer require... style functions over explicit modifiers
    ///
    modifier onlyPoster(
        //address client
    ){
        _hasPosterRole(_msgSender()).requireTrue(
            "address not poster"
        );
        _;
    }
    modifier onlyEditor(
        //address client
    ){
        _hasEditorRole(_msgSender()).requireTrue(
            "address not editor"
        );
        _;
    }
    function indexForKey(
        bytes32 key
    )public view returns(
        uint256
    ){
        return _readOnlyAnnouncements().indexForKey(key);
    }
    function keyForIndex(
        uint256 index
    )public view returns(
        bytes32
    ){
        return _readOnlyAnnouncements().keyForIndex(index);
    }
    ///
    ///read-only interface
    ///
    ///total number of posts
    function numberOfPosts(
    )external view virtual override returns(
        uint256
    ){
        return _readOnlyAnnouncements()._length();
    }
    ///get the author hash, post hash and post content for the post with postNumber
    function readPost(
        uint256 postIndex
    )external view virtual override returns(
        //announcement.data memory
        bytes32 authorHash,
        bytes32 postHash,
        string memory post
    )
    {
        (, announcement.data memory data) = _readOnlyAnnouncements().at(postIndex);
        
        return (
            //data.author,
            data.authorHash,
            data.postHash,
            data.post
        );
    }
    ///
    ///mutable interface
    ///
    //DEPRECATED this same behaviour is achieved by AccessControl via, grantRole(ROLE_POSTER)
    //function givePostingPermission(
        //address _newAnnouncer,
        //bool _postingPrivileges,
        //string _posterName
    //)public onlyOwner returns(
        //bool success
    //);
    
    function postAnnouncement(
        string memory post
    )external virtual override onlyPoster
    {
        address sender = _msgSender();
        string memory name = 'tmp'; //VSN_METADATA_REGISTRY.name(sender);
        
        _mutableAnnouncements().initialize(
            //_thisSalt,
            sender,
            name,
            post
        );
    }
    
    function editAnnouncement(
        uint256 postIndex,
        string memory newMessage,
        string memory reason
    )external virtual override onlyEditor
    {
        address sender = _msgSender();
        string memory name = 'tmp'; //VSN_METADATA_REGISTRY.name(sender);
        
        _mutableAnnouncements().edit(
            keyForIndex(postIndex),
            sender,
            name,
            newMessage,
            reason
        );
    }
    
    function removeAnnouncement(
        uint256 postIndex,
        string memory reason
    )external virtual override onlyEditor
    {
        (bytes32 key, ) = _readOnlyAnnouncements().at(postIndex);
        
        _mutableAnnouncements().remove(
            key,
            address(this).hexadecimal().saltAndHash(
                _msgSender().hexadecimal()
            ),
            reason
        );
    }
    
    function postAge(
        uint256 postIndex
    )internal view returns(
        uint
    ){
        (, announcement.data memory post) = _readOnlyAnnouncements().at(postIndex);
        
        return now.sub(
            post.createdTime
        );
    }
    function postBlockAge(
        uint256 postIndex
    )internal view returns(
        uint
    ){
        (, announcement.data memory post) = _readOnlyAnnouncements().at(postIndex);
        
        return block.number.sub(
            post.createdBlock
        );
    }
    /**
    function hash(
        string memory message
    )external view onlyPoster returns(
        bytes32
    ){
        return _msgSender().hexadecimal().saltAndHash(
            message
        );
    }
    function authorHash(
    )public view onlyPoster returns(
        bytes32
    ){
        return _msgSender().hexadecimal().saltAndHash();
    }
    */
    /**
    //note failed to decode hash
    function test(
    )external pure returns(
        string memory ret
    ){
        ret = string(
            abi.encodePacked(
                keccak256(bytes('stuff to hash'))
            )
        );
    }
    */
}