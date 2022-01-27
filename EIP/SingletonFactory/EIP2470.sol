// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/GSN/Context.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/utils/Create2.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/proxy/Initializable.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/EIP/SingletonFactory/iEIP2470.sol";
//import "https://github.com/vigilance91/solidarity/EIP/SingletonFactory/eventsEIP2470.sol";
//import "./iEIP2470.sol";
//import "./eventsEIP2470.sol";
///
/// @title EIP-2470 Singleton Factory Abstract Base Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
/// @dev EIP-2470 Singleton Factory - https://eips.ethereum.org/EIPS/eip-2470 by, Ricardo Guilherme Schmidt (Status Research & Development GmbH)
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
/// @dev based on EIP-2470 https://eips.ethereum.org/EIPS/eip-2470 by, Ricardo Guilherme Schmidt (Status Research & Development GmbH)
/// @notice Exposes CREATE2 (EIP-1014) to deploy bytecode on deterministic addresses based on initialization code and salt
/// todo EIP2470 mixin
///
abstract contract EIP2470 is Context
{
    //using eventsEIP2470 for address;
    //using frameworkSafeERC173 for address;
    
    //array of all singleton contracts deployed by this contract
    
    //struct ContractByteCode{
        //address contract;
        //bytes byteCode;
    //}
    
    ////EnumerableContractByteCodeMap private _deployedContracts;
    //ContractByteCode[] private _deployedContracts;
    
    //using EnumerableMap for EnumerableMap.UintToAddresMap;
    //EnumerableMap _deployedContracts;
    address[] internal _deployedContracts;
    
    event Deployed(
        address deployedContract,
        //address deployer,
        uint time,
        uint blockNumber
    );
    
    function _emitDeployed(
        address deployedContract
    )internal
    {
        emit Deployed(
            deployedContract,
            block.timestamp,
            block.number
        );
    }
    
    constructor(
    )internal Context()
        //EIP801Canary()
    {
        _deployedContracts = new address[](0);
    }
    //function initialize(
    //)public view virtual returns(
        //address[] memory
    //){
        //emitInitialized(address(this), _deployedContracts);
        //return _deployedContracts;
    //}
    ///
    /// @notice Deploys `byteCode` using `salt` for defining the deterministic address
    /// @param byteCode Initialization code of a contract to deploy
    /// @param salt Arbitrary value to modify resulting address
    /// @return createdContract {address} newly created contract at a specific address
    /// @dev bytes code of a contract can be attain via:
    /// ```
    /// type(contractName).creationCode;
    /// ```
    /// Requirements:
    ///     - contract constructor in NOT payable
    ///     - `bytecode` must not be empty
    ///     - `salt` must have not been used for `bytecode` already
    ///
    function _deploy(
        bytes memory byteCode,
        bytes32 salt
    )internal returns(
        address createdContract
    ){
        //make salt dependant upon _msgSender, so multiple senders may
        //use the same salt but still get a unique contract location
        //string S = string(
            //_msgSender().hexadecimal().saltAndHash(salt)
        //);
        
        //assembly {
            //createdContract := create2(0, add(initCode, 0x20), mload(initCode), salt)
        //}
        
        createdContract = Create2.deploy(
            0,
            salt,
            byteCode
        );
        //
        _deployedContracts.push(   //ContractByteCode(
            createdContract
            //byteCode
            //)
        );
        
        _emitDeployed(createdContract);
        
        //this contract will be owner, if contract is ERC173 compliant,
        //so, after creation, transfer ownership from this contract, to the appropriate deployer
        //if(
            //createdContract.supportsInterface(type(iERC173).interfaceId) ||
            ////createdContract.supportsInterface(type(iERC173Ownable).interfaceId) ||
            //createdContract.supportsInterface(type(iEIP801Canary).interfaceId)
        //){
            //createdContract.transferOwnership(
                //_msgSender()
            //);
        //}
    }
    //function sliceDeployedContracts(
        //uint256 startIndex,
        //uint256 endIndex
    //)public view override returns(
        //address[] memory
    //){
        //return _deployedContracts;
    //}
    
    //kill target contract forcing it to call selfdestruct then remove it from deployed contracts
    //function targetApoptosis(
        //address target
    //)external onlyOwner
    //{
        //(bool result, ) = address.call(
            //abi.encodeWithSignature('apoptosis()')
        //);
        //result.requireTrue('call failed');
        //_deployedContracts.remove(contract);
    //}
    
    ///
    /// @return {address} location where a contract will be stored if deployed via {deploy} and this contract was the deployer
    /// @dev Any change to `bytecodeHash` or `salt` will result in a new, unique destination address
    ///
    function _computeAddress(
        bytes32 bytecodeHash,
        bytes32 salt
    )internal view returns(
        address
    ){
        return Create2.computeAddress(
            salt,
            bytecodeHash,
            address(this)
        );
    }
    ///
    /// @return {address} location where a contract will be stored if deployed via {deploy} from contract `deployer`
    /// @dev If `deployer` is this contract's address, returns the same value as {computeAddress}
    ///
    function computeAddress(
        bytes32 bytecodeHash,
        bytes32 salt,
        address deployer
    )external pure returns(
        address
    ){
        return Create2.computeAddress(
            salt,
            bytecodeHash,
            deployer
        );
    }
}