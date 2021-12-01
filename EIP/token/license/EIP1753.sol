// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/.../Context.sol";

import "https://github.com/vigilance91/solidarity/contracts/accessControl/AccessControl.sol";

import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Logic.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/addressToString.sol";

import "./iEIP1753.sol";
import "./eventsEIP1753.sol";
//import "https://github.com/vigilance91/solidarity/EIP/token/license/iEIP1753.sol";
//import "https://github.com/vigilance91/solidarity/EIP/token/license/eventsEIP1753.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/StaticSupplyTokenABC.sol";

///
/// @title EIP-1753 License Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
/// @dev Ethereum Improvments Proposal: Smart Contract Interface for Licences[sic]: https://eips.ethereum.org/EIPS/eip-1753
/// 
library mixinEIP1753
{
    using LogicConstraints for bool;
    ////using nowMath for uint;
    ////using BlockTime for uint;
    
    using Bytes32Logic for bytes32;
    
    using AddressConstraints for address;
    using addressToString for address;
    
    using stringUtilities for string;
    
    //using bytes32Logic for bytes32;
    
    using eventsEIP1753 for address;
    
    using SafeMath for uint;
    
    //using BlockTimeConstraints for uint;
    
    //bytes32 private constant _HASH = keccak256(address(this).hexadecimal());
    
    struct LicenseStorage{
        address issuer; //address which issued the license
        //hash of the issuer's address and the licensee/license owner's address (for verification of ownership)
        bytes32 hash;
        //note similarity with EIP-801 Carnary Standard
        uint issuedBlock;
        uint terminationBlock;
        //
        uint issuedTime;
        uint terminationTime;
        //
        bool initalized;
    }
    function requireInitialized(
        LicenseStorage storage self
    )internal view
    {
        self.initalized.requireTrue(
            //'not initialized'
        );
    }
    function isValidIssuer(
        LicenseStorage storage self,
        address owner
    )internal view returns(
        bool
    ){
        self.issuer.requireNotEqualAndNotNull(owner);
        
        return self.issuer.hexadecimal().saltAndHash(
            owner.hexadecimal()
        ).equal(self.hash);
    }
    function isValidTime(
        LicenseStorage storage self,
        uint time
    )internal view returns(
        bool
    ){
        //if(time.greaterThan(self.issuedTime) &&
            //time.lessThan(self.terminationTime)
        //){
            //return true;
        //}
        return false;
    }
    function isValidBlock(
        LicenseStorage storage self,
        uint blockNumber
    )internal view returns(
        bool
    ){
        //if(blockNumber.greaterThan(self.issuedBlock) &&
            //blockNumber.lessThan(self.terminationBlock)
        //){
            //return true;
        //}
        return false;
    }
    function isValid(
        LicenseStorage storage self,
        address owner
    )internal returns(
        bool
    ){
        requireInitialized(self);
        
        if(isValidIssuer(self, owner) &&
            isValidTime(self, block.timestamp) &&
            isValidBlock(self, block.number)
        ){
            return true;
        }
        
        return false;
    }
    //function requireNotInitialized(
        //LicenseStorage storage self
    //)internal view
    //{
        //self.initalized.requireFalse('License already initialized');
    //}
    //function requireInitialized(
        //LicenseStorage storage self
    //)internal view
    //{
        //self.initalized.requireTrue('license is not initialized');
    //}
    //initialize License starting NOW for some duration into the future
    function initialize(
        LicenseStorage storage self,
        address sender,
        address licensee,
        uint startTime,
        uint expireTime
    )internal //returns(
        //LicenseStorage storage
    //)
    {
        //requireNotInitialized(self);
        //issuing authority can not issue licenses to themselves
        //sender.requireNotNullAndNotEqual(
            //licensee
        //);
        
        //startTime.requireGreaterThanZero();
        //expireTime.requireGreaterThan(startTime);
        
        self.issuer = sender;
        self.hash = sender.hexadecimal().saltAndHash(
            licensee.hexadecimal()
        );
        
        self.issuedTime = startTime;
        uint duration = expireTime.sub(startTime);
        //duration must be greater than the longest possible time to mine 1 block,
        //otherwise this license would expire effective immediately and be pointless
        //duration.requireGreaterThan(30);
        
        self.terminationTime = expireTime;
        //now must be less than the duration
        self.terminationTime.requireNowLessThan();
        
        self.issuedBlock = block.number;
        //self.terminationBlock = block.number.add(
            //estimateBlockNumber(
                //expireTime
                //15
            //)
        //);
        //
        //return self;
    }
    function initializeNow(
        LicenseStorage storage self,
        address sender,
        address licensee,
        uint duration
    )internal //returns(
        //LicenseStorage storage
    //)
    {
        //sender.requireNotNullAndNotEqual(
            //licensee
        //);
        
        //self.initalized.requireFalse();
        //msg.sender.requireNotEqualAndNotNull(licensee);
        ////duration must be greater than the longest possible time to mine 1 block,
        ////otherwise this license would expire effective immediately and be pointless
        //duration.requireGreaterThan(30);
        
        self.issuer = sender;
        self.hash = sender.hexadecimal().saltAndHash(
            licensee.hexadecimal()
        );
        
        self.issuedTime = block.timestamp;
        self.terminationTime = block.timestamp.add(duration);
        //now must be less than the duration
        self.terminationTime.requireNowLessThan();
        
        self.issuedBlock = block.number;
        //self.terminationBlock = block.number.add(
            //estimateBlockNumber(
                //now.add(duration)
                //15
            //)
        //);
        //
        //return self;
    }
    function age(
        LicenseStorage storage self
    )internal view returns(
        uint
    ){
        //requireInitalized(self);
        
        //if(!isValidTime(self, block.timestamp)){
            //return 0;
        //}
        
        //return block.timestamp.sub(self.issuedTime);
    }
    function durationRemaining(
        LicenseStorage storage self
    )internal view returns(
        uint
    ){
        //requireInitalized(self);
        //
        //if(!isValidTime(self, block.timestamp)){
            return 0;
        //}
        //return self.expireTime.sub(
            //block.timestamp
        //);
    }
    /// @return {uint} number of block mined/validated since the license was issued
    function blockAge(
        LicenseStorage storage self
    )internal view returns(
        uint
    ){
        //requireInitalized(self);
        //
        //if(!isValidBlock(self, block.number)){
            return 0;
        //}
        
        //return block.number.sub(self.issuedBlock);
    }
    /// @return {uint} number of blocks to mine/validate until this license is considered expired
    function blocksRemaining(
        LicenseStorage storage self
    )internal view returns(
        uint
    ){
        //requireInitalized(self);
        //
        //if(!isValidBlock(self, block.number)){
            return 0;
        //}
        
        //return self.terminationBlock.sub(block.number);
    }
    //
    // @return {uint} the current license's average age based on the current block timestamp and number, adjusted for block rate to offset malicious attempts to modify block timestamps
    //
    //function blockAdjustedAge(
        //uint
    //){
    //}
    //function blockAdjustedDurationRemaining(
        //uint
    //){
    //}
    
    // extend duration of current license (if still valid) to the new timestamp `newExpireTime`
    function renewTimestamp(
        LicenseStorage storage self,
        address sender,
        address licensee,
        uint newExpireTime
    )internal //returns(
        //LicenseStorage storage
    //)
    {
        //only allow renewals from previous issuer
        //self.issuer.requireEqual(sender);
        //licensor can not be the licensee
        //licensee.requireNotNullAndNotEqual(sender);
        
        //duration.requireGreaterThan(30);
        //isValid(self, licensee).requireTrue(
            //'license is no longer valid'
        //);
        //
        //newExpireTime.requireGreatThan(self.terminationTime);
        
        uint duration = newExpireTime.sub(self.startTime);
        //duration.requireGreaterThan(30);
        
        self.terminationTime = newExpireTime;
        self.terminationTime.requireNowLessThan();
        //self.terminationBlock = estimateBlockNumber(
            //newExpireTime
            //15
        //);
        //
        //return self;
    }
    //extend duration of current license (if still valid) by duration seconds beyond the previous termination
    function renewDuration(
        LicenseStorage storage self,
        address sender,
        address licensee,
        uint duration
    )internal //returns(
        //LicenseStorage storage
    //)
    {
        //only allow renewals from previous issuer
        //self.issuer.requireNotNullAndEqual(sender);
        //licensee.requireNotNullAndNotEqual(sender);
        
        //duration.requireGreaterThan(30);
        //isValid(self, licensee).requireTrue(
            //'license no longer valid'
        //);
        
        //self.lastRenewalTime = block.timestamp;
        //self.lastRenewalBlock = block.number;
        
        self.terminationTime = self.terminationTime.add(duration);
        self.terminationTime.requireNowLessThan();
        //self.terminationBlock = estimateBlockNumber(
            //self.terminationTime
            //15
        //);
        //
        //return self;
    }
}

