// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/iERC165.sol";
import "https://github.com/vigilance91/solidarity/ERC/ERC173/iERC173.sol";

interface iERC173Ownable is iERC165,
    iERC173
{
}