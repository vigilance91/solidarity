// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
//
import "https://github.com/vigilance91/solidarity/EIP/SingletonFactory/EIP2470SingletonFactory.sol";
//
//import "https://github.com/vigilance91/solidarity/EIP/token/license/encoder/EncoderEIP1753License.sol";
import "./EncoderEIP1753License.sol";
///
/// @title EIP-1753 Transaction Encoder Factory Singleton Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/8/2021, All Rights Reserved
/// @dev Singleton EIP-1753 ABI Encoder contract for deploying contracts which encode external transaction payloads for EIP-1753 derived contracts or proxies
/// deployment cost: 3,277,734
///
contract EncoderEIP1753Factory is EIP2470SingletonFactory
{
    using addressLogic for address;
    
    bytes32 private constant _HASH = keccak256(bytes('solidarity.ENCODER_EIP1753_FACTORY'));
    
    bytes private constant _BYTE_CODE = type(EncoderEIP1753License).creationCode;
    
    bytes32 public constant HASH_ENCODER_EIP1753 = keccak256(_BYTE_CODE);
    
    constructor(
    )public //nonReentrant
        EIP2470SingletonFactory()
    {
        address deployed = _deploy(
            _BYTE_CODE,
            _HASH
        );
        
        deployed.requireNotNull(
            //'failed to deploy contract'
        );
        
        _registerInterface(type(iEIP2470).interfaceId);
    }
}