// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/LogicConstraints.sol";
import "https://github.com/vigilance91/solidarity/libraries/address/AddressConstraints.sol";
///
/// @title Contract Constraints Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev provides support to constrain the state of the EVM based on contract addresses,
/// specifically this contract (or those which derive from it)
///
abstract contract ContractConstraintsABC
{
    using AddressConstraints for address;
    //using SafeMath for uint256;
    
    //using uint256ToString for uint256;
    
    //
    address internal _this;
    //address payable _thisPayable;
    
    //string private _chainID;
    ////bytes32 _chainHash;
    
    constructor(
    )internal
    {
        //_chainID = chainID().toDecimal();
        ////_chainHash = _chainID.hash();
        
        _this = address(this);
        //_thisHash = _this.toHex().concatenate(_chainID).hash();
        
        //_thisPayable = payable(_this);
    }
    /**
    function chainID(
    )private view returns(
        uint256 chain
    ){
        assembly {
            chain := chainid()
        }
    }
    
    //function chainID(
    //)public view returns(
        //string memory
    //){
        //return _chainID;
    //}
    
    //function chainHash(
    //)public view returns(
        //bytes32
    //){
        //return _chainHash;
    //}
    //
    //constrain execution of code to a specific chain eg:
    //  Ethereum Mainet:
    //  Ropsten:
    //  :
    //  :
    //  Kovan:
    //  Matic:
    //  BSC:
    //
    function _requireChain(
        uint256 chainID
    )internal view
    {
        chainID().requireEquals(chainID);
    }
    function _requireNotChain(
        uint256 chainID
    )internal view
    {
        chainID().requireNotEquals(chainID);
    }
    function chainEquals(
        uint256 id
    )internal view returns(
    ){
        return chainID().equal(id);
    }
    function chainNotEquals(
        uint256 id
    )internal view returns(
    ){
        return chainID().notEqual(id);
    }
    */
    ///
    /// Contract base calls to Require statements in library
    ///
    function _requireNull(
        address account
    )internal pure
    {
        account.requireIsNull();
    }
    function _requireNotNull(
        address account
    )internal pure
    {
        account.requireIsNotNull();
    }
    
    //function _requireIsContract(
        //address account
    //)internal pure
    //{
        //_requireNotNull(account);
        //account.isContract().requireTrue(
        //);
    //}
    //function _requireIsNotContract(
        //address account
    //)internal pure
    //{
        ////_requireNotNull(account);
        //account.isContract().requireFalse(
        //);
    //}
    
    function _requireNotThis(
        address account
    )internal view
    {
        _this.requireNotEqual(account);
    }
    function _requireNotThisAndNotNull(
        address account
    )internal view
    {
        _this.requireIsNotThisAndNotNull(account);
    }
    function _requireAddressessNotThisAndNotNull(
        address lhs,
        address rhs
    )internal view
    {
        _this.requireAddressessNotThisAndNotNull(lhs,rhs);
    }
}