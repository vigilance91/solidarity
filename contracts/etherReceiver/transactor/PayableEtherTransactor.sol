// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/ExternalEtherTransactor.sol";
///
/// @title Payable Ether Transactor Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 12/12/2021, All Rights Reserved
/// @dev Fully realized External extension of EtherTransactorABC which provides safe ETH transfer functionality,
/// similar to ERC20 tokens but for ETH and can be easily implemented in other dApps or be used as a stand alone contract
///
contract PayableEtherTransactor is ExternalEtherTransactor
{
    //using stringUtilities for string;
    //using Address for address;
    //
    string private constant _NAME = ' PayableEtherTransactor: ';
    
    string private constant _TRANSFER_FAILED = string(
        abi.encodePacked(
            _NAME,
            'transfer failed'
        )
    );
    
    constructor(
    )public payable
        ExternalEtherTransactor()
    {
        //_requireMsgValueGreatherThanZero();
        
        //if(msg.value > 0){
            ////payable(_this).safeTransfer(msg.value).requireTrue(_TRANSFER_FAILED);
            //(bool success, ) = payable(address(this)).call{value:msg.value}("");
            
            //require(success, _TRANSFER_FAILED);
        //}
    }
}