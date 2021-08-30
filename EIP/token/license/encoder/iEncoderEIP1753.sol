// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/iEncoderTokenSupply.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/TokenIdentifier/iEncoderTokenIdentifier.sol";

///
/// @dev EIP1153 License Transaction Encoder Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
///
//Ethereum Improvments Proposal: Smart Contract Interface for Licences[sic]: https://eips.ethereum.org/EIPS/eip-1753
interface iEncoderEIP1753 is iEncoderTokenIdentifier
    //iEncoderTokenSupply
{
    //read-only interface
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
    )external pure returns(
        bytes memory
    );
    //amount of seconds from now client has until their license is expired
    //function durationRemaining(
        //address client
    //)external pure returns(
        //bytes memory
    //);
    
    /// does client have authority to issue/revoke licenses
    function hasAuthority(
        address client
    )external pure returns(
        bytes memory
    );
    ///
    ///mutable interface
    ///
    ///owner grants account elevated privellages (such as issuing and revoking licenses)
    ///issuing authorities can NOT themselves grant or revoke authority,
    ///that should be an owner/admin privellage ONLY
    function grantAuthority(
        address account
    )external pure returns(
        bytes memory
    );
	//revoke account's elevated privellages as an issuing authority
    function revokeAuthority(
        address account
    )external pure returns(
        bytes memory
    );
	///an issuing authority issues client a license which is valid between the timestamp from,
    ///until the timestamp to from can be retroactive (in the past) but to MUST always be in the future
	function issue(
        address client,
        uint from,
        uint to
    )external pure returns(
        bytes memory
    );
	///issuing authority revokes client's license
    ///reverts if client does not have a license or if caller is not an issuing authority
    function revoke(
        address client
    )external pure returns(
        bytes memory
    );
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
    );
    */
}