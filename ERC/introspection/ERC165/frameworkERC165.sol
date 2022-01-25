// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Address.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/iERC165.sol";
///
/// @title Framework for ERC-165 Interface Support Introspection Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
///
library frameworkERC165
{
    using LogicConstraints for bool;
    using AddressConstraints for address;
    using Address for address;
    
    //using stringUtilities for string;
    
    bytes4 internal constant _INTERFACE_ID = type(iERC165).interfaceId;
    //string internal constant _LIB_NAME = ' frameworkERC165: ';
    string public constant SUPPORTS_INTERFACE_STUB = 'supportsInterface(bytes4)';
    //public constant SUPPORTS_INTERFACE_SIGNATURE = abi.encodeWithSignature(
        //SUPPORTS_INTERFACE_STUB,
        //_INTERFACE_ID
    //);
    
    ///
    ///read-only interface
    ///
    ///does target support ERC165
    function supportsInterface(
        address target
    )internal view returns(
        bool ret
    ){
        //msg.gas.requireGreaterThan(60000);
        
        target.requireNotNull();
        target.isContract().requireTrue(
            //_LIB_NAME.concatenate("target not contract")
        );
        
        (bool result, bytes memory data) = target.staticcall{gas: 60000}(
            abi.encodeWithSignature(
                SUPPORTS_INTERFACE_STUB,
                _INTERFACE_ID
            )
        );
        result.requireTrue('call failed');
        
        (ret) = abi.decode(data, (bool));
    }
    ///does target support ERC165 AND the interface specified by interfaceId
    function supportsInterface(
        address target,
        bytes4 interfaceId
    )internal view returns(
        bool ret
    ){
        //two calls to supportsInterface, requires at least 60,000 * 2 gas
        //msg.gas.requireGreaterThan(120000);
        
        supportsInterface(target).requireTrue(
            //_LIB_NAME.concatenate("ERC-165 not supported by target")
        );
        
        (bool result, bytes memory data) = target.staticcall{gas: 60000}(
            abi.encodeWithSignature(
                SUPPORTS_INTERFACE_STUB,
                interfaceId
            )
        );
        result.requireTrue(
            'call failed'   //_LIB_NAME.concatenate('call failed')
        );
        
        (ret) = abi.decode(data, (bool));
    }
    //function thisSupportsInterfaceERC165(
    //)internal view returns(
        //bool
    //){
        //return supportsInterface(address(this));
    //}
    //function thisSupportsInterface(
        //bytes4 interfaceId
    //)internal view returns(
        //bool
    //){
        //return supportsInterface(address(this), interfaceId);
    //}
    function requireSupportsInterface(
        address target
    )internal view
    {
        supportsInterface(target).requireTrue(
            "not supported"  //_LIB_NAME.concatenate("not supported")
        );
    }
    //function requireThisSupportsInterfaceERC165(
    //)internal view
    //{
        //requireSupportsInterfaceERC165(address(this));
    //}
    function requireSupportsInterface(
        address target,
        bytes4 interfaceId
    )internal view
    {
        supportsInterface(
            target,
            interfaceId
        ).requireTrue(
            "interface not supported"   //_LIB_NAME.concatenate("interface not supported")
        );
    }
    //function requireThisSupportsInterface(
        //bytes4 interfaceId
    //)internal view
    //{
        //requireSupportsInterface(
            //address(this),
            //interfaceId
        //);
    //}
    function requireNotSupportsInterface(
        address target
    )internal view
    {
        supportsInterface(target).requireFalse(
            "ERC-165: target supports interface"
        );
    }
    //function requireThisNotSupportsInterfaceERC165(
    //)internal view
    //{
        //requireNotSupportsInterfaceERC165(address(this));
    //}
    function requireNotSupportsInterface(
        address target,
        bytes4 interfaceId
    )internal view
    {
        supportsInterface(
            target,
            interfaceId
        ).requireFalse(
            "target supports interface"
        );
    }
    //function requireThisNotSupportsInterface(
        //bytes4 interfaceId
    //)internal view
    //{
        //requireNotSupportsInterface(
            //address(this),
            //interfaceId
        //);
    //}
    
    //function castERC165
        //address token
    //)internal pure returns(
        //iERC165
    //){
        //_requireSupportsInterface165(token);
        //
        //return iERC165(token);
    //}
    //function thisCastERC165(
    //)internal pure returns(
        //iERC165
    //){
        //return castERC165(
            //address(this)
        //);
    //}
}