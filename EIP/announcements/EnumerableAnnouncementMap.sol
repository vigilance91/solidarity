// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "./announcement.sol";
import "./eventsEIP1129.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256ToString.sol";
///
/// @dev Library for managing an enumerable mapping of Announcements
/// Maps have the following properties:
///
///  - Entries are added, removed, and checked for existence in constant time (O(1))
///  - Entries are enumerated in O(n)
///  - No guarantees are made on element ordering
/// 
library EnumerableAnnouncementMap
{
    using SafeMath for uint256;
    
    using uint256Logic for uint256;
    using uint256Constraints for uint256;
    
    using uint256ToString for uint256;
    
    using addressToString for address;
    using stringUtilities for string;
    
    using eventsEIP1129Announcements for bytes32;
    
    //uint256 private constant SENTINEL = 0;
    
    struct MapEntry {
        bytes32 _key;
        announcement.data _value;
        //bytes32 domainSeparator;
    }
    // Storage of map keys and values
    struct Map {
        MapEntry[] _entries;
        // Position of the entry defined by a key in the `entries` array, plus 1
        // because index 0 means a key is not in the map.
        mapping (bytes32=>uint256) _indexes;
    }
    
    function indexForKey(
        Map storage map,
        bytes32 key
    )internal view returns(
        uint256
    ){
        return map._indexes[key];
    }
    function keyForIndex(
        Map storage map,
        uint256 index
    )internal view returns(
        bytes32
    ){
        uint256 L = _length(map);
        
        L.requireGreaterThanZero();
        index.requireLessThan(L);
        
        return map._entries[index]._key;
    }
    ///
    /// @dev Adds a key-value pair to a map or,
    /// updates the value for an existing key, O(1)
    ///
    /// @return {bool} true if the key was added to the map,
    /// if it was not already present
    ///
    function initialize(
        Map storage map,
        //bytes32 key,
        //announcement.data memory value
        address author,
        string memory authorName,
        string memory message
    )public returns(
        bool
    ){
        //string authorName = VSN_METADATA_REGISTRY.getAuthorName(address);
        string memory HEX = author.hexadecimal();
        bytes32 msgHash = HEX.saltAndHash(message);
        bytes32 authorHash = HEX.saltAndHash(authorName);
        bytes32 key = keccak256(bytes(block.number.hexadecimal()));
        // We read and store the key's index to prevent multiple reads from the same storage slot
        uint256 keyIndex = map._indexes[key];
        
        // Equivalent to !contains(map, key)
        if(keyIndex.notEqual(0)){
            return false;
        }
        
        map._entries.push(MapEntry({
            _key: key,
            _value: announcement.data(
                authorHash,    //unique hash, used to verify the author and/or platform
                msgHash,       //unique hash, used to verify the message integrity
                authorName,
                message,
                now,
                block.number
            )
        }));
        // The entry is stored at length-1, but we add 1 to all indexes
        // and use 0 as a sentinel value
        map._indexes[key] = map._entries.length;
        
        key.emitNewAnnouncement(
            authorHash,
            msgHash,
            //authorName,
            message
        );
        return true;
    }
    ///reset a previously set post
    function edit(
        Map storage map,
        bytes32 key,
        //announcement.data memory value
        address author,
        string memory authorName,
        string memory message,
        string memory reason
    )public returns(
        bool
    ){
        uint256 keyIndex = map._indexes[key];
        
        // Equivalent to !contains(map, key)
        keyIndex.requireGreaterThanZero(
        );
        //string authorName = VSN_METADATA_REGISTRY.getAuthorName(address);
        string memory HEX = author.hexadecimal();
        bytes32 msgHash = HEX.saltAndHash(message);
        bytes32 authorHash = HEX.saltAndHash(authorName);
        // We read and store the key's index to prevent multiple reads from the same storage slot
        map._entries[keyIndex.sub(1)]._value = announcement.data(
            authorHash,    //unique hash, used to verify the author and/or platform
            msgHash,       //unique hash, used to verify the message integrity
            authorName,
            message,
            now,
            block.number
        );
        
        key.emitEditAnnouncement(
            authorHash,
            msgHash,
            message,
            reason
        );
        return true;
    }
    /**
    /// @return {announcement.data[]} an array containing a subset (slice) of the primary storage
    /// @dev calling this may become prohabitively expensive for large ranges,
    /// since loops in Ethereum consume large quantities of gas
    function slice(
        Map storage map,
        uint256 indexStart,
        uint256 indexStop
    )public returns(
        announcement.data[] memory ret
    ){
        uint256 L = _length(map);
        
        L.requireGreaterThanZero(
        );
        L.requireGreaterThanOrEqual(indexStop);
        
        for(uint256 i = indexStart; i < indexStop; i++){
            ret.push(at(map,i));
        }
    }
    */
    //function _swap(
        //uint256 firstIndex,
        //uint256 secondIndex
    //)private
    //{
        //uint256 toDeleteIndex = firstIndex - 1;
        //uint256 lastIndex = secondIndex - 1;

        //MapEntry storage lastEntry = map._entries[lastIndex];

        //// swap the last entry with the index where the entry to be deleted is
        //map._entries[toDeleteIndex] = lastEntry;
        //// Update the index for the moved entry
        //map._indexes[lastEntry._key] = toDeleteIndex + 1; // All indexes are 1-based
    //}
    ///
    /// @dev Removes a key-value pair from a map, O(1)
    /// @return {bool} true if key was removed from map, if it was present
    ///
    function remove(
        Map storage map,
        bytes32 key,
        bytes32 removerHash,
        string memory reason
    )public returns(
        bool
    ){
        // We read and store the key's index to prevent multiple reads from the same storage slot
        uint256 keyIndex = map._indexes[key];

        // Equivalent to contains(map, key)
        if(keyIndex.equal(0)){
            return false;
        }
        // To delete a key-value pair from the _entries array in O(1), we swap the entry to delete with the last one
        // in the array, and then remove the last entry (sometimes called as 'swap and pop').
        // This modifies the order of the array, as noted in {at}
        
        //_swap(
            //keyIndex,
            //map._entries.length.sub(1)
        //);
        
        uint256 toDeleteIndex = keyIndex.sub(1);
        uint256 lastIndex = map._entries.length.sub(1);
        
        // When the entry to delete is the last one, the swap operation is unnecessary.
        // However, since this occurs so rarely, perform the swap anyway to avoid the gas cost of adding an 'if' statement

        MapEntry storage lastEntry = map._entries[lastIndex];
        MapEntry storage toRemove = map._entries[toDeleteIndex];

        // swap the last entry with the index where the entry to be deleted is
        map._entries[toDeleteIndex] = lastEntry;
        // Update the index for the moved entry
        map._indexes[lastEntry._key] = toDeleteIndex.add(1); // All indexes are 1-based
        
        toRemove._key.emitRemovedAnnouncement(
            toRemove._value.authorHash,
            toRemove._value.postHash,
            //toRemove._value.post,
            reason,
            removerHash
        );
        
        // Delete the slot where the moved entry was stored
        map._entries.pop();
        delete map._indexes[key];
        
        return true;
    }
    /// @return {bool} true if the key is in the map, O(1)
    function contains(
        Map storage map,
        bytes32 key
    )public view returns(
        bool
    ){
        return map._indexes[key] != 0;
    }
    /// @return {uint256} number of key-value pairs in the map, time complexity O(1)
    function _length(
        Map storage map
    )internal view returns(
        uint256
    ){
        return map._entries.length;
    }
    ///
    /// @return {bytes32, bytes32} the key-value pair stored at position `index` in the map, O(1)
    ///
    /// Note that there are no guarantees on the ordering of entries inside the array,
    /// and it may change when more entries are added or removed
    ///
    /// Requirements:
    ///   - `index` must be strictly less than {length}
    ///
    function at(
        Map storage map,
        uint256 index
    )public view returns(
        bytes32,
        announcement.data memory
    ){
        map._entries.length.requireGreaterThan(
            index
            //"index out of bounds"
        );
        
        MapEntry storage entry = map._entries[index];
        
        return (entry._key, entry._value);
    }
    ///
    /// @return {bytes32} the value associated with `key`,  O(1)
    ///
    /// Requirements:
    ///      - `key` must be in the map
    ///
    function _get(
        Map storage map,
        bytes32 key
    )private view returns(
        announcement.data memory
    ){
        return _get(
            map,
            key,
            "EnumerableMap: nonexistent key"
        );
    }
    /// @dev Same as {_get}, with a custom error message when `key` is not in the map
    function _get(
        Map storage map,
        bytes32 key,
        string memory errorMessage
    )private view returns(
        announcement.data memory
    ){
        //map._entries.length.requireGreaterThan(0);
        
        uint256 keyIndex = map._indexes[key];
        // Equivalent to contains(map, key)
        keyIndex.requireNotEqual(
            0
            //errorMessage
        );
        
        map._entries.length.requireGreaterThan(
            keyIndex
            //"EnumerableMap: index out of bounds"
        );
        //note all indexes are 1-based
        return map._entries[keyIndex.sub(1)]._value;
    }
}