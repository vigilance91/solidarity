// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

//import "https://github.com/vigilance91/solidarity/ERC/introspection/ERC165/frameworkERC165.sol";
import "https://github.com/vigilance91/solidarity/ERC/ERC173/frameworkERC173.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/ERC173/ERC173ReceiverConstraintsABC.sol";

import "https://github.com/vigilance91/solidarity/contracts/ownership/safeERC173/frameworkSafeERC173.sol";
///
/// @title ERC173 Owner Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@g       mail.com> (www.twitter.com/StudiosVigil) - copyright 17/1/2021, All Rights Reserved
/// @dev not recommended for use, operations are not safe which means,
/// the implementing contract makes no gaurentee ownership of an external contract is passed to a contract which lacks
/// support for this interface
/// 
/// This contract itself does not natively have an owner and mean to be autonomous.
/// If the contract is intended to own other contracts and also is itself owned by another ERC173 compliant contract,
/// please inherit from `SafeERC173OwnableOwner`
///
abstract contract ERC173OwnerABC //is ERC173ReceiverConstraintsABC
{
    using logicConstraints for bool;
    
    using Address for address;
    
    using addressLogic for address;
    using addressConstraints for address;
    
    //using frameworkERC165 for address;
    using frameworkERC173 for address;
    
    constructor(
    )internal
        //ERC173ReceiverConstraintsABC()
    {
    }
    /// @dev this contract supports ownership transfers to some other address
    function _transferOwnership(
        address ownable,
        address newOwner
    )internal
    {
        //_requireSupportsInterface(recipient);
        address O = iERC173(ownable).owner();
        
        O.requireNotNull();
        O.requireEqual(
            address(this)
            //'invalid owner'
        );
        
        //revert transaction if this contract is already owner of ownable,
        //don't waste ether on redundant call
        address(this).requireNotEqualAndNotNull(newOwner);
       
        //address(this).transferOwnership(ownable, newOwner);
        iERC173(ownable).transferOwnership(newOwner);
    }
    function _renounceOwnership(
        address ownable
    )internal
    {
        address O = iERC173(ownable).owner();
        
        O.requireNotNull();
        O.requireEqual(
            address(this)
            //'invalid owner'
        );
        
        iERC173(ownable).renounceOwnership();
        
        //assert(ownable.owner().equal(addressLogic.NULL));
    }
}