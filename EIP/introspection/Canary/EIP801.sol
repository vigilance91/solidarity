// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";

import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/iEIP801.sol";
import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/mixinEIP801.sol";
///
/// @title EIP-801 Canary Standard Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev ligi, "EIP-801: ERC-801 Canary Standard [DRAFT]," Ethereum Improvement Proposals, no. 801, December 2017. [Online serial].
/// Available: https://eips.ethereum.org/EIPS/eip-801
/// 
abstract contract EIP801 is iEIP801
{
    //using eventsEIP801 for address;
    
    using LogicConstraints for bool;
    using AddressConstraints for address;
    
    using SafeMath for uint;
    
    address internal _this;
    //address payable private _thisPayable;
    
    constructor(
    )internal
    {
        mixinEIP801.initialize(
        );
        _this = address(this);
    }
    
    //function _mutableCanaryStorage(
    //)private returns(
        //mixinEIP801.EIP801Storage storage
    //){
        //return mixinEIP801.canaryStorage();
    //}
    
    function _readOnlyCanaryStorage(
    )private pure returns(
        mixinEIP801.EIP801Storage storage
    ){
        return mixinEIP801.canaryStorage();
    }
    //
    //mutable storage access
    //
    /**
    ///modifier_ senderIsNotThis(){
        ///_this.requireNotEqual(msg.sender);
        ///_;
    ///}
    /// modifier _isNotThis(
        //address account
    //)internal
    //{
        // _requireNotNull(account);
        //_requireNotThis(account);
        // _;
    /// }
    modifier _isNotThisAndNotNull(
        address account
    ){
        _isNotThisAndNotNull(account);
        _;
    }
    */
    function _requireAlive(
    )internal view
    {
        _readOnlyCanaryStorage().alive.requireTrue(
            //'contract dead'
        );
    }
    function _requireDead(
    )internal view
    {
        _readOnlyCanaryStorage().alive.requireFalse(
            //'contract alive'
        );
    }
    function _die(
    )internal
    {
        //_mutableCanaryStorage().die();
        mixinEIP801.EIP801Storage storage ls = mixinEIP801.canaryStorage(); //_mutableCanaryStorage();
        
        if(ls.alive){
            ls.alive = false;
            //ls.deathTimestamp = block.timestamp;
            //ls.deathBlock = block.number;
        }
    }
    
    //function self(
    //)public view
    //function _this(
    //)internal view
        //returns(address)
    //{
        //_requireAlive();
        //return _address;
    //}
    //function _thisHexString(
    //)internal view
        //returns(string memory)
    //{
        //_requireAlive();
        //return _this.hexadecimal();
    //}
    //function _thisPayable(
    //) internal view
        //returns(address payable)
    //{
        //_requireAlive();
        //return _thisPayable;
    //}
    //function thisHash(
    //)public view
        //returns(bytes32)
    //{
        //return _address.hexadecimal().hash();
    //}
    
    //function addressEqualThis(address account)
    //{
        //return _this().equal(account);
    //}
    //function addressHashEqualsThis(address account)
    //{
        //return thisHash() ^ account.hexadecimal().hash() == 0;
    //}
    function _thisIsNotNull(
    )internal view
    {
        _this.requireNotNull();
    }
    function _requireAddressessNotThisAndNotNull(
        address lhs,
        address rhs
    )internal view
    {
        _this.requireAddressesNotThisAndNotNull(lhs,rhs);
    }
    function _requireIsNotThisAndNotNull(
        address account
    )internal view
    {
        _this.requireNotThisAndNotNull(account);
    }
    ///
    ///EIP801
    ///
    function isAlive(
    )public view override returns(
        bool
    ){
        return _readOnlyCanaryStorage().alive;
    }
    /// @return {uint} the timestamp at contract creation
    /// notice block.timestamp can be manipulated by miners and may NOT be relied on to be accurate
    function createdTimestamp(
    )public view override returns(
        uint
    ){
        return _readOnlyCanaryStorage().createdTimestamp;
    }
    /// @return {uint} the block number at contract creation
    function createdBlock(
    )public view override returns(
        uint
    ){
        return _readOnlyCanaryStorage().createdBlock;
    }
    /// @return {uint} total age (in seconds) since this contract was created
    function age(
    )public view override returns(
        uint
    ){
        //return _readOnlyCanaryStorage().age();
        
        //if(!store.alive){
            //return store.deathTimestamp.sub(store.createdTimestamp);
        //}
        return now.sub(
            _readOnlyCanaryStorage().createdTimestamp
        );
    }
    /// @return {uint} number of blocks mined since this contract was created
    function blockAge(
    )public view override returns(
        uint
    ){
        //return _readOnlyCanaryStorage().blockAge();
        
        //LogicConstraints.requireTrue(
            //block.number > createdBlock()
        //);
        
        return block.number.sub(
            _readOnlyCanaryStorage().createdBlock
        );
    }
    /**
    //average between block age and the approximate time taken to calculate the blocks
    //which have been processed since this contract's creation
    function blockAdjustedAge()public view
    {
        //return _readOnlyCanaryStorage().blockAdjustedAge(15);
        
        return age().add(
            store.createdTimestamp.add(
                blockAge().mul(blockDuration)
            )
        ) >> 1;
    }
    */
}