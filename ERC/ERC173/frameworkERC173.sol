// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Address.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";

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
    
    using LogicConstraints for bool;
    using Address for address;
    
    bytes4 internal constant INTERFACE_ID = type(iERC173).interfaceId;
    
    //string internal constant LIB_NAME = ' frameworkERC173: ';
    
    //functions with no arguments can have their functions signautre cached, for efficiency and speed
    bytes internal constant OWNER_SIGNATURE = abi.encodeWithSignature(
        'owner()'
    );
    bytes internal constant RENOUNCE_OWNERSHIP_SIGNATURE = abi.encodeWithSignature(
        'renounceOwnership()'
    );
    ///
    /// functions which take arguments can ONLY have their function indetifier stub cached, for slight efficiency and speed increase
    /// this stub must still be encoded before being used with .call, .staticcall or .delegatecall
    //string internal constant TRANSFER_OWNERSHIP_STUB = 'transferOwnership(address)';
    ///
    ///read-only interface
    ///
    function supportsInterface(
        address target
    )internal view returns(
        bool ret
    ){
        //target.isContract().requireTrue(
            //"target address is not a contract
        //);
        
        //return target.supportsInterface(INTERFACE_ID);
        
        //(bool result, bytes memory data) = self.staticcall(
            //abi.encodeWithSignature(
                //'supportsInterface(bytes4)',
                //INTERFACE_ID
            //)
        //);
        //result.requireTrue('call failed');
        //
        //(ret) = abi.decode(data, (bool));
    }
    function requireSupportsInterface(
        address target
    )internal
    {
        supportsInterface(target).requireTrue(
            "not supported"
        );
    }
    //function castERC173
        //address ownable
    //)internal pure returns(
        //iERC173
    //){
        //_requireSupportsInterface173(ownable);
        //
        //return iERC173(ownable);
    //}
    //function thisCastERC173(
    //)internal pure returns(
        //iERC173
    //){
        //return castERC173(
            //address(this)
        //);
    //}
    function owner(
        address target
    )internal view returns(
        address ret
    ){
        //requireSupportsInterface(target);
        
        (bool result, bytes memory data) = target.staticcall(
            OWNER_SIGNATURE     //abi.encodeWithSignature('owner()')
        );
        result.requireTrue(
            'call failed'
        );
        (ret) = abi.decode(data, (address));
    }
    /// note the contract which exectues this function MUST be the owner of the target contract,
    /// otherwise this function will revert
    function renounceOwnership(
        address target
    )internal
    {
        //requireSupportsInterface(target);
        
        (bool result, ) = target.call(
            RENOUNCE_OWNERSHIP_SIGNATURE    //abi.encodeWithSignature('renounceOwnership()')
        );
        result.requireTrue(
            'call failed'
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
                'transferOwnership(address)', //TRANSFER_OWNERSHIP_STUB
                newOwner
            )
        );
        result.requireTrue(
            'call failed'
        );
    }
}