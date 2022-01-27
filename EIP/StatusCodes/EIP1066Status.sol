// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "./iEIP1066Status.sol";
/**
contract EIP1066Status is iEIP1066Status
    //NonPayable
{
    constructor(
        string memory prefix
    )public
    {
        mixinEIP1066Status.initialize(prefix);
    }
    //function _readOnlyStorage(
    //)private view returns(
        //mixinEIP1066Status.storageEIP1066 storage
    //){
        //return mixinEIP1066Status.storageEIP1066();
    //}
    //function prefix(
    //)public view override returns(
        //string memory
    //){
        //return mixinEIP1066Status.prefix();
    //}
    ///
    ///error messages
    ///
    function message(
        string memory statusCode
    )public view override returns(
        string memory
    ){
        return mixinEIP1066Status.message(statusCode);
    }
    function message(
        string memory statusCode,
        string memory errorMessage
    )public view override returns(
        string memory
    ){
        return mixinEIP1066Status.message(
            statusCode,
            errorMessage
        );
    }
    
    function message(
        bytes1 statusCode
    )public view override returns(
        string memory
    ){
        return mixinEIP1066Status.message(
            statusCode
        );
    }
    function message(
        bytes1 statusCode,
        string memory errorMessage
    )public view override returns(
        string memory
    ){
        return mixinEIP1066Status.message(
            statusCode,
            errorMessage
        );
    }
    
}
*/