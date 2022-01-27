// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/EIP/token/license/encoder/iEncoderEIP1753.sol";
///
/// @dev EIP-1753 License Transaction Encoder Framework Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
///
library frameworkEncoderEIP1753
{
    using logicConstraints for bool;
    using addressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    bytes4 private constant _INTERFACE_ID = type(iEncoderEIP1753).interfaceId;
    
    function _requireSupportsInterface(
        address encoder
    )private
    {
        encoder.requireNotNull();
        encoder.isContract().requireTrue(
            'address not a contract'
        );
        
        encoder.supportsInterface(_INTERFACE_ID).requireTrue(
            'contract does not implement iEncoderEIP1753'
        );
    }
    //
    //current circulating supply(licnese which have been issued)
    //function circulatingSupply(
    //)external pure returns(
        //bytes memory
    //);
    //totalSupply - issued
    //function remainingSupply(
    //)public view returns(
        //uint256
    //);
    
    //does client currently hold a valid license
    function hasValidLicense(
        address encoder,
        address client
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1753(encoder).hasValidLicense(
            client
        );
    }
    //amount of seconds from now client has until their license is expired
    //function durationRemaining(
        //address client
    //)internal pure returns(
        //bytes memory
    //){
        //return abi.encodeWithSignature(
            //STUB_DURATION_REMAINING,
            //client
        //);
    //}
    
    /// does client have authority to issue/revoke licenses
    function hasAuthority(
        address encoder,
        address client
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1753(encoder).hasAuthority(
            client
        );
    }
    ///
    ///mutable interface
    ///
    ///owner grants account elevated privellages (such as issuing and revoking licenses)
    ///issuing authorities can NOT themselves grant or revoke authority,
    ///that should be an owner/admin privellage ONLY
    function grantAuthority(
        address encoder,
        address account
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1753(encoder).grantAuthority(
            account
        );
    }
	//revoke account's elevated privellages as an issuing authority
    function revokeAuthority(
        address encoder,
        address account
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1753(encoder).revokeAuthority(
            account
        );
    }
	///an issuing authority issues client a license which is valid between the timestamp from,
    ///until the timestamp to from can be retroactive (in the past) but to MUST always be in the future
	function issue(
        address encoder,
        address client,
        uint from,
        uint to
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1753(encoder).issue(
            client,
            from,
            to
        );
    }
	///issuing authority revokes client's license
    ///reverts if client does not have a license or if caller is not an issuing authority
    function revoke(
        address encoder,
        address client
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEIP1753(encoder).revoke(
            client
        );
    }
    /**
	///notice interfaces can not have payable functions for some reason
    ///
    ///caller purchases a license, if one is available, otherwise reverts
	function purchase(
        address encoder,
        uint validFrom,
        uint validTo
    )external pure returns(
        bytes memory
    );
    ///renew an active license, extending to timestamp time
    function renewTime(
        address encoder,
        address client,
        uint time
    )external pure returns(
        bytes memory
    );
    ///renew an active license, extending by duration seconds
    function renewDuration(
        address encoder,
        address client,
        uint duration
    )external pure returns(
        bytes memory
    )
    {
        return abi.encodeWithSignature(
            STUB_REVOKE_ALLOWANCE,
            spender
        );
    }
    */
}