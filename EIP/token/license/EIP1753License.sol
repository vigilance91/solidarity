// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "./EIP801.sol";
import "https://github.com/vigilance91/solidarity/ERC/ERC173/ERC173Ownable.sol";

import "./iEIP1753.sol";
import "./EIP1753.sol";
/**
interface iEIP1753License is iERC173Ownable,
    iEIP1753
{
}
*/
///
/// @dev in addition to EIP1753, all license contracts additionally support:
/// introspection (ERC165) and are Ownable (ERC173)
///
contract EIP1753License is iEIP1753,
    ERC173Ownable,
    EIP1753
{
    //using eventsEIP1753 for address;
    //using addressConstraints for address;
    
    constructor(
        string memory name,
        string memory symbol,
        uint256 totalSupply
    )public
        ERC173Ownable()
        EIP1753(name, symbol, totalSupply)
    {
        _registerInterface(type(iEIP1753).interfaceId);
        //_registerInterface(type(iEIP1753License).interfaceId);
    }
    function hasValidLicense(
        address client
    )external view override returns(
        bool
    ){
        return _hasValidLicense(client);
    }
    function hasAuthority(
        address account
    )external view override returns(
        bool
    ){
        return _hasAuthority(account);
    }
    ///
    ///mutable interface
    ///
    //owner grants account elevated privellages (such as issuing and revoking licenses)
    //issuing authorities can NOT themselves grant or revoke authority, that should be an owner/admin privellage ONLY
    function grantAuthority(
        address account
    )external override
    {
        _grantAuthority(msg.sender, account);
    }
    function grantRoleRevoker(
        address account
    )external
    {
        _grantRoleRevoker(msg.sender, account);
    }
	//revoke account's elevated privellages as an issuing authority
    function revokeAuthority(
        address account
    )external override
    {
        _revokeAuthority(msg.sender, account);
    }
	//an issuing authority issues client a license which is valid between the timestamp from, until the timestamp to
    //from can be retroactive (in the past) but to MUST always be in the future
	function issue(
        address client,
        uint from,
        uint to
    )external virtual override
    {
        _issue(msg.sender, client, from, to);
    }
	
    function revoke(
        address client
    )external virtual override
    {
        _revoke(msg.sender, client);
    }
    ///
	///payable interface
    ///
    //issuer purchases license (after recieving fee from client) which will then be issued to client by a specific date
	function purchase(
        uint validFrom,
        uint validTo
    )external payable virtual
    {
        //msg.sender.emitLicensePurchased(
            //msg.sender
        //);
    }
    /*
    //issuer purchases license (after recieving fee from client) then immediately issues license to client
    function purchaseAndIssue(
        uint validFrom,
        uint validTo
    )external payable virtual
    {
    }
    
    function renewTime(
        address client,
        uint time
    )external payable virtual
    {
        //mixinEIP1753.()[client].renewTime(
        //);
    }
    
    function renewDuration(
        address client,
        uint duration
    )external payable virtual
    {
    }
    */
}