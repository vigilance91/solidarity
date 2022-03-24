// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/ReentrancyGuard.sol";

import "https://github.com/vigilance91/solidarity/ERC/ERC173/iERC173.sol";

import "https://github.com/vigilance91/solidarity/ERC/ERC173/ERC173MutableABC.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";
///
/// @title ERC-173 compliant Ownership Proxy contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/3/2021, All Rights Reserved
///
/// @title ERC173Proxy Implementation
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev uninitialized External ERC-173 Ownership Implementation, for use by a proxy contract with ERC-165 support,
///
contract ERC173ExternalImplementation is ERC165,
    ReentrancyGuard,
    ERC173MutableABC,
    iERC173Mutable
{
    constructor(
    )public
        //NonreentrantERC165Context()
        ERC165()
        ReentrancyGuard()
        ERC173MutableABC()
    {
        _registerInterface(type(iERC173Mutable).interfaceId);
    }
    ///
    /// @dev Leaves the contract without owner. It will not be possible to call
    /// `onlyOwner` functions anymore. Can only be called by the current owner.
    ///
    /// NOTE: Renouncing ownership will leave the contract without an owner,
    /// thereby removing any functionality that is only available to the owner.
    function renounceOwnership(
    )external virtual override onlyOwner nonReentrant
    {
        _renounceOwnership();
    }
    ///
    /// @dev Transfer ownership of this contract to a new address (`newOwner`),
    /// can only be called by the current owner
    /// NOTICE newOwner can be either a wallet address OR a contract
    /// if newOwner is a contract which does NOT support ERC173 and/or
    /// is NOT programmed to transfer ownership, ownership is lost forever!
    ///
    function transferOwnership(
        address newOwner
    )external virtual override onlyOwner nonReentrant
    {
        _transferOwnership(newOwner);
    }
}