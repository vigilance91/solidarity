// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/math/SafeMath.sol";
///
/// @title Token Supply Events Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @dev emitters and events relavent to Token Supply mechanisms
///
library eventsTokenSupply
{
    event SetTotalSupply(
        uint256 currentSupply,
        uint256 newSupply,
        uint time,
        uint blockNumber
    );
    
    event IncreaseTotalSupply(
        uint256 currentSupply,
        uint256 amountBy,
        uint256 newSupply,
        uint time,
        uint blockNumber
    );
    
    event DecreaseTotalSupply(
        uint256 currentSupply,
        uint256 amountBy,
        uint256 newSupply,
        uint time,
        uint blockNumber
    );
    
    function emitSetTotalSupply(
        uint256 currentSupply,
        uint256 newSupply
    )internal
    {
        emit SetTotalSupply(
            currentSupply,
            newSupply,
            block,timestamp,
            block.number
        );
    }
    
    function emitIncreaseTotalSupply(
        uint256 currentSupply,
        uint256 amountBy,
        uint256 newSupply
    )internal
    {
        emit IncreaseTotalSupply(
            currentSupply,
            amountBy,
            newSupply,
            block,timestamp,
            block.number
        );
    }
    function emitDecreaseTotalSupply(
        uint256 currentSupply,
        uint256 amountBy,
        uint256 newSupply
    )internal
    {
        emit DecreaseTotalSupply(
            currentSupply,
            amountBy,
            newSupply,
            block,timestamp,
            block.number
        );
    }
}