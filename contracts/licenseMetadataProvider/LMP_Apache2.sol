// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/licenseMetadataprovider/iLicenseMetadataProvider.sol";

import "https://github.com/vigilance91/solidarity/contracts/licenseMetadataprovider/LicenseMetadataProviderABC.sol";

contract LMP_Apache2 is LicenseMetadataProviderABC,
    iLicenseMetadataProvider
{
    using stringUtilities for string;
    
    string private constant _URI = "https://www.apache.org/licenses/LICENSE-2.0.html";
    //string private constant _LICENSE = ", All Rights Reserved."
//""
//"Licensed under the Apache License, Version 2.0 (the 'License');"
//"you may not use this file except in compliance with the License."
//""
//"You may obtain a copy of the License at"
//""
//"    http://www.apache.org/licenses/LICENSE-2.0"
//""
//"Unless required by applicable law or agreed to in writing, software"
//"distributed under the License is distributed on an 'AS IS' BASIS,"
//"WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied."
//"See the License for the specific language governing permissions and"
//"limitations under the License.";

    constructor(
    )public
        LicenseMetadataProviderABC(_URI)
    {
    }
    
    function uri(
    )external view override returns(
        string memory
    ){
        return _uri();  //"https://www.apache.org/licenses/LICENSE-2.0.html";
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
        
        //return "Copyright © 1/5/2021, Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil), All Rights Reserved.
        
        license = string(
            abi.encodePacked(
                _COPYRIGHT,
                date,
                _SPACE,
                copyrightOwners,
                string(
                    abi.encodePacked(
                        ", All Rights Reserved.",
                        ENDL,
                        "Licensed under the Apache License, Version 2.0 (the 'License');"
                        "you may not use this file except in compliance with the License.",
                        ENDL,
                        "You may obtain a copy of the License at",
                        ENDL,
                        "    http://www.apache.org/licenses/LICENSE-2.0",
                        ENDL,
                        "Unless required by applicable law or agreed to in writing, software"
                        "distributed under the License is distributed on an 'AS IS' BASIS,",
                        ENDL,
                        "WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.",
                        ENDL,
                        "See the License for the specific language governing permissions and"
                        "limitations under the License."
                    )
                )
            )
        );

        hash = keccak256(
            bytes(license)
        );
    }
}