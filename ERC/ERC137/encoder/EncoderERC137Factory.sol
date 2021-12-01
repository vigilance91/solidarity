// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
//
import "https://github.com/vigilance91/solidarity/EIP/SingletonFactory/EIP2470SingletonFactory.sol";
//
import "https://github.com/vigilance91/solidarity/ERC/ERC137/encoder/EncoderERC137ENS.sol";
///
/// @title ERC-137 Ethereum Domain Name Service Transaction Encoder Factory Singleton Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 30/11/2021, All Rights Reserved
/// @dev Singleton ERC-137 ABI Encoder contract for deploying contracts which encode external transaction payloads for ERC-137 ENS derived contracts or proxies
///
contract EncoderERC137Factory is EIP2470SingletonFactory
{
    using AddressLogic for address;
    
    bytes32 private constant _HASH = keccak256(bytes('solidarity.ENCODER_ERC137_FACTORY'));
    
    bytes private constant _BYTE_CODE = type(EncoderERC137ENS).creationCode;
    
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