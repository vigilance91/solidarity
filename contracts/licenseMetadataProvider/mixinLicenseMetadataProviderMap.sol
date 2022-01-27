// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

//import "https://github.com/vigilance91/solidarity/contracts/licenseMetadataProvider/frameworkLicenseMetadataProvider.sol";
///
/// @title License Metadata Provider Mixin Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 27/1/2022, All Rights Reserved
/// @dev 
/// 
library mixinLicenseMetadataProviderMap
{
    using addressConstraints for address;
    
    //using frameworkLicenseMetadataProvider for address;
    
    //struct License{
        //uint timeIssued;
        //uint blockIssued;
        
        //address resolver;
        
        //string text;
    //}
    
    struct LicenseMetadataProviderMapStorage{
        //mapping of contract address to license metadata provider contract
        mapping(address=>address) map;
        //mapping(address=>License) map;
    }
    
    //string private _STRUCTURED_DATA = 'uint256,string,string,string,string';
    
    //bytes32 internal constant STORAGE_SLOT = keccak256("solidarity.network.mixin.LicenseMetadataProviderMap.STORAGE_SLOT");
    
    function _storageLicenseMetadataProviderMap(
        bytes32 slot
    )private pure returns(
        LicenseMetadataProviderMapStorage storage ret
    ){
        assembly {
            ret_slot := slot
        }
    }
    //
    //getters
    //
    /// 
    /// @returns {uint256} unique chain identifier for each network
    /// 
    function at(
        bytes32 slot,
        address account
    )internal view returns(
        address
    ){
        return _storageContractMap(slot).map[account];
    }
    function briefAt(
        bytes32 slot,
        address account
    )internal view returns(
        bytes32,
        string memory
    ){
        return (
            _storageContractMap(slot).map[account].hash,
            _storageContractMap(slot).map[account].brief
        );
    }
    
    //
    // 
    // @returns {bytes32} hash of the network's block explorer URL (for integrity verification)
    // 
    //function resolverHash(
        //mapping(address=>address) storage map,
        //address account
    //)internal view returns(
        //bytes32
    //){
        ////map[account].requireNotNull();
        
        //return map[account].hash();
    //}
    // 
    // @returns {bool} true if `explorer` matches the network's block explorer URL, otherwise false
    // 
    //function resolverHashEquals(
        //mapping(address=>address) storage map,
        //bytes32 rhs
    //)internal view returns(
        //bool
    //){
        //return addressHash(map).equals(
            //rhs
        //);
    //}
    
    //function hash(
        //uint256 resolver,
        //string memory text
    //)internal view returns(
        //bytes32
    //){
        //return keccak256(abi.encodePacked(
            //_STRUCTURED_DATA,
            //hash,
            //resolver,
            //text
        //));
    //}
    
    //function hash(
        //NetworkStorage storage NS
    //)internal view returns(
        //bytes32
    //){
        //return keccak256(abi.encodePacked(
            //_STRUCTURED_DATA,
            //NS.hash,
            //NS.resolver,
            //NS.text,
        //));
    //}
    
    ///
    ///setters
    ///
    function set(
        bytes32 slot,
        address account,
        address resolver
    )internal
    {
        account.requireIsContract();
        //resolver.requireLicenseMetadataProvider();
        
        mapping(address,address) storage s = _storageContractMap(slot).map;
        
        s[account].requireNotEqualAndNotNull(resolver);
        s[account].text.requireNotEmpty();
        //s[account].hash.requireNull();
        
        s[account] = resolver;
        
        (bytes32 hash, string memory breif) = resolver.brief(copyrightData, copyrightOwners);
        
        //s[account].brief = brief;
        //s[account].hash = hash;
    }
    /// @dev reset resolver after it has already been set
    function reset(
        bytes32 slot,
        address account,
        address resolver
        //string memory copyrightDate,
        //string memory copyrightOwners
    )internal //returns(mapping(address=>address) storage)
    {
        //account.requireIsContract();
        //resolver.requireSupportsInterfaceLicenseMetadataProvider();
        
        mapping(address=>address) storage S = _storageLicenseMetadataProviderMapStorage(slot).map;
        
        address oldResolver = S[account];
        
        //oldResolver.requireNotNull();
        oldResolver.requireNotEqual(resolver);
        
        //S[account].resolver = resolver;
        //S[account].text = resolver.brief(copyrightDate, copyrightOwners);
        
        //S.json = toJSON(
            //resolver,
            //S[account].text
        //);
        //S.jsonHash = keccak256(bytes(S.json));
        
        //return S;
    }
    
    function remove(
        bytes32 slot,
        address account
    )internal
    {
        mapping(address=>address) storage S = _storageLicenseMetadataProviderMapStorage(slot).map;
        
        address oldResolver = S[account];
        
        oldResolver.requireNotNull();
        //text.requireNotEmpty();
        //hash.requireNotNull();
        
        delete S[account];
        
        //return S;
    }
}