// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/access/AccessControl.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/EIP/EIP2135/iEIP2135.sol";
///
/// @title Framework library for EIP-2135 Consumable Standard
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
///
library frameworkEIP2135
{
    using frameworkERC165 for address;
    
    using logicConstraints for bool;
    //using addressConstraints for address;
    
    //string internal constant _LIB_NAME = ' frameworkEIP2135: ';
    
    //bytes4 internal constant _INTERFACE_ID = type(iEIP2135).interfaceId;
    string internal constant _CONSUME_STUB = 'consume(uint256)';
    string internal constant _IS_CONSUMABLE_STUB = 'isConsumable(uint256)'
    ///
    ///mutable interface
    ///
    function _supportsInterface(
        address target
    )public view returns(
        bool
    ){
        //target.requireNotNull();
        
        return target.supportsInterface(
            type(iEIP2135).interfaceId  //_INTERFACE_ID
        );
    }
    function _requireSupportsInterface(
        address target
    )public
    {
        _supportsInterface(
            target
        ).requireTrue(
            "EIP2135 not supported"
        );
    }
    
    //function castEIP2135
        //address consumable
    //)internal pure returns(
        //iEIP2135
    //){
        //_requireSupportsInterfaceEIP2135(consumable);
        //
        //return iEIP2135(consumable);
    //}
    //function thisCastEIP2135(
    //)internal pure returns(
        //iEIP2135
    //){
        //return castEIP2135(
            //address(this)
        //);
    //}
    
    function consume(
        address target,
        uint256 assetId
    )public returns(
        bool ret
    ){
        
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.call(
            abi.encodeWithSignature(
                'consume(uint256)', //_CONSUME_STUB
                assetId
            )
        );
        success.requireTrue('call failed');
        
        (ret) = abi.decode(result, (bool));
    }
    ///
    ///read-only interface
    //
    function isConsumable(
        address target,
        uint256 assetId
    )public view returns(
        bool ret
    ){
    {
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                'isConsumable(uint256)',    //_IS_CONSUMABLE_STUB
                assetId
            )
        );
        success.requireTrue('call failed');
        
        (ret) = abi.decode(result, (bool));
    }
}