// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

interface iEIP1066Status
{
    function message(
        string memory statusCode
    )external view returns(
        string memory
    );
    
    function message(
        string memory statusCode,
        string memory errorMessage
    )external view returns(
        string memory
    );
    /**
    function message(
        bytes1 statusCode
    )external view returns(
        string memory
    );
    
    function message(
        bytes1 statusCode,
        string memory errorMessage
    )external view returns(
        string memory
    );
    */
}
///
/// @title EIP-1066 Status Code Mixin Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 17/3/2021, All Rights Reserved
/// @dev creates a human readable string for output via an assert revert, require or emit function call
///
library mixinEIP1066Status
{
    using stringUtilities for string;
    //using bytes1Utilities for bytes1;
    
    struct EIP1066Storage{
        string prefix;
    }
    
    bytes32 internal constant STORAGE_SLOT = keccak256("EIP-1066.status.code.mixin.storage");
    
    function storageEIP1066(
    )internal pure returns(
        EIP1066Storage storage ret
    ){
        bytes32 position = STORAGE_SLOT;
        
        assembly {
            ret_slot := position
        }
    }
    function initialize(
        string memory contractName
    )internal
    {
        //contractName.requireNotEmpty();
        //storageEIP1066().prefix.requireEmpty();
        
        return storageEIP1066().prefix = contractName.concatenate(": ");
    }
    ///
    ///getters
    ///
    function prefix(
    )internal view returns(
        string memory
    ){
        return storageEIP1066().prefix;
    }
    ///
    ///error messages
    ///
    function message(
        string memory statusCode
    )internal view returns(
        string memory
    ){
        return prefix().concatenate(statusCode);
    }
    function message(
        string memory statusCode,
        string memory errorMessage
    )internal view returns(
        string memory
    ){
        return prefix().concatenate(
            statusCode
        ).concatenate(
            errorMessage
        );
    }
    /**
    function message(
        bytes1 statusCode
    )internal view returns(
        string memory
    ){
        return abi.encodePacked(
            prefix(),
            statusCode
        );
    }
    function message(
        bytes1 statusCode,
        string memory errorMessage
    )internal view returns(
        string memory
    ){
        return message(
            statusCode
        ).concatenate(
            errorMessage
        );
    }
    */
}

contract StatusCode is iEIP1066Status
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
    //)public view returns(
        //string memory
    //){
        //return mixinEIP1066Status.prefix();
    //}
    ///
    ///error messages
    ///
    function message(
        string memory statusCode
    )public view returns(
        string memory
    ){
        return mixinEIP1066Status.message(statusCode);
    }
    function message(
        string memory statusCode,
        string memory errorMessage
    )public view returns(
        string memory
    ){
        return mixinEIP1066Status.message(
            statusCode,
            errorMessage
        );
    }
    /**
    function message(
        bytes1 statusCode
    )internal view returns(
        string memory
    ){
        return mixinEIP1066Status.message(
            statusCode
        );
    }
    function message(
        bytes1 statusCode,
        string memory errorMessage
    )internal view returns(
        string memory
    ){
        return mixinEIP1066Status.message(
            statusCode,
            errorMessage
        );
    }
    */
}