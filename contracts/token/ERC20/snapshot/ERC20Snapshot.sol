// SPDX-License-Identifier: MIT

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Arrays.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Counters.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/SafeERC20Token.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressLogic.sol";
import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256Constraints.sol";
///
/// @title ERC20Snapshot
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev Inspired by Jordi Baylina's MiniMeToken to record historical balances:
///      https://github.com/Giveth/minimd/blob/ea04d950eea153a04c51fa510b068b9dded390cb/contracts/MiniMeToken.sol
///
///
/// extends ERC20 token functionality with a snapshot mechanism
/// 
/// When a snapshot is created, the balances and total supply at the time are recorded for later access
/// 
/// This safely allows for mechanisms based on token balances such as:
///  trustless dividends or weighted voting
/// 
/// In naive implementations it's possible to perform a "double spend" attack by reusing the same balance from different accounts
/// 
/// By using snapshots to calculate dividends or voting power,
/// those attacks no longer apply
/// 
///  This technique can also be used to create an efficient ERC20 forking mechanism
/// 
///  Snapshots are created by the internal {_snapshot} function,
///  which will emit the {Snapshot} event and return a snapshot id
/// 
/// To get the total supply at the time of a snapshot, call the function {totalSupplyAt} with the snapshot id
/// 
///  To get the balance of an account at the time of a snapshot, call the {balanceOfAt} function with the snapshot id and the account address
/// 
///  ==== Gas Costs
/// 
/// Snapshots are efficient, creation is _O(1)_
/// 
///  Retrieval of balances or total supply from a snapshot is _O(logn)_ in the number of snapshots created,
///  although _n_ for a specific account will generally be much smaller since identical balances in subsequent
///  snapshots are stored as a single entry
/// 
///  There is a constant overhead for normal ERC20 transfers due to the additional snapshot bookkeeping
/// 
///  This overhead is only significant for the first transfer that immediately follows a snapshot for a particular account
/// 
///  Subsequent transfers will have normal cost until the next snapshot, and so on
/// 
abstract contract ERC20Snapshot is SafeERC20Token
{
    // todo: snapshot mixin
    using addressLogic for address;
    using uint256Constraints for uint256;
    
    using SafeMath for uint256;
    using Arrays for uint256[];
    using Counters for Counters.Counter;

    uint8 private constant _HISTORY_DEPTH = 0xFF;
    // Snapshotted values have arrays of ids and the value corresponding to that id. These could be an array of a
    // Snapshot struct, but that would impede usage of functions that work on an array.
    struct Snapshots {
        //mapping(uint256=>uint256) map;
        uint256[] ids;  //bytes32[]
        uint256[] values;
    }
    
    bytes32 private constant _SNAPSHOT_TYPE_HASH = keccak256(
        bytes('Snapshots(bytes32 dataHash, uint256[] ids, uint256[] values))')
    );
    //struct AllownaceSnapshots {
        //uint256[] ids;
        //uint256[] values;
    //}
        
    //struct snapshotStorage{        
        //timestamp the last snapshot was taken
        //uint private _lastSnapshotTimestamp;
        //take a snapshot at least once ever 30 days
        //uint private _snapshotPeriod = 30 days;
        
        mapping(address=>Snapshots) private _accountBalanceSnapshots;
        //mapping(address=>mapping(address=>Snapshots)) private _allowanceSnapshots;
        
        Snapshots private _totalSupplySnapshots;
        //Snapshots private _supplyCapSnapshots;
        
        // Snapshot ids increase monotonically, with the first value being 1,
        // an id of 0 is invalid
        Counters.Counter private _currentSnapshotId;
        //enforce a minimum timestamp delta, to prevent snapshots being maliciously spammed
        //uint _lastSnapshotTimestamp;
        //uint _nextSnapshotTimestamp;
        //uint private constant _MIN_SNAPSHOT_DELTA = 1 days;
    //}
    /// @dev Emitted by {_snapshot} when a snapshot identified by `id` is created
    event Snapshot(
        uint256 snapshotTaken,
        uint256 nextId,
        uint time,
        uint blockNumber
    );
    
    constructor(
        string memory name,
        string memory symbol
        //uint256 majorVersion,
        //uint256 minorVersion,
    )internal
        SafeERC20Token(
            name,
            symbol
        )
        //VersionedDomain(name, majorVersion, minorVersion)
    {
        //_registerInterface(type(iERC20Snapshot).interfaceId);
        //_registerInterface(type(iERC20SnapShotToken).interfaceId);
        
        //_lastSnapshotTimestamp = block.timestamp;
    }
    /*
    function _encodeId(
        uint256 id
    )internal returns(
        bytes memory
    ){
        //cid = chainid();
        
        return abi.encode(
            keccak256(abi.encode(_ID_TYPE_HASH, id)),
            _ID_TYPE_HASH,
            //cid,
            id
        ));
    }
    function _decodeId(
        bytes memory data
    )internal returns(
        uint256
    ){
        (
            bytes32 dataHash,
            bytes32 typeHash,
            uint256 result
        ) = abi.decode(
            data,
            (bytes32, bytes32, uint256)
        );
        typeHash.requireEqual(_ID_TYPE_HASH);
        dataHash.requireEqual(
            keccak256(abi.encode(_ID_TYPE_HASH, id))
        )
        return result;
    }
    
    function _encodeSnapshots(
        Snapshots memory snapshot
    )internal returns(
        bytes memory
    ){
        //cid = chainid();
        
        return abi.encode(
            keccak256(abi.encodePacked(_SNAPSHOTS_TYPE_HASH, snapshot.ids, snapshot.values)),
            _SNAPSHOTS_TYPE_HASH,
            //cid,
            snapshots.ids,
            snapshot.value
        ));
    }
    function _decodeSnapshots(
        bytes memory data
    )internal returns(
        Snapshots memory ret
    ){
        (
            bytes32 dataHash,
            bytes32 typeHash,
            uint256[] ids,
            uint256[] values
        ) = abi.decode(
            data,
            (bytes32, bytes32, uint256[], uint256[])
        );
        
        typeHash.requireEqual(_SNAPSHOTS_TYPE_HASH);
        dataHash.requireEqual(
            keccak256(abi.encodePacked(
                _SNAPSHOTS_TYPE_HASH,
                ret.ids,
                ret.values
            ))
        );
        return result;
    }
    */
    ///
    /// @dev Create a new snapshot returning its id
    /// Emits a {Snapshot} event that contains the same id
    ///
    /// {_snapshot} is `internal` and you have to decide how to expose it externally
    /// 
    /// Implementations, for example, may choose to:
    ///     * restrict access to a set of accounts, for example using {AccessControl},
    ///     * make the mechanism open to the public
    ///     * after an arbitrary timestamp or a regular block height interval,
    ///         such as every 30 days or every 10,000 blocks mined
    ///     * after token burning or minting
    ///
    /// WARNING:
    ///     While this mechanism  is required for certain trust minimization mechanisms such as forking,
    ///     be aware that allowing open access of executing the {_snapshot} function,
    ///     can potentially be used by attackers in two ways:
    ///
    ///         * First, it can increase the cost of retrieval of values from snapshots,
    ///             although it will grow logarithmically thus, rendering this attack ineffective in the long term
    /// 
    ///         * Second, it can be used to target specific accounts and increase the cost of ERC20 transfers for them,
    ///             in the ways specified in the Gas Costs section above
    ///
    /// this hasn't been measured, if interested in reveiwing this please reach out to us
    ///
    /// It is thus recommended to use an internal, trustless, mechanism for snapshots,
    /// although developers can easily implement this mechanism however they desire
    ///
    function _snapshot(
    )internal virtual returns(
        uint256
    ){
        uint256 snapshotId = _currentSnapshotId.current();

        _currentSnapshotId.increment();

        uint256 currentId = _currentSnapshotId.current();
        
        //bytes32 currentIdHash = keccak256(_encodeId(
            //currentId
        //));
        
        //_this.emitSnapshot(
            //currentId
        //);
        
        emit Snapshot(
            snapshotId,
            currentId,
            block.timestamp,
            block.number
        );
        return currentId;
    }
    function currentSnapshotId(
    )public view returns(
        uint256
    ){
        return _currentSnapshotId.current();
    }
    /// @return {uint256} balance of `account` at snapshot `snapshotId`
    function _balanceOfAt(
        address account,
        uint256 snapshotId
    )internal view returns(
        uint256
    ){
        (bool snapshotted, uint256 value) = _valueAt(
            snapshotId,
            _accountBalanceSnapshots[account]
        );

        return snapshotted ? value : _balanceOf(account);
    }
    /// @return {uint256} total supply at snapshot `snapshotId`
    function _totalSupplyAt(
        uint256 snapshotId
    )internal view returns(
        uint256
    ){
        (bool snapshotted, uint256 value) = _valueAt(
            snapshotId,
            _totalSupplySnapshots
        );

        return snapshotted ? value : totalSupply();
    }
    function _balanceOfAverageShort(
        address account,
        uint256 snapshotStart,
        uint256 snapshotEnd
    )internal view returns(
        uint256
    ){
        snapshotEnd.requireGreaterThan(snapshotStart);

        uint256 delta = snapshotEnd.sub(snapshotStart);

        delta.requireGreaterThanZero();

        return _balanceOfAt(account, snapshotStart).add(
            _balanceOfAt(account, snapshotEnd)
        ) >> 1;
    }

    function _balanceOfAverageLong(
        address account,
        uint256 snapshotStart,
        uint256 snapshotEnd
    )internal view returns(
        uint256 result
    ){
        snapshotEnd.requireGreaterThan(snapshotStart);

        uint256 delta = snapshotEnd.sub(snapshotStart);

        delta.requireGreaterThanZero();
        
        result = 0;

        for(uint i; i < delta; i++){
            result = result.add(
                _balanceOfAt(account, snapshotStart.add(i))
            );
        }
        result = result.div(delta);
    }
    function _totalSupplyAverageShort(
        uint256 snapshotStart,
        uint256 snapshotEnd
    )internal view returns(
        uint256
    ){
        snapshotEnd.requireGreaterThan(snapshotStart);

        uint256 delta = snapshotEnd.sub(snapshotStart);

        delta.requireGreaterThanZero();

        return _totalSupplyAt(snapshotStart).add(
            _totalSupplyAt(snapshotEnd)
        ) >> 1;
    }

    function _totalSupplyAverageLong(
        uint256 snapshotStart,
        uint256 snapshotEnd
    )internal view returns(
        uint256 result
    ){
        snapshotEnd.requireGreaterThan(snapshotStart);

        uint256 delta = snapshotEnd.sub(snapshotStart);

        delta.requireGreaterThanZero();
        
        result = 0;

        for(uint i; i < delta; i++){
            result = result.add(
                _totalSupplyAt(snapshotStart.add(i))
            );
        }
        result = result.div(delta);
    }
    
    //
    // external interface
    //
    function balanceOfAt(
        address account,
        uint256 snapshotId
    )external view returns(
        uint256
    ){
        return _balanceOfAt(account, snapshotId);
    }
    //function balanceOfCallerAt(
        //uint256 snapshotId
    //)external view returns(
        //uint256
    //){
        //return _balanceOfAt(_msgSender(), snapshotId);
    //}
    function totalSupplyAt(
        uint256 snapshotId
    )external view returns(
        uint256
    ){
        return _totalSupplyAt(snapshotId);
    }
    ///todo clearSnapshot, allow users to clear this snapshot history,
    ///to cut down on overhead and prevent potential snapshot overflow issues
    
    /// @return {uint256} get supply cap at snapshot `snapshotId`
    //function supplyCapAt(
        //uint256 snapshotId
    //)public view returns(
        //uint256
    //){
        //(bool snapshotted, uint256 value) = _valueAt(
            //snapshotId,
            //_supplyCapSnapshots
        //);
        //
        //return snapshotted ? value : totalSupply();
    //}
    /*
    function sliceBalanceOf(
        address account,
        //uint256 begin,
        uint256 previousId
    )external returns(
        uint256[] memory result
    ){
        uint256 currentId = _currentSnapshotId.current();
        //previousId.requireLessThan(
            //currentId,
            ////_ERR_INVALID_ID_RANGE
        //);
        uint256 delta = currentId.sub(previousId);

        //delta.requireInRange(1,255);

        result = new uint256[](delta);
        //push balances chronologically, so first element is
        //the most recent and last element is a least recent/oldest
        //for(uint256 i = currentId; i >= delta; i--){
            //result[] = _balanceOfAt(account, i);
        //}
    }
    function sliceTotalSupply(
        //uint256 begin,
        uint256 previousId
    )external returns(
        uint256[] memory result
    ){
        uint256 currentId = _currentSnapshotId.current();
        //previousId.requireLessThan(
            //currentId,
            ////_ERR_INVALID_ID_RANGE
        //);
        uint256 delta = currentId.sub(previousId);

        //delta.requireInRange(1,255);

        result = new uint256[](delta);
        //push balances chronologically, so first element is
        //the most recent and last element is a least recent/oldest
        //for(uint256 i = currentId; i >= delta; i--){
            //result[] = _totalSupplyAt(account, i);
        //}
    }
    */
    /// 
    /// @dev Update balance and/or total supply snapshots before the values are modified
    /// This is implemented in the _beforeTokenTransfer hook, which is executed for _mint, _burn, and _transfer operations
    ///
    /// NOTE:
    ///     derived contracts can override this hook and place logic here to trustlessly trigger snapshots
    ///     based on the number of token transfers, timestamp or block height interval, etc
    ///
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    )internal virtual override
    {
        super._beforeTokenTransfer(
            from,
            to,
            amount
        );

        if(from.isNull()){
            // mint
            //LogicConstraints.alwaysRevert("cannot mint");
            _updateAccountSnapshot(to);
            _updateTotalSupplySnapshot();
        }
        else if(to.isNull()){   //== address(0)){
            // burn
            _updateAccountSnapshot(from);
            _updateTotalSupplySnapshot();
        }
        else{
            // transfer
            _updateAccountSnapshot(from);
            _updateAccountSnapshot(to);
        }
        
        _snapshot();
    }
    //
    //private interface
    //
    function _valueAt(
        uint256 snapshotId,
        Snapshots storage snapshots
    )private view returns(
        bool,
        uint256
    ){
        //require(snapshotId > 0, "ERC20Snapshot: id is 0");
        // solhint-disable-next-line max-line-length
        //require(snapshotId <= _currentSnapshotId.current(), "ERC20Snapshot: nonexistent id");
        
        //snapshotId.requireGreaterThanZero(
            //"id is 0"
        //);
        // solhint-disable-next-line max-line-length
        snapshotId.requireLessThanOrEqual(
            _currentSnapshotId.current()
            //"invalid id"
        );
        
        // When a valid snapshot is queried, there are three possibilities:
        //  a) The queried value was not modified after the snapshot was taken.
        //      Therefore, a snapshot entry was never created for this id,
        //      and all stored snapshot ids are smaller than the requested one
        //      The value that corresponds to this id is the current one
        //  b) The queried value was modified after the snapshot was taken
        //      Therefore, there will be an entry with the requested id, and its value is the one to return
        //  c) More snapshots were created after the requested one, and the queried value was later modified
        //      There will be no entry for the requested id:
        //          the value that corresponds to it is that of the smallest snapshot id that is larger than the requested one
        //
        // In summary, we need to find an element in an array,
        // returning the index of the smallest value that is larger if it is not found,
        // unless said value doesn't exist (e.g. when all values are smaller)
        // Arrays.findUpperBound does exactly this
        uint256 index = snapshots.ids.findUpperBound(snapshotId);

        if(index == snapshots.ids.length){
            return (false, 0);
        }
        else{
            return (true, snapshots.values[index]);
        }
    }

    function _updateAccountSnapshot(
        address account
    )internal
    {
        _updateSnapshot(
            _accountBalanceSnapshots[account],
            _balanceOf(account)
        );
    }

    function _updateTotalSupplySnapshot(
    )internal
    {
        _updateSnapshot(
            _totalSupplySnapshots,
            totalSupply()
        );
    }
    //function _updateSupplyCapSnapshot(
    //)private
    //{
        //_updateSnapshot(
            //_supplyCapSnapshots,
            //cap()
        //);
    //}

    function _updateSnapshot(
        Snapshots storage snapshots,
        uint256 currentValue
    )private
    {
        //bytes32 shapshotIdHash = encodedCurrentSnapshotId();
        
        uint256 currentId = _currentSnapshotId.current();
        
        if(_lastSnapshotId(snapshots.ids) < currentId){
            snapshots.ids.push(currentId);
            snapshots.values.push(currentValue);
        }
    }

    function _lastSnapshotId(
        uint256[] storage ids
    )private view returns(
        uint256
    ){
        //note, most languages are optimized to evaluate and return the true condition
        //of if expression or conditionals faster since,
        //that branch should be the most often executed
        //return (ids.length != 0) ? ids[ids.length.sub(1)] : 0;
        
        if(ids.length == 0){
            return 0;
        }
        else{
            return ids[ids.length.sub(1)];
        }
    }
}