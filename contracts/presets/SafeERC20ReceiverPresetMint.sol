// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/presets/SafeERC20PresetMint.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/ERC20/ERC20ReceiverABC.sol";
///
/// @title Safe ERC20 Receiver Preset Mint
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 19/4/2021, All Rights Reserved
/// @dev In addition to functionality provided by SafeERC20PresetMint,
/// This Token Mint contract, by default, accepts ERC20 token transfers (of any kind) from other accounts
/// and provides methods for transfering those tokens to other users or to this contract's owner (if one exists),
/// transfering tokens from external token contracts (such as Tether, DAI or other approved affiliate contracts)
/// owned by this contract, callable only by the owner or as part of some internal logic by a derived contract
/// This behaviour may be overriden by returning false from {iERC20Receiver.can
///
contract SafeERC20ReceiverPresetMint is SafeERC20PresetMint,
    ERC20ReceiverABC
{
    constructor(
        string memory name,
        string memory symbol
    )public
        SafeERC20PresetMint(
            name,
            symbol
        )
        ERC20ReceiverABC()
    {
    }
}