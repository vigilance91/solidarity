// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/unsigned/uint256ToString.sol";

import "./units.sol";
//import "https://github.com/vigilance91/solidarity/libraries/units/units.sol";
/// 
/// @title Units and Unit Conversion Library
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @notice This library provides trivial functions for checking
/// or converting values of ether into various denominations
/// and provides constants to be used as keys for mappings containing
/// arbitrary denominations of ether.
/// 
library unitsToString
{
    using uint256ToString for uint256;
    /**
     *Denomination Conversions from wei
     */
     /*
    function fromDenominationToOctalString(
        uint256 value,
        uint256 denomination
    )internal pure returns(
        string memory
    ){
        return units.denominationFromWei(value, denomination).octal();
    }
    function fromDenominationToDecimalString(
        uint256 value,
        uint256 denomination
    )internal pure returns(
        string memory
    ){
        return units.denominationFromWei(value, denomination).decimal();
    }
    function fromDenominationToHexadecimalString(
        uint256 value,
        uint256 denomination
    )internal pure returns(
        string memory
    ){
        return units.denominationFromWei(value, denomination).hexadecimal();
    }
    */
    /// @notice 1,000 wei == 1 babage
    function babbageFromWei(
        uint256 value
    )internal pure returns(
        string memory
    ){
        return string(abi.encode(
            units.denominationFromWei(value, units.BABBAGE),
            ' babbage'
        ));
    }
    /// @notice 1,000,000 wei == 1 lovelace
    function lovelaceFromWei(
        uint256 value
    )internal pure returns(
        string memory
    ){
        return string(abi.encode(
            units.denominationFromWei(value, units.LOVELACE),
            ' lovelace'
        ));
    }
    /// @notice 1,000,000,000 wei == 1 shannon
    function shannonFromWei(
        uint256 value
    )internal pure returns(
        string memory
    ){
        return string(abi.encode(
            units.denominationFromWei(value, units.SHANNON),
            ' shannon'
        ));
    }
    /// @notice 1,000,000,000,000 wei == 1 szabo
    function szaboFromWei(
        uint256 value
    )internal pure returns(
        string memory
    ){
        return string(abi.encode(
            units.denominationFromWei(value, units.SZABO),
            ' szabo'
        ));
    }
    /// @notice 1,000,000,000,000,000 wei == 1 finney
    function finneyFromWei(
        uint256 value
    )internal pure returns(
        string memory
    ){
        return string(abi.encode(
            units.denominationFromWei(value, units.FINNEY),
            ' finney'
        ));
    }
    /// @notice 1,000,000,000,000,000,000 wei == 1 ether
    function etherFromWei(
        uint256 value
    )internal pure returns(
        string memory
    ){
        return string(abi.encode(
            units.denominationFromWei(value, units.ETHER),
            ' ether'
        ));
    }
    /// @notice 1,000,000,000,000,000,000,000 wei == 1 grand
    function grandFromWei(
        uint256 value
    )internal pure returns(
        string memory
    ){
        return string(abi.encode(
            units.denominationFromWei(value, units.GRAND),
            ' grand'
        ));
    }
    function getherFromWei(
        uint256 value
    )internal pure returns(
        string memory
    ){
        return string(abi.encode(
            units.denominationFromWei(value, units.GETHER),
            ' gether'
        ));
    }
    function metherFromWei(
        uint256 value
    )internal pure returns(
        string memory
    ){
        return string(abi.encode(
            units.denominationFromWei(value, units.METHER),
            ' mether'
        ));
    }
    function tetherFromWei(
        uint256 value
    )internal pure returns(
        string memory
    ){
        return string(abi.encode(
            units.denominationFromWei(value, units.TETHER),
            ' tether'
        ));
    }
}