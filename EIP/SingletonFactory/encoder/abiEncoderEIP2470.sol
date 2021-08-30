// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.7.0;
pragma experimental ABIEncoderV2;

//import "../TokenIdentifier/iTokenIdentifier.sol";
///
/// @dev EIP-2470 Transaction Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
///
library abiEncoderEIP2470
    ////iTokenIdentifier
{
    bytes public constant SIG_DEPLOYED_CONTRACTS = abi.encodeWithSignature('deployedContracts()');
    
    ///
    /// read-only interface
    ///
    function deploy(
        bytes memory byteCode,
        bytes32 salt
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_DEPLOY,
            byteCode,
            salt
        );
    }
    
    function deployPayable(
        bytes memory byteCode,
        bytes32 salt
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_DEPLOY_PAYABLE,
            byteCode,
            salt
        );
    }
}