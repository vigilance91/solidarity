// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoverV2;
///
/// @title Static Supply Cap Interface
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 23/4/2021, All Rights Reserved
///
interface iStaticSupplyCap
{
    /// @dev with a static supply cap token, the token cap is the total supply
    function cap(
    )external view returns(
        uint256
    );
    //function balanceOfToCap(
        //address account
    //)external view returns(
        //uint256 numerator,
        //uint256 denominator
    //);
    //@return {tuple} balance of and market cap of this token in one call
    //function balanceOfToCap(
    //)external view returns(
        //uint256 numerator,
        //uint256 denominator
    //);
    //@return {tuple} get current circulating supply and market cap of this token in one call
    //useful for determining the total percentage of circulating tokens (using a off-block chain computation of: numerator / denominator)
    //notice if numerator is < denominator, since Ethereum has no float-point numbers,
    //the result, if calculated by the EVM, would only ever either an integer value of 0 or 1,
    //with 0 being less than the total supply in circulation and 1 being the total suppl is in circulation
    //function totalSupplyToCap(
    //)external view returns(
        //uint256 numerator,
        //uint256 denominator
    //);
}