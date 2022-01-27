// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Address.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";
import "https://github.com/vigilance91/solidarity/ERC/ERC173/iERC173.sol";
///
/// @title Framework for ERC-173 Ownable Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 26/3/2021, All Rights Reserved
/// @dev verification of support for ERC-165 introspection is performed before each call
///
library frameworkERC173
{
    using frameworkERC165 for address;
    
    using logicConstraints for bool;
    using Address for address;
    
    bytes4 internal constant INTERFACE_ID = type(iERC173).interfaceId;
    
    string private constant _NAME = ' - frameworkERC173: ';
    string private constant _ERR_STR_TARGET = ', target: ';
    
    string private constant _ERR_CALL_FAILED = string(
        abi.encodePacked(
            _NAME,
            'external call failed',
            _ERR_STR_TARGET
        )
    );
    string private constant _ERR_ERC173_SUPPORTED = string(
        abi.encodePacked(
            _NAME,
            'interface supported: iERC173',
            _ERR_STR_TARGET
        )
    );
    string private constant _ERR_ERC173_NOT_SUPPORTED = string(
        abi.encodePacked(
            _NAME,
            'unsupported interface: iERC173',
            _ERR_STR_TARGET
        )
    );
    
    //functions with no arguments can have their functions signautre cached, for efficiency and speed
    bytes internal constant _SIG_OWNER = abi.encodeWithSignature(
        'owner()'
    );
    bytes internal constant _SIG_RENOUNCE_OWNERSHIP = abi.encodeWithSignature(
        'renounceOwnership()'
    );
    //
    // functions which take arguments can ONLY have their function indetifier stub cached, for slight efficiency and speed increase
    // this stub must still be encoded before being used with .call, .staticcall or .delegatecall
    string internal constant _STUB_TRANSFER_OWNERSHIP = 'transferOwnership(address)';
    //
    //read-only interface
    //
    function supportsInterface(
        address target
    )internal view returns(
        bool ret
    ){
        return target.supportsInterface(INTERFACE_ID);
    }
    
    function requireSupportsInterface(
        address target
    )internal view
    {
        supportsInterface(target).requireTrue(
            string(
                abi.encodePacked(
                    _ERR_ERC173_NOT_SUPPORTED,
                    target
                )
            )
        );
    }
    function requireNotSupportsInterface(
        address target
    )internal view
    {
        supportsInterface(target).requireFalse(
            string(
                abi.encodePacked(
                    _ERR_ERC173_SUPPORTED,
                    target
                )
            )
        );
    }
    //
    //casting
    //
    function castERC173Ownable(
        address ownable
    )internal view returns(
        iERC173
    ){
        requireSupportsInterface(ownable);
        
        return iERC173(ownable);
    }
    
    function thisCastERC173Ownable(
    )internal view returns(
        iERC173
    ){
        return castERC173Ownable(
            address(this)
        );
    }
    //
    function owner(
        address target
    )internal view returns(
        address ret
    ){
        //requireSupportsInterface(target);
        
        (bool result, bytes memory data) = target.staticcall(
            _SIG_OWNER
        );
        
        result.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
        
        (ret) = abi.decode(data, (address));
    }
    //
    //mutable interface
    //
    /// note the contract which exectues this function MUST be the owner of the target contract,
    /// otherwise this function will revert
    function renounceOwnership(
        address target
    )internal
    {
        //requireSupportsInterface(target);
        
        (bool result, ) = target.call(
            _SIG_RENOUNCE_OWNERSHIP
        );
        
        result.requireTrue(
            string(
                abi.encodePacked(
                    _ERR_CALL_FAILED,
                    target
                )
            )
        );
    }
    /// note the contract which exectues this function MUST be the owner of the target contract
    function transferOwnership(
        address target,
        address newOwner
    )internal
    {
        //requireSupportsInterface(target);
        
        (bool result, ) = target.call(
            abi.encodeWithSignature(
                _STUB_TRANSFER_OWNERSHIP,   //'transferOwnership(address)',
                newOwner
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
    }
}