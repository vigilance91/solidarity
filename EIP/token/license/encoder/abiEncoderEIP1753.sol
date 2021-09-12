// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

///
/// @dev EIP-1153 License Transaction Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
///
library abiEncoderEIP1753
{
    //
    //getter stubs
    //
    string public constant STUB_HAS_VALID_LICENSE = 'hasValidLicense(address)';
    string public constant STUB_HAS_AUTHORITY = 'hasAuthority(address)';
    //
    //mutable stubs
    //
    string public constant STUB_GRANT_AUTHORITY = 'grantAuthority(address)';
    string public constant STUB_REVOKE_AUTHORITY = 'revokeAuthority(address)';
    //
    string public constant STUB_ISSUE = 'issue(address,uint,uint)';
    string public constant STUB_REVOKE = 'revoke(address)';
    //
    // = 'purchase(uint,uint)';
    // = 'renewTime(address,uint)';
    // = 'renewDuration(address,uint)';
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
        address client
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_HAS_VALID_LICENSE,
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
        address client
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_HAS_AUTHORITY,
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
        address account
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_GRANT_AUTHORITY,
            account
        );
    }
	//revoke account's elevated privellages as an issuing authority
    function revokeAuthority(
        address account
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_REVOKE_AUTHORITY,
            account
        );
    }
	///an issuing authority issues client a license which is valid between the timestamp from,
    ///until the timestamp to from can be retroactive (in the past) but to MUST always be in the future
	function issue(
        address client,
        uint from,
        uint to
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_ISSUE,
            client,
            from,
            to
        );
    }
	///issuing authority revokes client's license
    ///reverts if client does not have a license or if caller is not an issuing authority
    function revoke(
        address client
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_REVOKE,
            client
        );
    }
    /**
	///notice interfaces can not have payable functions for some reason
    ///
    ///caller purchases a license, if one is available, otherwise reverts
	function purchase(
        uint validFrom,
        uint validTo
    )external pure returns(
        bytes memory
    );
    ///renew an active license, extending to timestamp time
    function renewTime(
        address client,
        uint time
    )external pure returns(
        bytes memory
    );
    ///renew an active license, extending by duration seconds
    function renewDuration(
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