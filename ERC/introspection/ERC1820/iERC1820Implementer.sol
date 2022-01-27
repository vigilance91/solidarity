// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @dev ERC1820 implementer interface as defined in:
///     https://eips.ethereum.org/EIPS/eip-1820#interface-implementation-erc1820implementerinterface[EIP]
///
/// Used by contracts that will be registered as implementers in the {iERC1820Registry}
///
interface iERC1820Implementer
{
    ///
    /// @return {bytes32} a special value (`ERC1820_ACCEPT_MAGIC`) if this contract implements `interfaceHash` for `account`
    /// See {iERC1820Registry.setInterfaceImplementer}
    ///
    function canImplementInterfaceForAddress(
        bytes32 interfaceHash,
        address account
    )external view returns(
        bytes32
    );
}