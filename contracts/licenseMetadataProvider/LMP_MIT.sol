// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/licenseMetadataprovider/iLicenseMetadataProvider.sol";

import "https://github.com/vigilance91/solidarity/contracts/licenseMetadataprovider/LicenseMetadataProviderABC.sol";

contract LMP_MIT is LicenseMetadataProviderABC,
    iLicenseMetadataProvider
{
    using stringUtilities for string;
    
    string private constant _URI = "https://mit-license.org/";
    //string private constant _LICENSE = "Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:"
//""
//"The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software."
//""
//"THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.";
    
    constructor(
    )public
        LicenseMetadataProviderABC(_URI)
    {
    }
    
    function uri(
    )external view override returns(
        string memory
    ){
        return _uri();
    }
    function uriHash(
    )external view override returns(
        bytes32
    ){
        return _uriHash();
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
                        ". Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:",
                        ENDL,
                        "The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.",
                        ENDL,
                        "THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
                    )
                )
            )
        );
        
        hash = keccak256(
            bytes(license)
        );
    }
}