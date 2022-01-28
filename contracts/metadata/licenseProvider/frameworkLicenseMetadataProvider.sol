// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/contracts/licenseMetadataProvider/iMetadataLicenseProvider.sol";

import "https://github.com/vigilance91/solidarity/contracts/licenseMetadataProvider/iMetadataLicenseProvider.sol";

library frameworkMetadataLicenseProvider
{
    bytes4 internal constant _INTERFACE_ID = type(iMetadataLicenseProvider).interfaceId;
    
    bytes internal constant _TOKEN_URI_SINGATURE = abi.encodeWithSignature(
        'tokenURI()'
    );
    bytes internal constant _URI_HASH_SINGATURE = abi.encodeWithSignature(
        'uriHash()'
    );
    bytes internal constant _BRIEF_SINGATURE = abi.encodeWithSignature(
        'brief(string,string)'
    );
    //function _requireSupportsInterfaceMetadataLicenseProvider(
        //address target
    //){
        //require(
            //supportsInterface(_INTERFACE_ID),
            //'interface not supported: '.concatenate(_INTERFACE_ID)
        //);
    //}
    
    //function castMetadataLicenseProvider
        //address lmp
    //)internal pure returns(
        //iMetadataLicenseProvider
    //){
        //_requireSupportsInterfaceMetadataLicenseProvider(lmp);
        //
        //return iMetadataLicenseProvider(lmp);
    //}
    //function thisCastMetadataLicenseProvider(
    //)internal pure returns(
        //iMetadataLicenseProvider
    //){
        //return castMetadataLicenseProvider(
            //address(this)
        //);
    //}
    
    function tokenURI(
        address target
    )internal view returns(
        string memory
    ){
        //return castMetadataLicenseProvider(target).tokenURI();
        
        //_requireSupportsInterface(target);
        //(bool success, bytes result) = target.call(_TOKEN_URI_SINGATURE);
        //success.requireTrue('uri() failed');
        //(ret) = abi.decode((string));
        
    }
    function uriHash(
        address target
    )internal view returns(
        bytes32
    ){
        //return castMetadataLicenseProvider(target).uriHash();
    }
    function brief(
        address target,
        string memory date,
        string memory copyrightOwners
    )internal pure returns(
        bytes32,
        string memory
    ){
        return (0,"");  //castMetadataLicenseProvider(target).brief(date, copyrightOwners);
        
        //_requireSupportsInterface(target);
        
        //iMetadataLicenseProvider(target).uri();
        //(bool success, bytes result) = target.call(_BRIEF_SINGATURE);
        //success.requireTrue('brief() failed');
        //(ret) = abi.decode((string));
    }
}