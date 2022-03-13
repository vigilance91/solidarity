// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/proxy/Proxy.sol";
//import "https://github.com/vigilance91/solidarity/contracts/proxies/NonreentrantContextProxyABC.sol";

import "https://github.com/vigilance91/solidarity/libraries/address/addressConstraints.sol";

import "https://github.com/vigilance91/solidarity/libraries/bytes32/storageSlot.sol";
//import "./storageSlot.sol";

//interface iEIP1967
//{
    //
//}

abstract contract EIP1967ProxyImplementation is Proxy
{
    using storageSlot for bytes32;

    using addressConstraints for address;
    
    bytes32 private constant _IMPLEMENTATION_SLOT = bytes32(uint256(keccak256("eip1967.proxy.implementation")) - 1);

    constructor(
        address implementation
    )internal
    {
        _setImplementation(implementation);
    }
    ///
    /// @return impl {address} current logic implementation
    ///
    function _implementation(
    )internal override view returns(
        address
    ){
        _IMPLEMENTATION_SLOT.getAddress();
        
        //bytes32 slot = _IMPLEMENTATION_SLOT;
        // solhint-disable-next-line no-inline-assembly
        //assembly {
            //impl := sload(slot)
        //}
    }
    ///
    /// @dev Stores a new address at the EIP-1967 implementation slot
    ///
    function _setImplementation(
        address newImplementation
    )internal virtual
    {
        newImplementation.requireContract(
            //string(
                //abi.encodePacked(
                    //_ERR_IMPLEMENTATION_NOT_CONTRACT,
                    //newImplementation
                //)
            //)
        );
        
        //require(
            //_IMPLEMENTATION_SLOT != newImplementation,
            //_ERR_IMPLEMENTATION_ALREADY_SET
        //);
        
        _IMPLEMENTATION_SLOT.setAddress(newImplementation);
        
        //bytes32 slot = _IMPLEMENTATION_SLOT;
        //
        // solhint-disable-next-line no-inline-assembly
        //assembly {
            //sstore(slot, newImplementation)
        //}
    }
}