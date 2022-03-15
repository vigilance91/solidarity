// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/ERC165.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/ReentrancyGuard.sol";
///
/// @title ERC-165 compatible Reentrancy Guard Context Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 23/2/2022, All Rights Reserved
/// 
contract abstract ERC165ReentrancyGuardContextABC is ERC165,
    Context,
    ReentrancyGuard
{
    constructor(
    )internal
        ERC165()
        Context()
        ReentrancyGuard()
    {

    }
}