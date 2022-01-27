// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/token/license/encoder/iEncoderEIP1753.sol";
import "https://github.com/vigilance91/solidarity/EIP/token/license/encoder/abiEncoderEIP1753.sol";

//import "https://github.com/vigilance91/solidarity/contract/token/TokenIdentifier/encoder/EncoderTokenIdentifierABC.sol";
//import "https://github.com/vigilance91/solidarity/contract/token/TokenSupply/encoder/EncoderTokenSupplyABC.sol";
///
/// @title EIP-1753 License Transaction Encoder Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 29/8/2021, All Rights Reserved
/// 
abstract contract EncoderEIP1753ABC is iEncoderEIP1753
    //EncoderTokenIdentifierABC
    //EncoderTokenSupplyABC
{
    using abiEncoderEIP1753 for address;
    
    constructor(
    )internal
        //EncoderTokenIdentifierABC()
        //EncoderTokenSupplyABC()
    {
    }
    ///
    /// @return {bytes}
    /// 
    function hasValidLicense(
        address client
    )public pure override returns(
        bytes memory
    ){
        return client.hasValidLicense();
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
    
    ///
    /// @return {bytes}
    /// 
    function hasAuthority(
        address client
    )public pure override returns(
        bytes memory
    ){
        return client.hasAuthority();
    }
    ///
    ///mutable interface
    ///
    /// @return {bytes}
    /// 
    function grantAuthority(
        address account
    )public pure override returns(
        bytes memory
    ){
        return account.grantAuthority();
    }
	///
    /// @return {bytes}
    /// 
    function revokeAuthority(
        address account
    )public pure override returns(
        bytes memory
    ){
        return account.revokeAuthority();
    }
	///
    /// @return {bytes}
    /// 
	function issue(
        address client,
        uint from,
        uint to
    )public pure override returns(
        bytes memory
    ){
        return client.issue(
            from,
            to
        );
    }
	///
    /// @return {bytes}
    /// 
    function revoke(
        address client
    )public pure override returns(
        bytes memory
    ){
        return client.revoke();
    }
    /**
	///notice interfaces can not have payable functions for some reason
    ///
    ///caller purchases a license, if one is available, otherwise reverts
	function purchase(
        uint validFrom,
        uint validTo
    )public pure override returns(
        bytes memory
    );
    ///renew an active license, extending to timestamp time
    function renewTime(
        address client,
        uint time
    )public pure override returns(
        bytes memory
    );
    ///renew an active license, extending by duration seconds
    function renewDuration(
        address client,
        uint duration
    )public pure override returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_REVOKE_ALLOWANCE,
            spender
        );
    }
    */
}