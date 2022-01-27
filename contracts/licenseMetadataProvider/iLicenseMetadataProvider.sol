// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

interface iLicenseMetadataProvider
{
    function uri(
    )external view returns(
        string memory
    );
    
    function uriHash(
    )external view returns(
        bytes32
    );
    
    function brief(
        string memory date,
        string memory copyrightOwners,
        bool unixLineEnding
    )external view returns(
        bytes32,
        string memory   //license
    );
}