//library licenseHolders
//{
    //mapping(address=>mixinEIP1753.LicenseStorage[]);
//}
//library secureLicenseHolders
//{
    //mapping(bytes32=>mixinEIP1753.LicenseStorage[]);
//}

/*
library mixinLicenseHolders
{
    //MAX_NAME_LENGTH =
    //MAX_TOTAL_SUPPLY = ;
    
    //struct LicenseHolderStorage{
        //mixinEIP1753.LicenseStorage[] activeLicenses;  ///licenses which a client has purchased and are currently valid
        //mixinEIP1753.LicenseStorage[] expiredLicenses; ///licenses which a client has purchased but are no longer valid
    //}
    
    struct DataStorage{
        //uint256 totalSupply;
        //string name;
        //string symbol;
        
        //uint256 issuedAmount;
        mapping(address=>LicenseHolderStorage) licenseHolders;
    }
    
    bytes32 private constant STORAGE_SLOT = keccak256('EIP-1753.mixin.storage');
    
    function dataStore(
    )internal pure returns(
        DataStorage storage ret
    ){
        bytes32 position = STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
    function initialize(
        address client
    )internal
    {
        DataStorage storage ds = dataStore();
        
        //ds.licenseHolders[client] = new mixinEIP1753.LicenseHolderStorage();

        //ds.licenseHolders[client].activeLicenses = new mixinEIP1753.LicenseStorage[](0);
        //ds.licenseHolders[client].expiredLicenses = new mixinEIP1753.LicenseStorage[](0);
    }
}
*/
///
/// @dev EIP1753 shares similarities with both ERC-20 and EIP-801!
///
abstract contract EIP1753 is //iERC1753,
    AccessControl,
    StaticSupplyTokenABC
{
    //using mixinEIP1753 for mixinEIP1753.LicenseStorage;
    using eventsEIP1753 for address;
    using eventsEIP1753AccessControl for address;
    
    bytes32 public constant ROLE_ISSUING_AUTHORITY = keccak256('EIP-1753.ROLE_ISSUER');
    bytes32 public constant ROLE_REVOKER = keccak256('EIP-1753.ROLE_REVOKER');
    
    constructor(
        string memory name,
        string memory symbol,
        uint256 totalSupply
    )internal
        AccessControl()
        StaticSupplyTokenABC(name, symbol, totalSupply)
    {
        //address sender = _msgSender();
        //mixinEIP1753.initialize(
            //sender
        //);
        
        ////_assignRoleAdmin(ROLE_ISSUER, DEFAULT_ADMIN_ROLE);
        ////_assignRoleAdmin(ROLE_REVOKER, DEFAULT_ADMIN_ROLE);
        
        //_grantRole(ROLE_ISSUER, sender);
        //_grantRole(ROLE_REVOKER, sender);
        //
        ////_grantRole(ROLE_ISSUER, _this);
    }
    function _mutableLicenseStorage(
    )private returns(
        mixinEIP1753.LicenseStorage storage
    ){
        return mixinEIP1753.dataStore(
            //mixinEIP1753.STORAGE_SLOT
        );
    }
    function _readOnlyLicenseStorage(
    )private view returns(
        mixinEIP1753.LicenseStorage storage
    ){
        return mixinEIP1753.dataStore(
            //mixinEIP1753.STORAGE_SLOT
        );
    }
    //current circulating supply(licnese which have been issued)
    //function circulatingSupply(
    //)public view returns(
        //uint256
    //);
    //totalSupply - issued
    //function remainingSupply(
    //)public view returns(
        //uint256
    //){
    //}
    
    //does client currently hold a valid license
    function _hasValidLicense(
        address client
    )internal view returns(
        bool
    ){
        address sender = msg.sender;
        //clients may only query their own license status
        //issuing authorities may query whomever they wish
        if(sender.notEquals(client)){
            _requireLicensingAuthority(sender);
        }
        
        return _readOnlyLicenseStorage()[client].isValid();
    }
    //amount of seconds from now client has until their license is expired
    //function durationRemaining(
        //address client
    //)public view returns(
        //uint
    //){
        //return _readOnlyLicenseStorage()[client].durationRemaining();
    //}
    //does client have authority to issue/revoke licenses
    function _hasAuthority(
        address account
    )internal view returns(
        bool
    ){
        account.requireNotNull();
        
        return hasRole(ROLE_ISSUING_AUTHORITY, account);    //|| hasRole(DEFAULT_ADMIN_ROLE, account);
    }
    function _isRevoker(
        address account
    )internal view returns(
        bool
    ){
        account.requireNotNull();
        
        return hasRole(ROLE_REVOKER, account);    // || hasRole(DEFAULT_ADMIN_ROLE, account);
    }
    //function hasAuthority(
    //)external view returns(
        //bool
    //){
        //return hasAuthority(msg.sender);
    //}
    function _requireLicensingAuthority(
        address account
    )internal view
    {
        _hasAuthority(account).requireTrue(
            //''
        );
    }
    //modifier _hasAuthority(
        //address account
    //){
        //_requireLicensingAuthority(account);
        //_;
    //}
    ///
    ///mutable interface
    ///
    //owner grants account elevated privellages (such as issuing and revoking licenses)
    //issuing authorities can NOT themselves grant or revoke authority, that should be an owner/admin privellage ONLY
    function _grantAuthority(
        address issuer,
        address account
    )internal
    {
        account.requireNotNull();
        
        issuer.requireNotNullAndNotEqual(account);
        
        _hasAuthority(issuer).requireTrue(
            //'invalid issuer'
        );
        
        _hasAuthority(account).requireFalse(
            //'already has role'
        );
        
        grantRole(ROLE_ISSUING_AUTHORITY, account);
    }
	//revoke account's elevated privellages as an issuing authority
    function _revokeAuthority(
        address revoker,
        address account
    )internal
    {
        account.requireNotNull();
        
        //_isRevoker(revoker).requireTrue(
            //'invalid revoker'
        //);
        
        _hasAuthority(account).requireTrue(
            //'address is not a revoker'
        );
        
        revokeRole(ROLE_ISSUING_AUTHORITY, account);
    }
	//an issuing authority issues client a license which is valid between the timestamp from, until the timestamp to
    //from can be retroactive (in the past) but to MUST always be in the future
	function _issue(
	    //address sender,
        address client,
        uint from,
        uint to
    )internal
    {
        client.requireNotNull();
        
        address sender = msg.sender;
        
        client.requireNotEqual(sender);
        
        _requireLicensingAuthority(sender);
        
        _mutableLicenseStorage()[client].initialize(
            sender,
            client,
            from,
            to
        );
        
        //sender.emitLicenseIssued(client);
    }
	
    function _revoke(
        //address revoker,
        address client
    )internal
    {
        //can't revoke license from a null address
        client.requireNotNull();
        
        _requireLicensingAuthority(msg.sender);
        
        _mutableLicenseStorage()[client].revoke();
        
        //sender.emitLicenseRevoked(client);
    }
    ///
	///payable interface
    ///
    //issuer purchases license (after recieving fee from client) which will then be issued to client by a specific date
	function purchase(
        uint validFrom,
        uint validTo
    )public payable virtual
    {
        //msg.sender.emitLicensePurchased(
            //msg.sender
        //);
    }
    //issuer purchases license (after recieving fee from client) then immediately issues license to client
    function purchaseAndIssue(
        uint validFrom,
        uint validTo
    )public payable virtual
    {
    }
    
    function renewTime(
        address client,
        uint time
    )public payable virtual
    {
        //mixinEIP1753.()[client].renewTime(
        //);
    }
    
    function renewDuration(
        address client,
        uint duration
    )public payable virtual
    {
        //mixinEIP1753.()[client].renewDuration(
        //);
    }
}