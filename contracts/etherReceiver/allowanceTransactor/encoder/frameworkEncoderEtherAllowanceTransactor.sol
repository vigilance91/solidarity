// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";

import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/allowanceTransactor/encoder/iEncoderEtherAllowanceTransactor.sol";
///
/// @title Ether Allowance Transactor Transaction Encoder Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/9/2021, All Rights Reserved
///
library frameworkEncoderEtherAllowanceTransactor
{
    //string private constant _NAME = ' frameworkEncoderEtherAllowanceTransactor: ';
    //
    using LogicConstraints for bool;
    using AddressConstraints for address;
    
    using Address for address;
    
    using frameworkERC165 for address;
    
    bytes4 private constant _INTERFACE_ID = type(iEncoderEtherAllowanceTransactor).interfaceId;
    
    function _requireSupportsInterface(
        address encoder
    )private
    {
        encoder.requireNotNull();
        encoder.isContract().requireTrue(
            'address not a contract'
        );
        
        encoder.supportsInterface(_INTERFACE_ID).requireTrue(
            'contract does not implement iEncoderEtherAllowanceTransactor'
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethTransferFrom(
        address encoder,
        address from,
        address recipient,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEtherAllowanceTransactor(encoder).ethTransferFrom(
            from,
            recipient,
            amount
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethTransferFromToCaller(
        address encoder,
        address from,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEtherAllowanceTransactor(encoder).ethTransferFromToCaller(
            from,
            amount
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethTransferFromThis(
        address encoder,
        address recipient,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEtherAllowanceTransactor(encoder).ethTransferFromThis(
            recipient,
            amount
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethTransferFromThisToOwner(
        address encoder,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEtherAllowanceTransactor(encoder).ethTransferFromThisToOwner(
            amount
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethTransferFromToThis(
        address encoder,
        address owner,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEtherAllowanceTransactor(encoder).ethTransferFromToThis(
            owner,
            amount
        );
    }
    //
    // approve/revoke allowance functions
    //
    ///
    /// @return {bytes}
    ///
    function approve(
        address encoder,
        address spender
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEtherAllowanceTransactor(encoder).approve(
            spender
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethThisApproveAllowanceFor(
        address encoder,
        address spender,
        uint256 amount
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEtherAllowanceTransactor(encoder).ethThisApproveAllowanceFor(
            spender,
            amount
        );
    }
    ///
    /// @return {bytes}
    ///
    function ethThisRevokeAllowance(
        address encoder,
        address spender
    )internal pure returns(
        bytes memory
    ){
        _requireSupportsInterface(encoder);
        
        return iEncoderEtherAllowanceTransactor(encoder).ethThisRevokeAllowance(
            spender
        );
    }
}