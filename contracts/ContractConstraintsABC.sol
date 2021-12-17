// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Address.sol";

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";

//import "https://github.com/vigilance91/solidarity/libraries/address/AddressLogic.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/addressToString.sol";

import "./ChainIdConstraintsABC.sol";
///
/// @title mixinContract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/9/2021, All Rights Reserved
/// @dev ChainID mixin implementation
///
library mixinContract
{
    using Bytes32Logic for bytes32;
    
    using AddressLogic for address;
    //using AddressConstraints for address;
    using addressToString for address;
    
    using StringLogic for string;
    using stringUtilities for string;
    
    //string private constant _NAME = ' mixinContract';

    struct ContractStorage{
        address _this;
        //address deployer;
        
        //bytes32 thisRawHash;
        bytes32 thisHash;
        
        //bytes32 domainNameSeperator;
        
        bytes bytesPacked;
        string thisHex;
    }
    ///
    ///getters
    ///
    function storageContract(
        bytes32 slot
    )internal pure returns(
        ContractStorage storage ret
    ){
        assembly {
            ret_slot := slot
        }
    }
    //libs are called using delegatecall,
    //so this is the context contract calling this library function
    //function _this(
    //)private view returns(
        //address
    //){
        //return this;
    //}
    //
    //function thisSlot(
        //uint256 creationBlock,
        //bytes32 salt
    //)internal view returns(
        //bytes32
    //){
        //return keccak256(
            //abi.encode(
                //chainId(),
                //address(this),
                //creationBlock,
                //salt
            //)
        //);
    //}
    function thisAddress(
        bytes32 slot
    )internal view returns(
        address
    ){
        return storageContract(slot)._this;
    }
    function thisHash(
        bytes32 slot
    )internal view returns(
        bytes32
    ){
        return storageContract(slot).thisHash;
    }
    //function thisHexHash(
        //bytes32 slot
    //)internal view returns(
        //bytes32
    //){
        //return storageContract(slot).thisHexHash;
    //}
    function thisHexString(
        bytes32 slot
    )internal view returns(
        string memory
    ){
        return storageContract(slot).thisHex;
    }
    ///
    ///logic
    ///
    function thisEqual(
        bytes32 slot,
        address account
    )internal view returns(
        bool
    ){
        return thisAddress(slot).equal(account);
    }
    //
    function thisHexEqual(
        bytes32 slot,
        string memory id
    )internal view returns(
        bool
    ){
        return thisHexString(slot).equal(id);
    }
    //
    function thisHashEqual(
        bytes32 slot,
        bytes32 hash
    )internal view returns(
        bool
    ){
        return thisHash(slot).equal(hash);
    }
    //function thisHexHashEqual(
        //bytes32 slot,
        //bytes32 hash
    //)internal view returns(
        //bool
    //){
        //return thisHexHash(slot).equal(hash);
    //}
    //function thisDomainSeparatorEqual(
        //bytes32 slot,
        //bytes32 domainSeparator
    //)internal view returns(
        //bool
    //){
        //return thisDomainSeparator(slot).equal(domainSeparator);
    //}
    //
    //function requireVerifyRawHash(
        ////bytes32 slot
    //)internal view
    //{
        //ContractStorage storage SC = storageContract(slot);
        //
        //SC.bytesPacked.requireNotEmpty();
        //
        //SC.rawHash.requireNotNull();
        //SC.rawHash.requireEqual(
            //keccak256(SC.bytesPacked)
        //);
    //}
    
    //function requireVerifyHexHash(
        ////bytes32 slot
        //string memory chainId
    //)internal view
    //{
        //ContractStorage storage SC = storageContract(slot);
        //
        //SC.hexString.requireNotEmpty();
        //
        //SC.hexHash.requireNotNull();
        //SC.hexHash.requireEqual(
            //chainId.saltAndHash(SC.thisHex);
        //);
    //}
    ///
    ///setters
    ///
    function set(
        bytes32 slot,
        address self,
        string memory chainId
    )internal
    {
        ContractStorage storage SCID = storageContract(slot);
        
        //SCID._this.requireNull();
        //SCID.thisHash.require...();
        //SCID.thisHex.requireEmpty();
        //SCID.domainNameSeperator.requireNull();
        
        SCID._this = self;
        
        //chainId.requireNotEmpty();
        
        SCID.thisHex = self.hexadecimal();
        //SCID.thisBytesPacked = abi.encodePacked(self);
        //SCID.thisRawHashPacked = keccak256(SCID.thisBytesPacked);
        //
        //SCID.thisHexHash = hexHash(chainId, self);
        SCID.thisHash = SCID.thisHex.saltAndHash(chainId);
        //SCID.domainNameSeperator = keccak256(
            //abi.encode(
                //keccak256('EIP712Domain(uint256 chainId,bytes32 slot,address deployer,address deployedContract,uint blockNumber)'),   //string name,string version
                //chainId,
                //slot,
                ////_msgSender(),
                //self,
                //block.number  //keccak256(abi.encode(block.number))
                ////keccak256(bytes(name)),
                ////keccak256(bytes(version)),
            //)
        //);
    }
    //function hexHash(
        //uint256 chainId,
        //bytes32 slot,
        //address account
    //)internal pure returns(
        //bytes32
    //){
        //return keccak256(abi.encodePacked(
            //chainId,
            //slot,
            //account
        //));
    //}
    //function hexHash(
        //string memory chainId,
        ////bytes32 slot,
        //address account
    //)internal pure returns(
        //bytes32
    //){
        //return chainId.saltAndHash(
            //account.hexadecimal()
        //);
    //}
    //function remove(
        //bytes32 slot,
        //address self
    //)internal
    //{
        //ContractStorage storage SCID = storageContract(slot);
        //
        ////SCID._this.requireNotNull();
        ////SCID.thisHash.require...();
        ////SCID.thisHex.requireNotEmpty();
        //
        //SCID._this = AddressLogic.NULL;
        //
        //chainId.requireNotEmpty();
        //
        //SCID.thisHex = stringLogic.empty;
        ////SCID.thisBytesPacked = abi.encodePacked(self);
        ////SCID.thisHashPacked = bytes32Logic.NULL;
        //SCID.thisHash = bytes32Logic.NULL;
        //
        //SCID.domainNameSeperator = bytes32Logic.NULL;
    //}
}

