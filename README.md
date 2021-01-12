----------------------------------------------------------------

# Copyright (C) Tyler R. Drury 01-10-2021, All Rights Reserved

----------------------------------------------------------------

# [Solidarity]()

**Solidarity** contains common solidity (.sol) files, including contracts, interfaces and libraries,
commonly used in developing smart contracts or decentralized applications,
including:


### /core/

Fundemental libraries, useful for almost any project

* Core.sol - core constraints
* Units.sol - library for common units and their conversions
* SafeTransaction.sol - Extending OpenZEppelin's SafeMath by adding functions specifically for performing basic financial transactions (with sanity checks) such as for making deposits or withdraw to/from accounts
* Compound.sol - library for calculating compound interest
* AddressConstraints.sol - address utilities library for verifying address variables using requrie, such as if the address is null or equal to other addresses
* StringConstraints.sol - string utilities library for verifying string variables using requrie
* StringUtilities.sol - string utilities library for common string operations, such as concatenation and
* BytesConstraints.sol - string utilities library for verifying string variables using requrie
* BytesUtilities.sol - bytes utilities library for various logical operations, such as masking
* Exists - abstract base contract for verifying contract state and other related functions such as safely destroy a contract using selfdestruct, which almost every other contract should derive from


### /secrets/

Secure structures, libraries and contracts for storing secure secrets

* HashedSecretMap - a library for common operations performed on mapping of bytes32 hashes to Secrets
* AddressSecretMap - a library for common operations performed on mapping of addresses to Secrets, for holding private account information
* OwnableSecrets - a base contract which contains a HashedSecretMap for holding secrets for the owner and/or administrators of a contract, with and AddressSecretMap for holding registered user secrets
* ExternalOwnableSecrets - fully realized external interface for OwnableSecretsMap contract, can be used directly in projects source or proxied (using OwnableSecretsProxy) from this address 0x0000, on the mainnet, 0x0000 on the Ropsten test network or 0x0000 on the __ test network


### /mints/

Fully realized contracts derived from OpenZeppelin's Token Mint types (including ERC20, ERC721, ERC777 and ERC1155), which also inherit from the Gas Station Network (reducing overall gas expenditures of transaction execution)


### /payment/

Stand alone contracts deriving from OpenZeppelin's payment classes for fully realized uni-directional, bi-directional and other payment channel types,
which support escrow behaviour and other similar functionality,
directed and facilitating the exchange of value or assets between a producer and consumer(s)


### /auction/

Extending payment and secrets contracts for fully realized, secure Auctions and Auction Houses,
where users can freely exchange assets using various auction style contracts,
without the need for an external 3rd-party exchange, such as binance or coinbase


### /vote/

Common use cases for secure voting mechanisms,
which are implimented on the Vigilance Network for decentralized governance of the project and establishing new resolutions, partners or for funding new projects,
including general voting mechanism which require VNT to be consumed,
where voting weight per user is based on the VNT supplied by each user (where all non-equity holding participants in the network may contribute) or,
NFT voting for equity holders regarding corporate policies/decisions,
where 1 token repressents 1 vote and users can supply multiple NFT to express their voting rights (which are NOT consumed but refended up completion of voting)


### /proxy/

Deriving from OpenZeppelin's Proxy contracts,
these are specialized contracts for proxying other solidarity contracts,
such as ICO/CrowdFunding contracts, Secrets, Token Mints and other common contracts.


### /TBD/

Additional projects to come.


----------------------------------------------------------------

## Getting Started

This project has the following directories structure

* **/_output** - directory for logging console output and errors durring exection of tools
* **/src** - directory with all working source code and migrations
* **/tests** - javascript unit test directory, for use with runnning unit tests via truffle command line OR on a geth node
* **/docs** - html documentation directory used by Doxygen for output
* **/latex** - latex documenation directory, for use by Doxygen for output
* **/README.md** - project readme
* **/.gitignore** - file specifying which files and directory patterns not to include when pushing commits t github repo
* **/Doxyfile** - doxygen project configuration file
* **/build.bat** - utility batch script for building this project on Windows using truffle and other related tools (such as linting or minimization tools)
* **/composer.json** - composer configuration file for packaged project to be distributed via [Packagist]()
* **/package.json** - nodeJS configuration file for packaged project dependancies, for distribution via [NPM]()


Directories prefixed with an underscore (_) are private, developer **only** directories,
not included in the production build and should **not** be accessible or included in repos or final product

In unit testing directories, there is no build.bat,
replaced instead with a test.bat, for executing the unit test suites via truffle command line (requires a locally running node and private blockchain to test, recommended using Ganache)


----------------------------------------------------------------

## Getting Started

Each VS project is designed to be stand alone,
built with no (or preferably minimal) external dependencies.

Each prject is unique so make sure to review the README.md and LICENSE.md of each project before installation,
to ensure your system and the project features meet the desired needs

All projects are contained within the meta PHAR project vs_vs56_0_1_1.phar


----------------------------------------------------------------

## Getting the Official Project

The most recent, stable release of this project is available via [NPM][] or,
developers wishing to contribute may access the [GitHub][] repo


----------------------------------------------------------------

## License

Solidarity is released under the Apache 2.0 License, typical of all vigilance products.

See [LICENSE][7] file for more details.


----------------------------------------------------------------

## Links

The online API reference is available [here]().

Authors and contributors are listed in [AUTHORS][8].


[1]: https://
[2]: https://
[3]: https://
[4]: https://
[5]: https://
[6]: https://
[7]: https://
[8]: https://

