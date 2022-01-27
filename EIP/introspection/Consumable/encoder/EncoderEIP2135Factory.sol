// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
//
import "https://github.com/vigilance91/solidarity/EIP/SingletonFactory/EIP2470SingletonFactory.sol";
//
import "https://github.com/vigilance91/solidarity/EIP/introspection/Consumable/encoder/EncoderEIP2135Consumable.sol";
///
/// @title EIP-2135 Consumable Transaction Encoder Factory Singleton Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/9/2021, All Rights Reserved
/// @dev Singleton EIP-2135 ABI Encoder contract for deploying contracts which encode external transaction payloads for EIP-2135 derived contracts or proxies
/// gas cost to deploy: 2,416,630
/// encoder deployed to address: 0x6bCa8d2e347B38763F0Ee8e920A4C8f0216Adeb5
/// 
///
contract EncoderEIP2135Factory is EIP2470SingletonFactory
{
    using addressLogic for address;
    
    bytes32 private constant _HASH = keccak256(bytes('solidarity.ENCODER_EIP2135_CONSUMABLE_FACTORY'));
    
    bytes private constant _BYTE_CODE = type(EncoderEIP2135Consumable).creationCode;
    
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
        
        //_registerInterface(type(iEIP2470SingletonFactory).interfaceId);
    }
}