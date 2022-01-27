// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
/// 
/// @title Units and Unit Conversion Library
/// @author Tyler R. Drury - 3/1/2021, All Rights Reserved
/// @notice This library provides trivial functions for checking
/// or converting values of ether into various denominations
/// and provides constants to be used as keys for mappings containing
/// arbitrary denominations of ether.
/// 
library units
{
    /*
    using uint256Logic for uint256;
    using uint256SafeMath for uint256;
    //using stringUtils for string;
    */
    // bytes32 internal constant K_WEI = keccak256("solidarity.units.WEI");
    //
    bytes32 internal constant K_BABBAGE = keccak256("solidarity.units.BABBAGE");
    bytes32 internal constant K_LOVELACE = keccak256("solidarity.units.LOVELACE");
    bytes32 internal constant K_SHANNON = keccak256("solidarity.units.SHANNON");
    //
    bytes32 internal constant K_SZABO = keccak256("solidarity.units.SZABO");
    bytes32 internal constant K_FINNEY = keccak256("solidarity.units.FINNEY");
    bytes32 internal constant K_ETHER = keccak256("solidarity.units.ETHER");
    bytes32 internal constant K_GRAND = keccak256("solidarity.units.GRAND");
    //
    bytes32 internal constant K_METHER = keccak256("solidarity.units.METHER");
    bytes32 internal constant K_GETHER = keccak256("solidarity.units.GETHER");
    bytes32 internal constant K_TETHER = keccak256("solidarity.units.TETHER");
    //
    //
    //
    uint256 internal constant ZERO = 0;
    
    //uint256 internal constant WEI = 1 wei;
    uint256 internal constant BABBAGE = 1e3;
    uint256 internal constant LOVELACE = 1e6;
    uint256 internal constant SHANNON = 1e9;
    uint256 internal constant SZABO = 1e12;
    //
    uint256 internal constant FINNEY = 1e15;
    uint256 internal constant ETHER = 1e18;
    uint256 internal constant GRAND = 1e3 ether;
    //uint256 internal constant .... = 1e6 ether;?
    //
    uint256 internal constant GETHER = 1e9 ether;
    uint256 internal constant METHER = 1e12 ether;
    uint256 internal constant TETHER = 1e15 ether;
    //
    //
    //
    //enum weiDeonominations{
        //WEI = 1;
        //BABBAGE = 1e3;
        //LOVELACE = 1e6;
        //SHANNON = 1e9;
        //SZABO = 1e12;
        //
        //FINNEY = 1e15;
        //ETHER = 1e18;
        //GRAND = 1e3 ether;
        ////uint256 internal constant .... = 1e6 ether;?
        //
        //GETHER = 1e9 ether;
        //METHER = 1e12 ether;
        //TETHER = 1e15 ether
    //};
    
    function isUnitKey(
        bytes32 key
    )internal pure returns(
        bool
    ){
        return (
            //key == K_WEI ||
            //
            key == K_BABBAGE ||
            key == K_LOVELACE ||
            key == K_SHANNON ||
            key == K_SZABO ||
            //
            key == K_FINNEY ||
            key == K_ETHER ||
            key == K_GRAND ||
            //
            key == K_METHER ||
            key == K_GETHER ||
            key == K_TETHER
        );
    }
    //function isDenomination(
        //uint256 value
        //uint256 denomination
    //)internal pure returns(
        //bool
    //){
        //return value < denomination.mul(1000) && value >= denomination;
    //}
    
    /// @notice is value between 1 and 999 wei
    //function isWei(
        //uint256 value
    //)internal pure returns(
        //bool
    //){
        ////return value < 1e6 && value >= BABBAGE;
        //return value < BABBAGE && value > 0;
    //}
    //
    /// @notice is value between 1 and 999 babge
    function isBabage(
        uint256 value
    )internal pure returns(
        bool
    ){
        //return value < 1e6 && value >= BABBAGE;
        return value < LOVELACE && value >= BABBAGE;
    }
    /// @notice is value between 1 and 999 lovelace
    function isLovelace(
        uint256 value
    )internal pure returns(
        bool
    ){
        //return value < 1e9 && value >= 1e6;
        return value < SHANNON && value >= LOVELACE;
    }
    /// @notice is value between 1 and 999 shannon
    function isShannon(
        uint256 value
    )internal pure returns(
        bool
    ){
        return value < SZABO && value >= SHANNON;
    }
    /// @notice is value between 1 and 999 szabo
    function isSzabo(
        uint256 value
    )internal pure returns(
        bool
    ){
        //return value < 1e15 && value >= 1e12;
        return value < FINNEY && value >= SZABO;
    }
    /// @notice is value between 1 and 999 finney
    function isFinney(
        uint256 value
    )internal pure returns(
        bool
    ){
        //return value < 1 ether && value >= 1 finney;
        return value < 1 ether && value >= FINNEY;
    }
    /// @notice is value between 1 and 999 ether
    function isEther(
        uint256 value
    )internal pure returns(
        bool
    ){
        return value < 1000 ether && value >= 1 ether;
    }
    function isGrand(
        uint256 value
    )internal pure returns(
        bool
    ){
        return value < 1e6 ether && value >= 1e3 ether;
    }
    /// @notice is value between 1 and 999 gether (giga-ether)
    //function isGether(
        //uint256 value
    //) internal pure returns(
        //bool
    //){
        //return value >= 1e6 ether && value < 1e9 ether;
    //}
    /// @notice is value between 1 and 999 mether (mega-ether)
    //function isMether(
        //uint256 value
    //)internal pure
        //returns(bool
    //){
        //return value >= 1e9 ether && value < 1e12 ether;
    //}
    /// @notice is value greater than or equal to 1 tether (tera-ether)
    //function isTether(
        //uint256 value
    //) internal pure returns(
        //bool
    //){
        //return value >= 1e12 ether;
    //}
    /**
     *Denomination Conversions from wei
     */
    function denominationFromWei(
        uint256 value,
        uint256 denomination
    )internal pure returns(
        uint256
    ){
        return value < denomination ? ZERO : value / denomination;
    }
    /// @notice 1,000 wei == 1 babage
    function babbageFromWei(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return denominationFromWei(value, BABBAGE);
    }
    /// @notice 1,000,000 wei == 1 lovelace
    function lovelaceFromWei(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return denominationFromWei(value, LOVELACE);
    }
    /// @notice 1,000,000,000 wei == 1 shannon
    function shannonFromWei(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return denominationFromWei(value, SHANNON);
    }
    /// @notice 1,000,000,000,000 wei == 1 szabo
    function szaboFromWei(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return denominationFromWei(value, SZABO);    //1e12;
    }
    /// @notice 1,000,000,000,000,000 wei == 1 finney
    function finneyFromWei(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return denominationFromWei(value, FINNEY);
    }
    /// @notice 1,000,000,000,000,000,000 wei == 1 ether
    function etherFromWei(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return denominationFromWei(value, 1 ether);
    }
    /// @notice 1,000,000,000,000,000,000,000 wei == 1 grand
    function grandFromWei(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return denominationFromWei(value, GRAND);
    }
    function getherFromWei(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return denominationFromWei(value, GETHER);    //1e6 ether;
    }
    function metherFromWei(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return denominationFromWei(value, METHER);  //1e9 ether;
    }
    function tetherFromWei(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return denominationFromWei(value, TETHER);    //1e12 ether;
    }
    /**
     * Denomination Conversions to wei,
     * note this behaviour is provided by default by the compiler using the various wei, ether, etc keywords
     /
    /// @notice 1,000 wei == 1 babage
    function weiFromBabbage(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return value.mul(BABBAGE);
    }
    /// @notice 1,000,000 wei == 1 lovelace
    function WeiFromlovelace(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return value.mul(LOVELACE);
    }
    /// @notice 1,000,000,000 wei == 1 shannon
    function shannonFromWei(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return value < SHANNON ? ZERO : value / SHANNON;    //1e9;
    }
    /// @notice 1,000,000,000,000 wei == 1 szabo
    function weiFromSzabo(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return value.mul(SZABO);
    }
    /// @notice 1,000,000,000,000,000 wei == 1 finney
    function weiFromFinney(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return value.mul(FINNEY);
    }
    /// @notice 1,000,000,000,000,000,000 wei == 1 ether
    function weiFromEther(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return value.mul(1 ether);
    }
    /// @notice 1,000,000,000,000,000,000,000 wei == 1 grand
    function weiFromGrand(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return value.mul(GRAND);
    }
    function weiFromGether(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return value.mul(GETHER);
    }
    function weiFromMether(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return value.mul(METHER);
    }
    function weiFromTether(
        uint256 value
    )internal pure returns(
        uint256
    ){
        return value.mul(TETHER);
    }
    */
}