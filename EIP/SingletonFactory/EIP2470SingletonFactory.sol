// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/EIP/SingletonFactory/EIP2470.sol";
import "https://github.com/vigilance91/solidarity/EIP/introspection/Canary/EIP801Canary.sol";
///
/// @title EIP-2470 Singleton Factory Contract
/// @notice Exposes CREATE2 (EIP-1014) to deploy bytecode on deterministic addresses based on initialization code and salt
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 2/4/2021, All Rights Reserved
/// @dev based on EIP-2470 https://eips.ethereum.org/EIPS/eip-2470 by, Ricardo Guilherme Schmidt (Status Research & Development GmbH)
///
//interface iEIP2470SingletonFactory is iEIP2470,
    //iEIP801Canary
//{
//}
contract EIP2470SingletonFactory is EIP801Canary,
    EIP2470,
    iEIP2470
{
    //using eventsEIP2470 for address;
    
    constructor(
    )public 
        EIP801Canary()
        EIP2470()
    {
        _registerInterface(type(iEIP2470).interfaceId);
        //_registerInterface(type(iEIP2470SingletonFactory).interfaceId);
    }
    function deploy(
        bytes memory byteCode,
        bytes32 salt
    )external virtual override returns(
        address
    ){
        return _deploy(byteCode, salt);
    }
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
    ///     - contract constructor is payable
    ///     - `bytecode` must not be empty
    ///     - `salt` must have not been used for `bytecode` already
    ///     - deploying address must have a balance of at least `amount`, to pay constructor
    ///     - `msg.value` is non-zero
    ///     - `bytecode` must have a `payable` constructor
    ///
    function deployPayable(
        bytes memory byteCode,
        bytes32 salt
    )external payable virtual override returns(
        address createdContract
    ){
        //byteCode.requireNotNull();
        //msg.value.requireGreaterThanZero();
        
        //assembly {
            //createdContract := create2(0, add(initCode, 0x20), mload(initCode), salt)
        //}
        
        createdContract = Create2.deploy(
            msg.value,
            salt,
            byteCode
        );
        
        _deployedContracts.push(    //ContractByteCode(
            createdContract
            //byteCode
        );
        
        _emitDeployed(
            createdContract
        );
        
        //if(
            //createdContract.supportsInterface(type(iERC173).interfaceId) ||
            //createdContract.supportsInterface(type(iERC173Ownable).interfaceId) ||
            //createdContract.supportsInterface(type(iEIP801Canary).interfaceId) ||
            ////createdContract.supportsInterface(type(iERC173SafeOwnable).interfaceId) ||
            ////createdContract.supportsInterface(type(iEIP801SafeCanary).interfaceId)
        //){
            //createdContract.transferOwnership(
                //_msgSender()
            //);
        //}
    }
    function deployedContracts(
    )public view override returns(
        address[] memory
    ){
        return _deployedContracts;
    }
}