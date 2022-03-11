// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/access/AccessControl.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/introspection/ERC165.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";
//import "https://github.com/vigilance91/solidarity/ERC165/frameworkERC165.sol";
import "https://github.com/vigilance91/solidarity/EIP/SingletonFactory/iEIP2047.sol";
//import "./eventsEIP2047.sol";
//Ethereum Improvments Proposal: Singleton Factory - https://eips.ethereum.org/EIPS/eip-2470

///
/// @title Singleton Factory (EIP-2470)
/// @notice Exposes CREATE2 (EIP-1014) to deploy bytecode on deterministic addresses based on initialization code and salt.
/// @author Tyler R. Drury
/// @notice based on EIP-2047 by Ricardo Guilherme Schmidt (Status Research & Development GmbH)
///
library frameworkEIP2470
{
    using frameworkERC165 for address;
    
    using logicConstraints for bool;
    //using addressConstraints for address;
    
    //bytes4 internal constant INTERFACE_ID = type(iEIP2470).interfaceId;
    string internal constant DEPLOY_STUB = 'deploy(bytes,bytes32)';
    bytes4 internal constant DEPLOYED_CONTRACTS_SIGNATURE = abi.encodeWithSignature('deployedContracts()');
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
            type(iEIP2470).interfaceId  //INTERFACE_ID
        );
    }
    function _requireSupportsInterface(
        address target
    )public
    {
        _supportsInterface(
            target
        ).requireTrue(
            "EIP2470 not supported"
        );
    }
    
    //function castEIP2470
        //address singleton
    //)internal pure returns(
        //iEIP2470
    //){
        //_requireSupportsInterfaceEIP2470(singleton);
        //
        //return iEIP2470(singleton);
    //}
    //function thisCastEIP2470(
    //)internal pure returns(
        //iEIP2470
    //){
        //return castEIP2470(
            //address(this)
        //);
    //}
    
    function deploy(
        bytes memory initCode,
        bytes32 salt
    )public returns(
        address payable ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.call(
            abi.encodeWithSignature(
                'deploy(bytes,bytes32)',
                initCode,
                salt
            )
        );
        success.requireTrue('call failed');
        
        (ret) = abi.decode(result, (address payable));
    }
    ///
    ///read-only interface
    //
    function deployedContracts(
        address target
    )public view returns(
        address payable[] memory ret
    ){
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                'deployedContracts()'
            )
        );
        success.requireTrue('call failed');
        
        (ret) = abi.decode(
            result,
            (address payable[])
        );
    }
}

library frameworkEIP2470View
{
    using frameworkERC165 for address;
    
    using logicConstraints for bool;
    //using addressConstraints for address;
    
    string internal constant _NAME = ' frameworkEIP2470View: ';
    //bytes4 internal constant IID_EIP2470_VIEW = type(iEIP2470View).interfaceId;
    
    bytes4 internal constant DEPLOYED_CONTRACTS_SIGNATURE = abi.encodeWithSignature('deployedContracts()');
    ///
    ///mutable interface
    ///
    function _supportsInterface(
        address target
    )internal view returns(
        bool
    ){
        //target.requireNotNull();
        
        return target.supportsInterface(
            type(iEIP2470).interfaceId  //INTERFACE_ID
        );
    }
    function _requireSupportsInterface(
        address target
    )internal
    {
        _supportsInterface(
            target
        ).requireTrue(
            "EIP2470 not supported"
        );
    }
    
    //function castEIP2470
        //address singleton
    //)internal pure returns(
        //iEIP2470
    //){
        //_requireSupportsInterfaceEIP2470(singleton);
        //
        //return iEIP2470(singleton);
    //}
    //function thisCastEIP2470(
    //)internal pure returns(
        //iEIP2470
    //){
        //return castEIP2470(
            //address(this)
        //);
    //}
    //
    function deployedContracts(
        address target
    )internal view returns(
        address payable[] memory ret
    ){
        //target.requireSupportsInterfaceEIP2470View();
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                'deployedContracts()'
            )
        );
        success.requireTrue('call failed');
        
        (ret) = abi.decode(
            result,
            (address payable[])
        );
    }
}

library frameworkEIP2470Mutable
{
    using frameworkERC165 for address;
    
    using logicConstraints for bool;
    //using addressConstraints for address;
    
    //bytes4 internal constant IID_EIP2470_MUTABLE = type(iEIP2470Mutable).interfaceId;
    string internal constant _NAME = ' frameworkEIP2470Mutable: ';
    string internal constant _ERR_STR_TARGET = ', target: ';
    
    string internal constant STUB_DEPLOY = 'deploy(bytes,bytes32)';
    
    string internal constant _CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            '.call failed',
            _ERR_STR_TARGET
        )
    );
    
    function deploy(
        address target,
        bytes memory initCode,
        bytes32 salt
    )internal returns(
        address payable ret
    ){
        //target.requireSupportsInterfaceEIP2470Mutable();
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.call(
            abi.encodeWithSignature(
                STUB_DEPLOY,
                initCode,
                salt
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _CALL_FAILED,
                    target
                )
            )
        );
        
        (ret) = abi.decode(result, (address payable));
    }
}

library frameworkEIP2470Delegate
{
    using frameworkERC2470InterfaceSupport for address;
    
    using logicConstraints for bool;
    
    //bytes4 internal constant IID_EIP2470_MUTABLE = type(iEIP2470Mutable).interfaceId;
    
    string internal constant _NAME = ' frameworkEIP2470Delegate: ';
    string internal constant _ERR_STR_DELEGATE = ', delegate: ';
    
    string internal constant _ERR_CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            '.delegatecall failed',
            _ERR_STR_DELEGATE
        )
    );
    
    function deploy(
        address target,
        bytes memory initCode,
        bytes32 salt
    )internal returns(
        address payable ret
    ){
        //target.requireSupportsInterfaceEIP2470Mutable();
        _requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.delegatecall(
            abi.encodeWithSignature(
                frameworkEIP2470Mutable.STUB_DEPLOY,
                initCode,
                salt
            )
        );
        success.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
        
        (ret) = abi.decode(result, (address payable));
    }
}