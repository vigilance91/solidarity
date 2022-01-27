// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/EtherTransactorABC.sol";
import "https://github.com/vigilance91/solidarity/contracts/etherReceiver/transactor/iEtherTransactor.sol";
///
/// @title External Ether Transactor Contract
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 1/5/2021, All Rights Reserved
/// @dev Fully realized External extension of EtherTransactorABC which provides safe ETH transfer functionality,
/// similar to ERC20 tokens but for ETH and can be easily implemented in other dApps or be used as a stand alone contract
///
/// NOTE:
///     this contract is only capable of sending and receiving ERC721 tokens,
///     it does NOT have the capacity to mint or burn tokens
///
contract ExternalERC721Transactor is ERC721TransactorABC
    iERC721Transactor
{
    using SafeMath for uint256;
    
    using logicConstraints for bool;
    using addressConstraints for address;
    //using uint256Constraints for uint256;
    
    using frameworkEtherReceiver for address;
    
    string private constant _NAME = ' ExternalEtherTransactor: ';
    //string private constant _TRANSFER_FAILED = _NAME.concatenate('transfer failed');
    
    /// enable proxying to execute optional callback when making an ETH/Token transfers?
    ///
    /// @dev explicitly prevent proxying
    /// NOTE:
    ///     since this contracts methods are external with ReentrancyGuard, not public,
    ///     this will automatically prevent proxying but cauases obscure and hard to track down errors
    ///     so, simply prevent proxying here and any attempt to call a function not declared in this implementation
    ///     will always revert here, no need to figure out issues with function visibility, modifiers, execution context, etc
    /// 
    //fallback(
    //)external view nonReentrant payable{
        //logicConstraints.alwaysRevert('proxying disabled');
    //}
    constructor(
    )public
        ERC721AllowanceTransactorABC()  //ERC721AllowanceTransactorABC()
    {
        _registerInterface(type(iERC721Transactor).interfaceId);
    }
    /// @dev transfer ETH from this contract to recipient
    function thisTransferERC721(
        address recipient,
        uint256 tokenID
    )external virtual override onlyOwner nonReentrant
    {
        //_requireExists(tokenId);
        _thisTransferERC721(recipient, tokenId);
    }
    /// @dev convenience wrapper to transfer ETH from this contract's balance to owner
    function thisTransferERC721ToOwner(
        uint256 tokenId
    )external virtual override onlyOwner nonReentrant
    {
        //_requireAvailableBalanceGreaterThanOrEqual(amount);
        _thisTransferERC721(owner(), tokenId);
    }
    function transferERC721ToThis(
        uint256 tokenId
    )external virtual override nonReentrant
    {
        _transferERC721ToThis(tokenId);
    }
    //
    //external transfer functions
    //
    //function _externalTransferERC721(
        //address tokenContract,
        //address recipient,
        //uint256 tokenId
    //)external virtual override nonReentrant
    //{
    //}
    
    //function _externalTransferERC721ToThis(
        //address tokenContract,
        //uint256 tokenId
    //)internal;
    
    //function _externalTransferERC721ToOwner(
        //address tokenContract,
        //uint256 tokenId
    //)external virtual override nonReentrant
    //{
        //_externalTransferERC721ToOwner(
            //tokenContract,
            //tokenId
        //)
    //}
}