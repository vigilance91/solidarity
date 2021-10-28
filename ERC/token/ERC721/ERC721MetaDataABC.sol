// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";

import "https://github.com/vigilance91/solidarity/contracts/token/TokenIdentifier/TokenIdentifierABC.sol";

//solidarity/libraies/.../toString.sol";

abstract contract ERC721MetaDataABC is TokenIdenifierABC
{
    // Base URI
    string private _baseURI;
    
    constructor(
        string memory collectionName,
        string memory collectionSymbol,
        string memory tokenURI
    )internal
        //Context()
        TokenIdenifierABC(
            collectionName,
            collectionSymbol
        )
    {
        //tokenURI.requireNotEmpty();
        
        _baseURI = tokenURI;
    }
    ///
    /// @return {string} base URI set via {_setBaseURI}
    ///
    /// NOTE:
    ///     This will be automatically added as a prefix in {tokenURI} to each token's URI,
    ///     or to the token ID if no specific URI is set for that token ID
    ///
    function baseURI(
    )public view returns(
        string memory
    ){
        return _baseURI;
    }
    ///
    /// @dev Internal function to set the base URI for all token IDs.
    /// It is automatically added as a prefix to the value returned in {tokenURI},
    /// or to the token ID if {tokenURI} is empty
    ///
    function _setBaseURI(
        string memory newBaseURI
    )internal virtual
    {
        //newBaseURI.requireNotEmpty();
        _baseURI = newBaseURI;
    }
}