// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
/// 
/// @title Storage Slot Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/7/2021, All Rights Reserved
/// @dev trivial utilities for accessing arbitrary external storage slots which hold built-in data types
/// 
library storageSlot
{
    struct AddressSlot {
        address value;
    }

    struct BooleanSlot {
        bool value;
    }

    struct Bytes32Slot {
        bytes32 value;
    }

    struct Uint256Slot {
        uint256 value;
    }

    struct Int256Slot {
        int256 value;
    }
    
    struct StringSlot {
        string value;
    }
    
    struct BytesSlot {
        bytes value;
    }
    ///
    /// @return ret {BooleanSlot} storage located at `slot`
    ///
    function _slotBoolean(
        bytes32 slot
    )private pure returns(
        BooleanSlot storage ret
    ){
        assembly {
            ret_slot := slot
        }
    }
    ///
    /// @return ret {Bytes32Slot} storage located at `slot`
    ///
    function _slotBytes32(
        bytes32 slot
    )private pure returns(
        Bytes32Slot storage ret
    ){
        assembly {
            ret_slot := slot
        }
    }
    ///
    /// @return ret {Uint256Slot} storage located at `slot`
    ///
    function _slotUint256(
        bytes32 slot
    )private pure returns(
        Uint256Slot storage ret
    ){
        assembly {
            ret_slot := slot
        }
    }
    ///
    /// @return ret {Int256Slot} storage located at `slot`
    ///
    function _slotInt256(
        bytes32 slot
    )private pure returns(
        Int256Slot storage ret
    ){
        assembly {
            ret_slot := slot
        }
    }
    ///
    /// @return ret {AddressSlot} storage located at `slot`
    ///
    function _slotAddress(
        bytes32 slot
    )private pure returns(
        AddressSlot storage ret
    ){
        assembly {
            ret_slot := slot
        }
    }
    //
    // @return {StringSlot} located at storage slot position `slot`
    //
    function _slotString(
        bytes32 slot
    )private pure returns(
        StringSlot storage ret
    ){
        assembly {
            ret_slot := slot
        }
    }
    //
    // @return {BytesSlot} located at storage slot position `slot`
    //
    function _slotBytes(
        bytes32 slot
    )private pure returns(
        BytesSlot storage ret
    ){
        assembly {
            ret_slot := slot
        }
    }
    /// 
    /// @dev get value of `slot`
    ///
    function getBoolean(
        bytes32 slot
    )internal view returns(
        bool
    ){
        return _slotBoolean(slot).value;
    }
    ///
    /// @dev get value of `slot`
    ///
    function getBytes32(
        bytes32 slot
    )internal view returns(
        bytes32
    ){
        return _slotBytes32(slot).value;
    }
    ///
    /// @dev get value of `slot`
    ///
    function getAddress(
        bytes32 slot
    )internal view returns(
        address
    ){
        return _slotAddress(slot).value;
    }
    ///
    /// @ set `slot` {Uint256Slot}
    ///
    function getUint256(
        bytes32 slot
    )internal view returns(
        uint256
    ){
        return _slotUint256(slot).value;
    }
    ///
    /// @ set `slot` {Int256Slot}
    ///
    function getInt256(
        bytes32 slot
    )internal view returns(
        int256
    ){
        return _slotInt256(slot).value;
    }
    ///
    /// @dev set `slot` {StringSlot}
    ///
    function getString(
        bytes32 slot
    )internal view returns(
        string memory
    ){
        return _slotString(slot).value;
    }
    ///
    /// @dev set `slot` {Uint256Slot}
    ///
    function getBytes(
        bytes32 slot
    )internal view returns(
        bytes memory
    ){
        return _slotBytes(slot).value;
    }
    /// 
    /// @dev set `slot` {BooleanSlot}
    ///
    function setBoolean(
        bytes32 slot,
        bool value
    )internal //returns(
        //bool
    //)
    {
        _slotBoolean(slot).value = value;
    }
    ///
    /// @dev set `slot` {Bytes32Slot}
    ///
    function setBytes32(
        bytes32 slot,
        bytes32 value
    )internal //returns(
        //bytes32
    //)
    {
        _slotBytes32(slot).value = value;
    }
    ///
    /// @dev set `slot` {AddressSlot}
    ///
    function setAddress(
        bytes32 slot,
        address value
    )internal //returns(
        //address
    //)
    {
        _slotAddress(slot).value = value;
    }
    ///
    /// @dev set `slot` {Uint256Slot}
    ///
    function setUint256(
        bytes32 slot,
        uint256 value
    )internal //returns(
        //uint256
    //)
    {
        _slotUint256(slot).value = value;
    }

    ///
    /// @dev set `slot` {Int256Slot}
    ///
    function setInt256(
        bytes32 slot,
        int256 value
    )internal //returns(
        //uint256
    //)
    {
        _slotInt256(slot).value = value;
    }
    ///
    /// @dev set `slot` {StringSlot}
    ///
    function setString(
        bytes32 slot,
        string memory value
    )internal //returns(
        //string memory
    //)
    {
        _slotString(slot).value = value;
    }
    ///
    /// @dev set `slot` {Uint256Slot}
    ///
    function setBytes(
        bytes32 slot,
        bytes memory value
    )internal //returns(
        //uint256
    //)
    {
        _slotBytes(slot).value = value;
    }
}