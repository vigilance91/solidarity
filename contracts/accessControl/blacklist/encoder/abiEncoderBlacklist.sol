// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// @title ERC20 Transaction ABI Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 27/8/2021, All Rights Reserved
/// convenience library for creating encoded signatures for low-level address call operations
///
library abiEncoderERC20
{
    //using frameworkERC165 for address;
    
    //string private constant _NAME = ' encoderERC20: ';
    
    //bytes private constant _ERC20_RECEIVE_SIGNATURE = abi.encodeWithSignature('canReceiveERC20()');
    
    //bytes4 private constant _iERC20_ID = type(iERC20).interfaceId;
    //bytes4 private constant _iSTATIC_TOKEN_SUPPLY_ID = type(iStaticTokenSupply).interfaceId;
    //bytes4 private constant _iTOKEN_IDENTIFIER_ID = type(iTokenIdentifier).interfaceId;
    //
    //getter stubs
    //
    //string internal constant _STUB_NAME = 'name()';
    //string internal constant _STUB_SYMBOL = 'symbol()';
    string internal constant _STUB_TOTAL_SUPPLY = 'totalSupply()';
    //
    //void getter signatures, these signatures are always the same, so precompute them
    //
    //bytes public constant SIG_NAME = abi.encodeWithSignature(_STUB_NAME);
    //bytes public constant SIG_SYMBOL = abi.encodeWithSignature(_STUB_SYMBOL);
    bytes internal constant SIG_TOTAL_SUPPLY = abi.encodeWithSignature(_STUB_TOTAL_SUPPLY);
    //
    //
    //string public constant STUB_IS_BANNED = 'isBanned()';
    //
    //bytes4 internal constant SIG_BANNED_ADDRESS_COUNT = abi.encodeWithSignature('bannedAddressCount()');
    //
    string internal constant STUB_IS_BANNED = 'isBanned(address)';
    //
    string internal constant STUB_BAN = 'ban(address)';
    string internal constant STUB_REVOKE_BAN = 'revokeBan(address)';
    string internal constant STUB_TRANSFER_FROM = 'transferFrom(address,address,uint256)';
    
    ///
    /// @dev Encodes the transaction to get the count of all currently blacklisted addresses
    ///
    function bannedAddressCount(
    )internal pure returns(
        bytes memory
    ){
        return SIG_BANNED_ADDRESS_COUNT;
    }
    
    ///
    /// @dev Encodes the transaction to determine if `account` is currently blacklisted
    ///
    function isBanned(
        address account
    )external pure returns(
        bytes memory
    ){
        
    }
    ///
    /// @dev Encodes a transaction to blacklist `account`
    ///
    function ban(
        address account
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_BAN,
            account
        );
    }
    ///
    /// @dev Encodes a transaction to revoke `account` from blacklist
    ///
    function revokeBan(
        address account
    )internal pure returns(
        bytes memory
    ){
        return abi.encodeWithSignature(
            STUB_REVOKE_BAN,
            account
        );
    }
}