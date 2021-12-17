// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Address.sol";

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";

//import "https://github.com/vigilance91/solidarity/libraries/address/AddressLogic.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/addressToString.sol";
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