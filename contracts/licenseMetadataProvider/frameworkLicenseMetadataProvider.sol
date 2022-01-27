// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/contracts/licenseMetadataProvider/iLicenseMetadataProvider.sol";

import "https://github.com/vigilance91/solidarity/contracts/licenseMetadataProvider/iLicenseMetadataProvider.sol";

library frameworkLicenseMetadataProvider
{
    bytes4 internal constant _INTERFACE_ID = type(iLicenseMetadataProvider).interfaceId;
    
    bytes internal constant _URI_SINGATURE = abi.encodeWithSignature(
        'uri()'
    );
    bytes internal constant _URI_HASH_SINGATURE = abi.encodeWithSignature(
        'uriHash()'
    );
    bytes internal constant _BRIEF_SINGATURE = abi.encodeWithSignature(
        'brief(string,string)'
    );
    //function _requireSupportsInterfaceLicenseMetadataProvider(
        //address target
    //){
        //require(
            //supportsInterface(_INTERFACE_ID),
            //'interface not supported: '.concatenate(_INTERFACE_ID)
        //);
    //}
    
    //function castLicenseMetadataProvider
        //address lmp
    //)internal pure returns(
        //iLicenseMetadataProvider
    //){
        //_requireSupportsInterfaceLicenseMetadataProvider(lmp);
        //
        //return iLicenseMetadataProvider(lmp);
    //}
    //function thisCastLicenseMetadataProvider(
    //)internal pure returns(
        //iLicenseMetadataProvider
    //){
        //return castLicenseMetadataProvider(
            //address(this)
        //);
    //}
    
    function uri(
        address target
    )internal view returns(
        string memory
    ){
        //return castLicenseMetadataProvider(target).uri();
        
        //_requireSupportsInterface(target);
        //(bool success, bytes result) = target.call(_URI_SINGATURE);
        //success.requireTrue('uri() failed');
        //(ret) = abi.decode((string));
        
    }
    function uriHash(
        address target
    )internal view returns(
        bytes32
    ){
        //return castLicenseMetadataProvider(target).uriHash();
    }
    function brief(
        address target,
        string memory date,
        string memory copyrightOwners
    )internal pure returns(
        bytes32,
        string memory
    ){
        return (0,"");  //castLicenseMetadataProvider(target).brief(date, copyrightOwners);
        
        //_requireSupportsInterface(target);
        
        //iLicenseMetadataProvider(target).uri();
        //(bool success, bytes result) = target.call(_BRIEF_SINGATURE);
        //success.requireTrue('brief() failed');
        //(ret) = abi.decode((string));
    }
}