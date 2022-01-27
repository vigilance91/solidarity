// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC165/frameworkERC165.sol";
import "https://github.com/vigilance91/solidarity/EIP1753/frameworkEIP1753.sol";

///
library frameworkEIP1753
{
    using frameworkERC165 for address;
    
    using logicConstraints for bool;
    //bytes4 internal constant NAME_SIGNATURE = abi.encodeWithSignature(
        //'name()'
    //);
    //bytes4 internal constant TOTAL_SUPPLY_SIGNATURE = abi.encodeWithSignature(
        //'totalSupply()'
    //);
    function supportsInterface(
        address target
    )public view returns(
        bool ret
    ){
        //target.isContract().requireTrue(
            //"target address is not a contract
        //);
        return target.supportsInterface(type(iEIP1753).interfaceId);
    }
    function requireSupportsInterface(
        address target
    )public
    {
        supportsInterface(target).requireTrue(
            "EIP1753 not supported"
        );
    }
    //function castEIP1753
        //address license
    //)internal pure returns(
        //iEIP2470
    //){
        //_requireSupportsInterfaceEIP1753(license);
        //
        //return iEIP1753(license);
    //}
    //function thisCastEIP1753(
    //)internal pure returns(
        //iEIP1753
    //){
        //return castEIP1753(
            //address(this)
        //);
    //}
    ///
    ///read-only interface
    ///
    modifier _requireInterfaceSupport(
        address target
    ){
        requireSupportsInterface(target);
        _;
    }
    function name(
        address target
    )public view
        //_requireInterfaceSupport(target)
    returns(
        string memory ret
    ){
        requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                'name()'
            )
        );
        success.requireTrue('call failed');
        
        (ret) = abi.decode(
            result
            (string)
        );
    }
    function totalSupply(
        address target
    )public view
        //_requireInterfaceSupport(target)
    returns(
        uint256 ret
    ){
        requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                'totalSupply()'
            )
        );
        success.requireTrue('call failed');
        
        (ret) = abi.decode(
            result
            (uint256)
        );
    }
    function hasValidLicense(
        address target,
        address client
    )public view
        //_requireInterfaceSupport(target)
    returns(
        bool ret
    ){
        requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                'hasValidLicense(address)'
                client
            )
        );
        success.requireTrue('call failed');
        
        (ret) = abi.decode(
            result
            (bool)
        );
    }
    function hasAuthority(
        address target,
        address account
    )public view
        //_requireInterfaceSupport(target)
    returns(
        bool
    ){
        requireSupportsInterface(target);
        
        (bool success, bytes memory result) = target.staticcall(
            abi.encodeWithSignature(
                'hasAuthority(address)'
                account
            )
        );
        success.requireTrue('call failed');
        
        (ret) = abi.decode(
            result
            (bool)
        );
    }
    ///
    ///mutable-interface
    ///
    function grantAuthority(
        address target,
        address account
    )public //_requireInterfaceSupport(target)
    {
        requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                'grantAuthority(address)'
                account
            )
        );
        success.requireTrue('call failed');
    }
    function revokeAuthority(
        address target,
        address account
    )public //_requireInterfaceSupport(target)
    {
        requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                'revokeAuthority(address)'
                account
            )
        );
        success.requireTrue('call failed');
    }
    function issue(
        address target,
        address account,
        uint from,
        uint to
    )public //_requireInterfaceSupport(target)
    {
        requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                'issue(address,uint,uint)'
                account,
                from,
                to
            )
        );
        success.requireTrue('call failed');
    }
    function revoke(
        address target,
        address account
    )public //_requireInterfaceSupport(target)
    {
        requireSupportsInterface(target);
        
        (bool success, ) = target.call(
            abi.encodeWithSignature(
                'revoke(address)'
                account
            )
        );
        success.requireTrue('call failed');
    }
}