//import "https://github.com/vigilance91/solidarity/contracts/chainId/iChainId.sol";
//import "https://github.com/vigilance91/solidarity/contracts/chainId/mixinChainABC.sol";

//import "https://github.com/vigilance91/solidarity/contracts/.../mixinContract.sol";
//import "https://github.com/vigilance91/solidarity/contracts/.../iContract.sol";

//interface iContractConstraints is iChainIdConstraints
//{
    //function domainNameSeperator(
    //)external view returns(
        //bytes32
    //);
    //
    ////function isContract(
        ////address account
    ////)external pure returns(
        ////bool
    ////);
    //
    //address encoded and packed to 32 bytes, not recommended for commercial use
    //function thisRawPackedHash(
    //)external view returns(
        //bytes32
    //);
    //
    //function thisHash(
    //)external view returns(
        //bytes32
    //);
//}
///
/// @title Contract Constraints Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev provides support to constrain the state of the EVM based on contract addresses,
/// specifically this contract (or those which derive from it)
///
abstract contract ContractConstraintsABC is ChainIdConstraintsABC
{
    using Address for address;
    using AddressConstraints for address;
    
    using mixinContract for bytes32;
    
    ////string internal _domainNameSeperator;
    string private constant _NAME = ' ContractConstraintsABC: ';
    
    bytes32 private constant _CONTRACT_STORAGE_SLOT = keccak256(
        'solidarity.ContractConstraintsABC.CONTRACT_STORAGE_SLOT'
    );
    //bytes32 private constant _CHAIN_ID_STORAGE_SLOT = keccak256(
        //'solidarity.ChainIdConstraintsABC.STORAGE_SLOT'
    //);
    
    constructor(
    )internal
        ChainIdConstraintsABC()
    {
        //_chainIdStorageSlot = mixinContract.thisSlot(
            //block.number,
            //keccak256('solidarity.contractConstraintsABC.chainId.STORAGE_SLOT')
        //);
        //_contractStorageSlot = mixinContract.thisSlot(
            //block.number,
            //keccak256('solidarity.contractConstraintsABC.contract.STORAGE_SLOT')
        //);

        _CONTRACT_STORAGE_SLOT.set(
            //_msgSender(),
            address(this),
            _chainIdString()
        );
        
        ////_domainNameSeperator = _thisHexString().concatenate(chainIdString()).concatenate(_NAME);
        
        //_thisPayable = payable(_this);
    }
    //
    //Mixin Contract Storage
    //
    function _this(
    )internal view returns(
        address
    ){
        return _CONTRACT_STORAGE_SLOT.thisAddress();
    }
    //function thisRawHash(
    //)public view returns(
        //bytes32
    //){
        //return _CONTRACT_STORAGE_SLOT.thisRawHash();
    //}
    
    function thisHash(
    )public view returns(
        bytes32
    ){
        return _CONTRACT_STORAGE_SLOT.thisHash();
    }
    function _thisHexString(
    )internal view returns(
        string memory
    ){
        return _CONTRACT_STORAGE_SLOT.thisHexString();
    }
    
    function _isContract(
        address account
    )internal view returns(
        bool
    ){
        return account.isContract();
    }
    ///
    /// Contract base calls to Require statements in library
    ///
    function _requireNull(
        address account
    )internal pure
    {
        account.requireIsNull();
    }
    function _requireNotNull(
        address account
    )internal pure
    {
        account.requireNotNull();
    }
    function _requireIsNull(
        address[] memory accounts
    )internal pure
    {
        //accounts.requireIsNull();

        for(uint i; i < accounts.length; i++){
            accounts[i].requireIsNull(
                //""
            );
        }
    }
    function _requireNotNull(
        address[] memory accounts
    )internal pure
    {
        for(uint i; i < accounts.length; i++){
            accounts[i].requireNotNull(
                //""
            );
        }
    }
    //function _requireNull(
        //address account,
        //string memory message
    //)internal pure
    //{
        //account.requireIsNull(message);
    //}
    
    //function _requireNotNull(
        //address account,
        //string memory message
    //)internal pure
    //{
        //account.requireNotNull(message);
    //}
    
    function _requireIsContract(
        address account
    )internal view
    {
        account.requireContract(
            //'address is not a contract'
        );
    }
    
    function _requireAreContracts(
        address[] memory accounts
    )internal view
    {
        for(uint i; i < accounts.length; i++){
            _requireIsContract(
                accounts[i]
            );
        }
    }
    function _requireNotContract(
        address account
    )internal view
    {
        account.requireNotContract(
            //'address is not a contract'
        );
    }
    function _requireAreNotContracts(
        address[] memory accounts
    )internal view
    {
        for(uint i; i < accounts.length; i++){
            _requireNotContract(
                accounts[i]
            );
        }
    }
    function _requireEqualAndNotNull(
        address lhs,
        address rhs
    )internal pure
    {
        lhs.requireNotEqualAndNotNull(rhs);
    }
    function _requireNotEqualAndNotNull(
        address lhs,
        address rhs
    )internal pure
    {
        lhs.requireNotEqualAndNotNull(rhs);
    }

    //use to ensure both addresses are contracts and neither are the same or null
    function _requireContractsAndNotEqual(
        address lhs,
        address rhs
    )internal view
    {
        lhs.requireNotEqualAndNotNull(rhs);
        //
        _requireIsContract(lhs);
        _requireIsContract(rhs);
    }
    
    //use to ensure both addresses are wallets and neither are the same or null
    function _requireNotContractsAndNotEqual(
        address lhs,
        address rhs
    )internal view
    {
        lhs.requireNotEqualAndNotNull(rhs);
        //
        _requireNotContract(lhs);
        _requireNotContract(rhs);
    }
    //ensures lhs is an EOA (Externally owner account) and rhs is a smart contract
    //function _requireEOAToContract(
        //address lhs,
        //address rhs
    //)internal view
    //{
        //_requireNotNullAndNotEqual(lhs,rhs);
        ////
        //_requireIsNotContract(lhs);
        //_requireIsContract(rhs);
    //}
    //
    //ensures lhs is a smart contract and rhs an EOA (Externally owner account)
    //function _requireContractToEOA(
        //address lhs,
        //address rhs
    //)internal view
    //{
        //_requireNotNullAndNotEqual(lhs,rhs);
        //
        //_requireIsContract(lhs);
        //_requireIsNotContract(rhs);
    //}
    
    function _requireNotThis(
        address account
    )internal view
    {
        _this().requireNotEqual(account);
    }
    function _requireNotThisAndNotNull(
        address account
    )internal view
    {
        _this().requireNotEqualAndNotNull(account);
    }
    function _requireNotThisAndNotNull(
        address lhs,
        address rhs
    )internal view
    {
        _this().requireAddressesNotThisAndNotNull(lhs,rhs);
    }

    function _requireNotThisAndNotNull(
        address[] memory accounts
    )internal view
    {
        address T = _this();

        for(uint i; i < accounts.length; i++){
            T.requireNotEqualAndNotNull(accounts[i]);
        }
    }
}