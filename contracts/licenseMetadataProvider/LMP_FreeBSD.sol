// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/licenseMetadataprovider/iLicenseMetadataProvider.sol";

import "https://github.com/vigilance91/solidarity/contracts/licenseMetadataprovider/LicenseMetadataProviderABC.sol";

contract LMP_FreeBSD is LicenseMetadataProviderABC,
    iLicenseMetadataProvider
{
    using stringUtilities for string;
    
    string private constant _URI = "https://www.freebsd.org/copyright/freebsd-license/";
    //string private constant _LICENSE = "Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:"
//""
//"    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer."
//"    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution."
//""
//"THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS 'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
//""
//"The views and conclusions contained in the software and documentation are those of the authors and should not be interpreted as representing official policies, either expressed or implied, of the FreeBSD Project.";
    
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
                        ". Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:",
                        ENDL,
                        "    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer."
                        "    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.",
                        ENDL,
                        "THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS 'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.",
                        ENDL,
                        "The views and conclusions contained in the software and documentation are those of the authors and should not be interpreted as representing official policies, either expressed or implied, of the FreeBSD Project."
                    )
                )
            )
        );
   
        hash = keccak256(
            bytes(license)
        );
    }
}