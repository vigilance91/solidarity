// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//todo change /StaticTokenSupply/ to /staticTokenSupply/
import "https://github.com/vigilance91/solidarity/contracts/token/TokenSupply/staticTokenSupply/iStaticTokenSupply.sol";
import "https://github.com/vigilance91/solidarity/contracts/token/TokenIdentifier/iTokenIdentifier.sol";

//Ethereum Improvments Proposal: Smart Contract Interface for Licences[sic]: https://eips.ethereum.org/EIPS/eip-1753
interface iEIP1753 is iTokenIdentifier,
    iStaticTokenSupply
{
    //read-only interface
    //name of this license (similar to ERC20 name)
    //function name(
    //)external view returns(
        //string memory
    //);
    ////total existing supply of licenses to be issued
    //function totalSupply(
    //)external view returns(
        //uint256
    //);
    //current circulating supply(licnese which have been issued)
    //function circulatingSupply(
    //)external view returns(
        //uint256
    //);
    //totalSupply - issued
    //function remainingSupply(
    //)external view returns(
        //uint256
    //);
    
    //does client currently hold a valid license
    function hasValidLicense(
        address client
    )external view returns(
        bool
    );
    //amount of seconds from now client has until their license is expired
    //function durationRemaining(
        //address client
    //)public view returns(
        //uint
    //);
    
    /// does client have authority to issue/revoke licenses
    function hasAuthority(
        address account
    )external view returns(
        bool
    );
    ///
    ///mutable interface
    ///
    ///owner grants account elevated privellages (such as issuing and revoking licenses)
    ///issuing authorities can NOT themselves grant or revoke authority,
    ///that should be an owner/admin privellage ONLY
    function grantAuthority(
        address account
    )external;
	//revoke account's elevated privellages as an issuing authority
    function revokeAuthority(
        address account
    )external;
	///an issuing authority issues client a license which is valid between the timestamp from,
    ///until the timestamp to from can be retroactive (in the past) but to MUST always be in the future
	function issue(
        address client,
        uint from,
        uint to
    )external;
	///issuing authority revokes client's license
    ///reverts if client does not have a license or if caller is not an issuing authority
    function revoke(
        address client
    )external;
    /**
	///notice interfaces can not have payable functions for some reason
    ///
    ///caller purchases a license, if one is available, otherwise reverts
	function purchase(
        uint validFrom,
        uint validTo
    )public payable;
    ///renew an active license, extending to timestamp time
    function renewTime(
        address client,
        uint time
    )public payable;
    ///renew an active license, extending by duration seconds
    function renewDuration(
        address client,
        uint duration
    )public payable;
    */
}