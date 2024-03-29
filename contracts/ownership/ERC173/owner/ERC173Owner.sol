// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/ReentrancyGuard.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/safeERC173/frameworkSafeERC173.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/ERC173/owner/iERC173Owner.sol";
import "https://github.com/vigilance91/solidarity/contracts/ownership/ERC173/owner/ERC173OwnerABC.sol";

abstract contract ERC173Owner is //ReentrancyGuard,
    ERC173OwnerABC,
    // ERC165
    iERC173Owner
{
    using frameworkERC173 for address;
    
    constructor(
    )internal
        //ReentrancyGuard()
        ERC173OwnerABC()
    {
    }
    function externalOwner(
        address ownable
    )public view virtual override returns(       //virtual override
        address
    ){
        return iERC173(ownable).owner();
    }
    /// 
    /// @dev if this contract owns `ownable`, transfer ownership to `newOwner`
    ///
    /// Requirements:
    ///     * `ownable` cannot be null, this contract nor this contract's owner
    ///     * `newOwner` cannot be null and if a contract address
    ///     * `newOwner` cannot be this contract, prevent redundant transaction
    ///
    function externalTransferOwnership(
        address ownable,
        address newOwner
    )external virtual override //nonReentrant
    {
        _transferOwnership(ownable, newOwner);
    }
    /// 
    /// @dev this contract renounces ownership of `ownable`, only if this contract is `ownable`s owner,
    /// otherwise transaction will revert
    /// 
    function externalRenounceOwnership(
        address ownable
    )external virtual override //nonReentrant
    {
        _renounceOwnership(ownable);
    }
}