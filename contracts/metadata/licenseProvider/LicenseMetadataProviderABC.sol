// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/string/stringConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/string/stringUtilities.sol";

import "https://github.com/vigilance91/solidarity/EIP/token/tokenMetadata/EIP1046.sol";

abstract contract MetadataLicenseProviderABC is EIP1046
{
    using stringConstraints for string;
    //using stringUtilities for string;
    
    //using mixinMetadataLicenseProvider for bytes32;
    
    string internal constant _COPYRIGHT = "Copyright © ";
    string internal constant _SPACE = " ";
    string internal constant _DOS_ENDL = "\r\n";
    string internal constant _UNIX_ENDL = "\n";
    
    //bytes32 internal constant _TYPE_HASH = keccak256(
        //"LicenseMetadata(uint256 chainId,address self,address sender,uint256 nonce,bytes32 hash,bytes data)"
    //);

    //function encode(
        //address sender
        //bytes memory license
    //){
        //return abi.encodePacked(
            //_TYPE_HASH,
            //_chainId(),
            //address(this),
            //sender,
            //_nonceAt(_msgSender()),
            //keccak256(license),
            //license
        //)
    //}

    //struct storageLMP{
        bytes32 private _hash;
        //string private _licenseURI;
    //}
    
    constructor(
        //bytes32 slot,
        string memory licenseURI
    )internal
        EIP1046(licenseURI)
    {
        licenseURI.requireNotEmpty();
        //licenseURI.requireURL();
        
        _hash = keccak256(bytes(licenseURI));
    }
    function _endl(
        bool unix
    )internal pure returns(
        string memory
    ){
        return unix ? _UNIX_ENDL : _DOS_ENDL;
    }
    
    function _uriHash(
    )internal view returns(
        bytes32
    ){
        return _hash;
    }
}