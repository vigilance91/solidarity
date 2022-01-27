// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

///
/// @dev ERC-165 Interface Support Transaction Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
///
library abiEncoderERC165
{
    //
    //getter stubs
    //
    string public constant STUB_SUPPORTS_INTERFACE = 'supportsInterface(bytes4)';
    
    function supportsInterface(
        bytes4 interfaceId
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_SUPPORTS_INTERFACE,
            interfaceId
        );
    }
}