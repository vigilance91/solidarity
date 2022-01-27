// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Address.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/iERC165.sol";
///
/// @title Framework for ERC-165 Interface Support Introspection Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
///
library frameworkERC165
{
    using logicConstraints for bool;
    
    using addressConstraints for address;
    using Address for address;
    
    //using stringUtilities for string;
    
    string private constant _NAME = ' frameworkERC165: ';
    
    string internal constant SUPPORTS_INTERFACE_STUB = 'supportsInterface(bytes4)';
    //public constant SUPPORTS_INTERFACE_SIGNATURE = abi.encodeWithSignature(
        //SUPPORTS_INTERFACE_STUB,
        //_INTERFACE_ID
    //);
    
    string private constant _ERR_SUPPORTS_INTERFACE = string(
        abi.encodePacked(
            _NAME,
            "target supports interface: "
        )
    );
    string private constant _ERR_UNSUPPORTED_INTERFACE = string(
        abi.encodePacked(
            _NAME,
            "unsupported interface: "
        )
    );
    //error message for when a contract should not support ERC165 but does
    string private constant _ERR_ERC165_SUPPORTED = string(
        abi.encodePacked(
            _NAME,
            "interface supported: iERC165",
            _ERR_STR_TARGET
        )
    );
    //error message for when a contract should support ERC165 but does not
    string private constant _ERR_ERC165_NOT_SUPPORTED = string(
        abi.encodePacked(
            _NAME,
            "unsupported interface: iERC165",
            _ERR_STR_TARGET
        )
    );
    
    string private constant _ERR_CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            'external call failed',
            _ERR_STR_TARGET
        )
    );
    
    string private constant _ERR_STR_TARGET = ', target: ';
    
    bytes4 internal constant _INTERFACE_ID = type(iERC165).interfaceId;
    
    //uint256 private constant _MIN_GAS = 60000;
    //
    //read-only interface
    //
    /// @return ret {bool} returns true if address `target` is a contract which supports ERC165, otherwise false
    function supportsInterface(
        address target
    )internal view returns(
        bool ret
    ){
        //msg.gas.requireGreaterThan(60000);
        
        target.requireNotNull();
        target.isContract().requireTrue(
            //string(
                //abi.encodePacked(
                    //_ERR_NOT_CONTRACT,
                    //target
                //)
            //)
        );
        
        (bool result, bytes memory data) = target.staticcall{gas: 60000}(
            abi.encodeWithSignature(
                SUPPORTS_INTERFACE_STUB,
                _INTERFACE_ID
            )
        );
        result.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
        
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
        requireSupportsInterface(target);
        
        (bool result, bytes memory data) = target.staticcall{gas: 60000}(
            abi.encodeWithSignature(
                SUPPORTS_INTERFACE_STUB,
                interfaceId
            )
        );
        
        result.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
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
            string(
                abi.encodePacked(
                    _ERR_ERC165_NOT_SUPPORTED,
                    target
                )
            )
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
            string(
                abi.encodePacked(
                    _ERR_UNSUPPORTED_INTERFACE,
                    interfaceId,
                    _ERR_STR_TARGET,
                    target
                )
            )
        );
    }
    /// @dev require the calling contract context to support ERC-165
    function requireThisSupportsInterface(
        bytes4 interfaceId
    )internal view
    {
        requireSupportsInterface(
            address(this),
            interfaceId
        );
    }
    /// @dev require address `target` does NOT support ERC-165
    function requireNotSupportsInterface(
        address target
    )internal view
    {
        supportsInterface(target).requireFalse(
            string(
                abi.encodePacked(
                    _ERR_ERC165_SUPPORTED,
                    target
                )
            )
        );
    }
    //function requireThisNotSupportsInterfaceERC165(
    //)internal view
    //{
        //requireNotSupportsInterfaceERC165(address(this));
    //}
    
    /// @dev require address `target` does NOT support interface `interfaceId`
    function requireNotSupportsInterface(
        address target,
        bytes4 interfaceId
    )internal view
    {
        supportsInterface(
            target,
            interfaceId
        ).requireFalse(
            string(
                abi.encodePacked(
                    _ERR_SUPPORTS_INTERFACE,
                    interfaceId,
                    _ERR_STR_TARGET,
                    target
                )
            )
        );
    }
    /// @dev require the calling context contract does NOT support interface ERC-165
    function requireThisNotSupportsInterface(
        bytes4 interfaceId
    )internal view
    {
        requireNotSupportsInterface(
            address(this),
            interfaceId
        );
    }
    /// @return {iERC165} if address `target` supports ERC-165, cast to an iERC165 implementer
    function castERC165(
        address target
    )internal view returns(
        iERC165
    ){
        requireSupportsInterface(target);
        
        return iERC165(target);
    }
    /// @return {iERC165} if this address supports ERC-165, cast to an iERC165 implementer
    function thisCastERC165(
    )internal view returns(
        iERC165
    ){
        return castERC165(
            address(this)
        );
    }
}