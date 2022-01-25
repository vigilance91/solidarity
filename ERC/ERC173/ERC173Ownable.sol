// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
import "https://github.com/vigilance91/solidarity/ERC/ERC173/ERC173.sol";

import "https://github.com/vigilance91/solidarity/ERC/ERC173/iERC173Ownable.sol";
///
/// @title ERC-173 Compliant Ownable Contract, with default support for ERC-165
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev a contract which can be owned by another address
///
abstract contract ERC173Ownable is ERC165,
    ERC173,
    //iERC173
    iERC173Ownable
{
    bytes4 private constant _IID_ERC173 = type(iERC173).interfaceId;
    bytes4 private constant _IID_OWNABLE = type(iERC173Ownable).interfaceId;
    
    bytes32 private constant _STORAGE_SLOT = keccak256("ERC-173Ownable.STORAGE_SLOT");
    
    constructor(
    )internal
        ERC165()
        ERC173(_STORAGE_SLOT)
    {
        _registerInterface(_IID_ERC173);   //type(iERC173).interfaceId);
        _registerInterface(_IID_OWNABLE);
    }
}