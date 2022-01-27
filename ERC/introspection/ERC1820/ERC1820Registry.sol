// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "./iERC1820Registry.sol";
import "./ERC1820Implementer.sol";

//interface iERC1820... is iERC165,
//    iERC1820Implementer,
//    iERC1820Registry
//{
//}
///
/// @dev {ERC1820Registry} ERC1820 REgistry implementation
///
/// Derived contracts may call {_registerInterfaceForAddress} to
/// declare their willingness to be implementers of an interface.
/// To then complete interface registration, {iERC1820Registry.setInterfaceImplementer} should be called
///
contract ERC1820Registry is //ERC165,
    PausableAccessControl,
    ERC1820Implementer
    //SafeERC173Ownable
{
    using eventsERC1820Registry for address;
    
    bytes32 public constant ROLE_ERC1820_ADMIN = keccak256("ERC1820Registry.ROLE_ADMIN");
    bytes32 public constant ROLE_MANAGER = keccak256("ERC1820Registry.ROLE_MANAGER");
    
    /// @notice mapping from addresses and interface hashes to their implementers
    mapping(address=>mapping(bytes32=>address)) internal _interfaces;
    /// @notice mapping from addresses to their manager
    mapping(address=>address) internal _managers;
    /// @notice flag for each address and erc165 interface to indicate if it is cached
    mapping(address=>mapping(bytes4=>bool)) internal _erc165Cached;

    
    constructor(
        //address[] memory managers,
        //address[] memory implementers,
    )public
        //ERC165()
        PausableAccessControl()
    {
        //require(
            //managers.length == implementers.length
            //''
        //);
        
        _setRoleAdmin(ROLE_ERC1820_ADMIN, ROLE_DEFAULT_ADMIN);
        //
        _setRoleAdmin(ROLE_MANAGER, ROLE_ERC1820_ADMIN);

        // deployer + self administration
        _setupRole(ROLE_ERC1820_ADMIN, _msgSender());
        _setupRole(ROLE_MANAGER, _msgSender());
        
        
        //for(uint i; i < managers.length; i++){
            //_setupRole(ROLE_MANAGER, managers[i]);
        //}
        
        //_setupRole(ROLE_ERC1820_ADMIN, _this);
        
        _registerInterface(type(iERC1820Implementer).interfaceId);
        _registerInterface(type(iERC1820Registry).interfaceId);
    }
    ///
    /// @return {address} the manager for `account`
    /// See {setManager}
    ///
    function _hasRoleManager(
        address account
    )internal view returns(
        address
    ){
        return hasRole(ROLE_MANAGER, account);
    }
    ///
    /// @return {address} the manager for `account`
    /// See {setManager}
    ///
    function _requireManager(
        address account
    )internal view
    {
        hasRole(ROLE_MANAGER, account).requireTrue(
            'role is not a manager'
        );
    }
    function _requireAdmin(
        address account
    )internal view
    {
        (hasRole(ROLE_DEFAULT_ADMIN, account) || 
            hasRole(ROLE_ERC1820_ADMIN, account)
        ).requireTrue(
            'role is not a admin'
        );
    }
    function _requireAdminOrManager(
        address account
    )internal view
    {
        (hasRole(ROLE_DEFAULT_ADMIN, account) || 
            hasRole(ROLE_ERC1820_ADMIN, account) ||
            hasRole(ROLE_MANAGER, account)
        ).requireTrue(
            'role is not an admin or manager'
        );
    }
    ///
    /// @dev Sets `newManager` as the manager for `account`. A manager of an
    /// account is able to set interface implementers for it.
    ///
    /// By default, each account is its own manager. Passing a value of `0x0` in
    /// `newManager` will reset the manager to this initial state.
    ///
    /// Emits a {ManagerChanged} event.
    ///
    /// Requirements:
    ///     - the caller must be the current manager for `account`
    ///
    function setManager(
        address account,
        address newManager
    )external virtual override
    {
        //account.emitSetManager(
            //newManager
        //);
        require(getManager(_addr) == msg.sender, "Not the manager");
        
        managers[_addr] = _newManager == _addr ? address(0) : _newManager;
        
        emit ManagerChanged(_addr, _newManager);
    }
    ///
    /// @return {address} the manager for `account`
    /// See {setManager}
    ///
    function getManager(
        address account
    )public view returns(
        address
    ){
        // By default the manager of an address is the same address
        if(managers[_addr] == address(0)){
            return _addr;
        }
        else{
            return managers[_addr];
        }
    }
    ///
    /// @dev Sets the `implementer` contract as ``account``'s implementer for `interfaceHash`
    ///
    /// `account` being the zero address is an alias for the caller's address.
    /// The zero address can also be used in `implementer` to remove an old one.
    ///
    /// See {interfaceHash} to learn how these are created.
    ///
    /// Emits an {InterfaceImplementerSet} event.
    ///
    /// Requirements:
    ///     - the caller must be the current manager for `account`.
    ///     - `interfaceHash` must not be an {iERC165} interface id (i.e. it must not end in 28 zeroes)
    ///     - `implementer` must implement {IERC1820Implementer} and return true when
    ///     queried for support, unless `implementer` is the caller.
    ///     See {iERC1820Implementer-canImplementInterfaceForAddress}.
    ///
    function setInterfaceImplementer(
        address account,
        bytes32 interfaceHash,
        address implementer
    )public virtual override
    {
        address addr = (account == address(0) ? _msgSender() : account);
        
        require(
            getManager(addr) == msg.sender(),
            "Not the manager"
        );

        require(
            !isERC165Interface(_interfaceHash),
            "Must not be an ERC165 hash"
        );
        
        if(implementer != address(0) && implementer != _msgSender()){
            require(
                iERC1820Implementer(_implementer).canImplementInterfaceForAddress(
                    interfaceHash,
                    addr
                ) == ERC1820_ACCEPT_MAGIC,
                "Does not implement the interface"
            );
        }
        
        interfaces[addr][interfaceHash] = implementer;
        
        emit InterfaceImplementerSet(
            addr,
            interfaceHash, 
            implementer
        );
    }
    ///
    /// @dev Returns the implementer of `interfaceHash` for `account`. If no such
    /// implementer is registered, returns the zero address.
    ///
    /// If `interfaceHash` is an {iERC165} interface id (i.e. it ends with 28 zeroes),
    ///`account` will be queried for support of it.
    /// `account` being the zero address is an alias for the caller's address.
    ///
    function getInterfaceImplementer(
        address account,
        bytes32 interfaceHash
    )external view virtual override returns(
        address
    ){
        address addr = _addr == address(0) ? msg.sender : _addr;
        
        if(isERC165Interface(interfaceHash)){
            bytes4 erc165InterfaceHash = bytes4(interfaceHash);
            
            return implementsERC165Interface(addr, erc165InterfaceHash) ? addr : address(0);
        }
        return interfaces[addr][_interfaceHash];
    }
    ///
    /// @return {bytes32} interface hash for an `interfaceName`, as defined in
    /// https://eips.ethereum.org/EIPS/eip-1820#interface-name[section of the EIP]
    ///
    function interfaceHash(
        string calldata interfaceName
    )public pure returns(
        bytes32
    ){
        return interfaceName.hash();
    }
    ///
    /// @notice Updates the cache with whether the contract implements an ERC165 interface or not.
    /// 
    /// @param account Address of the contract for which to update the cache.
    /// @param interfaceId ERC165 interface for which to update the cache.
    ///
    function updateERC165Cache(
        address account,
        bytes4 interfaceId
    )external
    {
        //_requireIsContract(account);
        
        _interfaces[account][interfaceId] = implementsERC165InterfaceNoCache(
            account,
            interfaceId
        ) ? account : address(0);
        
        _erc165Cached[account][interfaceId] = true;
    }
    ///
    ///  @notice Checks whether a contract implements an ERC165 interface or not.
    ///  If the result is not cached a direct lookup on the contract address is performed.
    ///  If the result is not cached or the cached value is out-of-date, the cache MUST be updated manually by calling
    ///  {updateERC165Cache} with the contract address.
    /// 
    ///  @param account Address of the contract to check.
    ///  @param interfaceId ERC165 interface to check.
    /// 
    ///  @return {bool} true if `account` implements `interfaceId`, otherwise false.
    ///
    function implementsERC165Interface(
        address account,
        bytes4 interfaceId
    )external view returns(
        bool ret
    ){
        ret = account.supportsInterface(interfaceId);
        
        if(!_erc165Cached[account][interfaceId]){
            return implementsERC165InterfaceNoCache(account, interfaceId);
        }
        return _interfaces[account][interfaceId] == account;
    }
    function _requireImplementsERC165Interface(
        address account,
        bytes4 interfaceId
    )internal view
    {
        //account.requireSupportsInterface(interfaceId);
    }
    ///
    /// @notice Checks whether a contract implements an ERC165 interface or not without using nor updating the cache.
    /// 
    /// @param account {address} of the contract to check.
    /// @param interfaceId {bytes4} ERC165 interface to check.
    /// 
    /// @return {bool} true if `account` implements `interfaceId`, otherwise false.
    ///
    function implementsERC165InterfaceNoCache(
        address account,
        bytes4 interfaceId
    )external view returns(
        bool
    ){
        return account.supportsInterface(interfaceId);
    }
}