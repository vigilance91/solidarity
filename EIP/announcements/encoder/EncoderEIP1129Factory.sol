// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
//
import "https://github.com/vigilance91/solidarity/EIP/SingletonFactory/EIP2470SingletonFactory.sol";
//
import "https://github.com/vigilance91/solidarity/EIP/announcements/encoder/EncoderEIP1129Announcements.sol";
///
/// @title EIP-1129 Transaction Encoder Factory Singleton Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
/// @dev Singleton EIP-1129 ABI Encoder contract for deploying contracts which encode external transaction payloads for EIP-1129 derived contracts or proxies
/// gas cost to deploy: 2,592,805
/// encoder contract deployed at: 0x6E33881D8A9A269A69004B0AC0e86f026c79Fe57
///
contract EncoderEIP1129Factory is EIP2470SingletonFactory
{
    using addressLogic for address;
    
    bytes32 private constant _HASH = keccak256(bytes('solidarity.ENCODER_EIP1129_FACTORY'));
    
    bytes private constant _BYTE_CODE = type(EncoderEIP1129Announcements).creationCode;
    
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