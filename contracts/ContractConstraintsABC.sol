// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/chainId/ChainIdConstraintsABC.sol";

import "https://github.com/vigilance91/solidarity/contracts/mixinContract.sol";

//interface iContract is iChainId
//{
    //function domainNameSeperator(
    //)external view returns(
        //bytes32
    //);
    //
    ////function isContract(
        ////address account
    ////)external pure returns(
        ////bool
    ////);
    //
    //address encoded and packed to 32 bytes, not recommended for commercial use
    //function thisRawPackedHash(
    //)external view returns(
        //bytes32
    //);
    //
    //function thisHash(
    //)external view returns(
        //bytes32
    //);
//}

//interface iContractConstraints is iChainIdConstraints
//{
    //function domainNameSeperator(
    //)external view returns(
        //bytes32
    //);
    //
    ////function isContract(
        ////address account
    ////)external pure returns(
        ////bool
    ////);
    //
    //address encoded and packed to 32 bytes, not recommended for commercial use
    //function thisRawPackedHash(
    //)external view returns(
        //bytes32
    //);
    //
    //function thisHash(
    //)external view returns(
        //bytes32
    //);
//}
///
/// @title Contract Constraints Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 5/4/2021, All Rights Reserved
/// @dev provides support to constrain the state of the EVM based on contract addresses,
/// specifically this contract (or those which derive from it)
///
abstract contract ContractConstraintsABC is ChainIdConstraintsABC
{
    using Address for address;
    using AddressConstraints for address;
    
    using mixinContract for bytes32;
    
    ////string internal _domainNameSeperator;
    string private constant _NAME = ' ContractConstraintsABC: ';
    
    bytes32 private constant _CONTRACT_STORAGE_SLOT = keccak256(
        'solidarity.ContractConstraintsABC.CONTRACT_STORAGE_SLOT'
    );
    //bytes32 private constant _CHAIN_ID_STORAGE_SLOT = keccak256(
        //'solidarity.ChainIdConstraintsABC.STORAGE_SLOT'
    //);
    
    constructor(
        //address deployer
    )internal
        ChainIdConstraintsABC(
            //mixinContract.thisSlot(
                //block.number,
                //keccak256('solidarity.contractConstraintsABC.chainId.STORAGE_SLOT')
            //)
        )
    {
        //_chainIdStorageSlot = mixinContract.thisSlot(
            //block.number,
            //keccak256('solidarity.contractConstraintsABC.chainId.STORAGE_SLOT')
        //);
        //_contractStorageSlot = mixinContract.thisSlot(
            //block.number,
            //keccak256('solidarity.contractConstraintsABC.contract.STORAGE_SLOT')
        //);

        _CONTRACT_STORAGE_SLOT.set(
            //deployer,
            address(this),
            _chainIdString()
        );
        
        ////_domainNameSeperator = _thisHexString().concatenate(chainIdString()).concatenate(_NAME);
        
        //_thisPayable = payable(_this);
    }
    //
    //Mixin Contract Storage
    //
    function _this(
    )internal view returns(
        address
    ){
        return _CONTRACT_STORAGE_SLOT.thisAddress();
    }
    //function thisRawHash(
    //)public view returns(
        //bytes32
    //){
        //return _CONTRACT_STORAGE_SLOT.thisRawHash();
    //}
    
    function thisHash(
    )public view returns(
        bytes32
    ){
        return _CONTRACT_STORAGE_SLOT.thisHash();
    }
    function _thisHexString(
    )internal view returns(
        string memory
    ){
        return _CONTRACT_STORAGE_SLOT.thisHexString();
    }
    
    function _isContract(
        address account
    )internal view returns(
        bool
    ){
        return account.isContract();
    }
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
        account.requireNotNull();
    }
    function _requireIsNull(
        address[] memory accounts
    )internal pure
    {
        //accounts.requireIsNull();

        for(uint i; i < accounts.length; i++){
            accounts[i].requireIsNull(
                //""
            );
        }
    }
    function _requireNotNull(
        address[] memory accounts
    )internal pure
    {
        for(uint i; i < accounts.length; i++){
            accounts[i].requireNotNull(
                //""
            );
        }
    }
    //function _requireNull(
        //address account,
        //string memory message
    //)internal pure
    //{
        //account.requireIsNull(message);
    //}
    
    //function _requireNotNull(
        //address account,
        //string memory message
    //)internal pure
    //{
        //account.requireNotNull(message);
    //}
    
    function _requireIsContract(
        address account
    )internal view
    {
        account.requireContract(
            //'address is not a contract'
        );
    }
    
    function _requireAreContracts(
        address[] memory accounts
    )internal view
    {
        for(uint i; i < accounts.length; i++){
            _requireIsContract(
                accounts[i]
            );
        }
    }
    function _requireNotContract(
        address account
    )internal view
    {
        account.requireNotContract(
            //'address is not a contract'
        );
    }
    function _requireAreNotContracts(
        address[] memory accounts
    )internal view
    {
        for(uint i; i < accounts.length; i++){
            _requireNotContract(
                accounts[i]
            );
        }
    }
    function _requireEqualAndNotNull(
        address lhs,
        address rhs
    )internal pure
    {
        lhs.requireNotEqualAndNotNull(rhs);
    }
    function _requireNotEqualAndNotNull(
        address lhs,
        address rhs
    )internal pure
    {
        lhs.requireNotEqualAndNotNull(rhs);
    }

    //use to ensure both addresses are contracts and neither are the same or null
    function _requireContractsAndNotEqual(
        address lhs,
        address rhs
    )internal view
    {
        lhs.requireNotEqualAndNotNull(rhs);
        //
        _requireIsContract(lhs);
        _requireIsContract(rhs);
    }
    
    //use to ensure both addresses are wallets and neither are the same or null
    function _requireNotContractsAndNotEqual(
        address lhs,
        address rhs
    )internal view
    {
        lhs.requireNotEqualAndNotNull(rhs);
        //
        _requireNotContract(lhs);
        _requireNotContract(rhs);
    }
    //ensures lhs is an EOA (Externally owner account) and rhs is a smart contract
    function _requireEOAToContract(
        address lhs,
        address rhs
    )internal view
    {
        _requireNotEqualAndNotNull(lhs,rhs);
        //
        _requireNotContract(lhs);
        _requireIsContract(rhs);
    }
    function _requireContractToEOA(
        address lhs,
        address rhs
    )internal view
    {
        _requireNotEqualAndNotNull(lhs,rhs);
        //
        _requireIsContract(lhs);
        _requireNotContract(rhs);
    }
    function _requireEOAsToContracts(
        address[] memory lhs,
        address[] memory rhs
    )internal view
    {
        //lhs.length.requireEqual(
            //rhs.length
            ////"invalid length"
        //);

        for(uint i; i < lhs.length; i++){
            _requireEOAToContract(
                lhs[i],
                rhs[i]
            );
        }
    }
    //
    //ensures lhs is a smart contract and rhs an EOA (Externally owner account)
    function _requireContractsToEOAs(
        address[] memory lhs,
        address[] memory rhs
    )internal view
    {
        //lhs.length.requireEqual(
            //rhs.length
            ////"invalid length"
        //);

        for(uint i; i < lhs.length; i++){
            _requireContractToEOA(
                lhs[i],
                rhs[i]
            );
        }
    }
    
    function _requireNotThis(
        address account
    )internal view
    {
        _this().requireNotEqual(account);
    }
    function _requireNotThisAndNotNull(
        address account
    )internal view
    {
        _this().requireNotEqualAndNotNull(account);
    }
    function _requireNotThisAndNotNull(
        address lhs,
        address rhs
    )internal view
    {
        _this().requireAddressesNotThisAndNotNull(lhs,rhs);
    }

    function _requireNotThisAndNotNull(
        address[] memory accounts
    )internal view
    {
        address T = _this();

        for(uint i; i < accounts.length; i++){
            T.requireNotEqualAndNotNull(accounts[i]);
        }
    }
}

/*
///
/// @title Contract Constraints
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 16/9/2021, All Rights Reserved
/// @dev gas cost to deploy: 903,038 
///
contract ContractConstraints is ContractConstraintsABC
    //iContract
{
    constructor(
    )public
        ContractConstraintsABC()
    {
    }
    //function thisHexString(
    //)external view returns(
        //string memory
    //){
        //return _thisHexString();
    //}
}
*/