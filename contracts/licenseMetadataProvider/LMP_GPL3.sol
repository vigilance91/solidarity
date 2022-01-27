// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/licenseMetadataprovider/iLicenseMetadataProvider.sol";

import "https://github.com/vigilance91/solidarity/contracts/licenseMetadataprovider/LicenseMetadataProviderABC.sol";
/// 
/// 
contract LMP_GLP3 is LicenseMetadataProviderABC,
    iLicenseMetadataProvider
{
    using stringUtilities for string;
    
    string private constant _URI = "https://www.gnu.org/licenses/gpl-3.0.en.html";
    //string private constant _LICENSE = "This program is free software: you can redistribute it and/or modify"
//"it under the terms of the GNU General Public License as published by"
//"the Free Software Foundation, either version 3 of the License, or"
//"(at your option) any later version."
//""
//"This program is distributed in the hope that it will be useful,"
//"but WITHOUT ANY WARRANTY; without even the implied warranty of"
//"MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the"
//"GNU General Public License for more details."
//""
//"You should have received a copy of the GNU General Public License"
//"along with this program.  If not, see <https://www.gnu.org/licenses/>.";
    
    constructor(
    )public
        LicenseMetadataProviderABC(_URI)
    {
    }
    
    function uriHash(
    )external view override returns(
        bytes32
    ){
        return _uriHash();
    }
    
    function uri(
    )external view override returns(
        string memory
    ){
        return _uri();
    }
    function brief(
        string memory date,
        string memory copyrightOwners,
        bool unixLineEnding
    )external view override returns(
        bytes32 hash,
        string memory license
    ){
        string memory ENDL = _endl(unixLineEnding);

        license = string(
            abi.encodePacked(
                _COPYRIGHT,
                date,
                _SPACE,
                copyrightOwners,
                string(
                    abi.encodePacked(
                        ". This program is free software: you can redistribute it and/or modify"
                        "it under the terms of the GNU General Public License as published by"
                        "the Free Software Foundation, either version 3 of the License, or"
                        "(at your option) any later version.",
                        ENDL,
                        "This program is distributed in the hope that it will be useful,"
                        "but WITHOUT ANY WARRANTY; without even the implied warranty of"
                        "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the"
                        "GNU General Public License for more details.",
                        ENDL,
                        "You should have received a copy of the GNU General Public License"
                        "along with this program.  If not, see <https://www.gnu.org/licenses/>."
                    )
                )
            )
        );
        
        hash = keccak256(
            //abi.encodePacked(
                //_TYPE_HASH,
                //_chainId(),
                //address(this),
                //_msgSender(),
                //_nonceAt(_msgSender()),
                bytes(license)
            //)
        );
    }
}