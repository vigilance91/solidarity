----------------------------------------------------------------

# Copyright (C) Tyler R. Drury 03-01-2021, All Rights Reserved

----------------------------------------------------------------

# [Solidarity][1]

**Solidarity** contains common solidity (.sol) files, including

* contracts
* interfaces
* libraries

which are commonly used in developing smart contracts or decentralized applications.

These include:


### /core/

Fundemental libraries, useful for almost any project

* Core.sol - core constraints
* Exists - abstract base contract for verifying contract state and other related functions such as safely destroy a contract using selfdestruct, which almost every other contract should derive from


### /constraints/

Common utilitiy libraries consisting of wrappers around Solidity's require statement,
used for reducing gas costs and also constraining the state of the EVM,
such as ensuring values are within expected ranges or to ensure
an operation has a desired affect.

* LogicConstraints - library for trivial boolean require statements, usable by almost any project that uses require
* UnitConstraints - constrain values of wei to be within an arbitrary range or a specific denomination
* AddressConstraints.sol - address utilities library for verifying address values using requrie, such as if the address is null or equal to other addresses
* StringConstraints.sol - string utilities library for verifying string values using requrie
* BytesConstraints.sol - bytes32 utilities library for verifying bytes32 values using requrie
* uint256Constraints.sol - uint256 utilities library for verifying uint256 values using requrie
* int256Constraints.sol - int256 utilities library for verifying int256 values using requrie


### /utils/

Common utilitiy libraries, useful for almost any project

* Units.sol - library for common units and their conversions
* StringUtilities.sol - string utilities library for common string operations, such as concatenation and
* BytesUtilities.sol - bytes utilities library for various logical operations, such as masking


### /finance/

Common operations related to finance,
include Safe Transactions and calculating compound interest

* SafeTransaction.sol - Extending [OpenZeppelin][4]'s SafeMath by adding functions specifically for performing basic financial transactions (with sanity checks) such as for making deposits or withdraw to/from accounts
* SafePayable.sol - trivial contract for safely performing payment operations
* Compound.sol - library for calculating compound interest
* iCompoundInterest.sol - external interface for a contract with implements calculating compound interest based on Compound.sol


### /secrets/

structures, libraries and contracts for storing secure secrets

* HashedSecretMap - a library for common operations performed on mapping of bytes32 hashes to Secrets
* AddressSecretMap - a library for common operations performed on mapping of addresses to Secrets, for holding private account information
* OwnableSecrets - a base contract which contains a HashedSecretMap for holding secrets for the owner and/or administrators of a contract, with and AddressSecretMap for holding registered user secrets
* ExternalOwnableSecrets - fully realized external interface for OwnableSecretsMap contract, can be used directly in projects source or proxied (using OwnableSecretsProxy) from this address 0x0000, on the mainnet, 0x0000 on the Ropsten test network or 0x0000 on the __ test network


### /mints/

Fully realized contracts derived from [OpenZeppelin][4]'s Token Mint types (including ERC20, ERC721, ERC777 and ERC1155), which also inherit from the Gas Station Network (reducing overall gas expenditures of transaction execution)


### /payment/

Stand alone contracts deriving from [OpenZeppelin][4]'s payment classes for fully realized uni-directional, bi-directional and other payment channel types,
which support escrow behaviour and other similar functionality,
directed and facilitating the exchange of value or assets between a producer and consumer(s)


### /auction/

Extending payment and secrets contracts for fully realized, secure Auctions and Auction Houses,
where users can freely exchange assets using various auction style contracts,
without the need for an external 3rd-party exchange, such as binance or coinbase


### /vote/

Common use cases for secure voting mechanisms (including delegation),
which are implemented on the Vigilance Network for decentralized governance of the project and establishing
new resolutions, partners or for funding new projects,
including general voting mechanism which require VNT to be consumed,
where voting weight per user is based on the VNT supplied by each user (where all non-equity holding participants in the network may contribute) or,
NFT voting for equity holders regarding corporate policies/decisions,
where 1 token repressents 1 vote and users can supply multiple NFT to express their voting rights (which are NOT consumed but refunded upon completion of voting)


### /proxy/

Deriving from [OpenZeppelin][4]'s Proxy contracts,
these are specialized contracts for proxying other [Solidarity][1] contracts,
such as:

* ICO/CrowdFunding contracts
* Secrets
* Token Mints

as well as other common contracts, to be used in composition with eachother,
to form other more robust smart constracts, with minimal gas consumption
and with the goal to allow dynamically upgradeable contracts while also reduce contract size overhead,
allowing for larger, more complex contracts.


### /TBD/

Additional projects to come.


----------------------------------------------------------------

## Before Starting

Either use the Remix.com IDE for rapid prototyping and testing or
Download and install:

* [Ganache]() - a local testnetwork for developing using a private blockchain
* [Geth]() - a local Ethereum node, for use with Ganache
* [Truffle]() - application for easily compiling, deploying and testing blockchain applications

If unfamiliar with these tools, a full, indepth tutorial
can be found on the official VS developer's site [here][3].

Once ready to go, either clone the repository (or install the most recent stable version via NPM) if developing locally,
or simply import the code directly from the repository, if using Remix.

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
replaced instead with a test.bat, for executing the
unit test suites via Truffle command line,
which requires a locally running node and private blockchain to test (using Ganache is recommended)


----------------------------------------------------------------

## Getting Started

Each [VS project][2] is designed to be stand alone,
built with no (or preferably minimal) external dependencies.

Each project is unique, so make sure to review the README.md and LICENSE.md of each project before use or installation,
to ensure your system and the project features meet the desired requirements.

This project's only dependancy is [OpenZeppelin][4] and is imported externally
from the project's Github repository, available [here][5].


----------------------------------------------------------------

## Getting the Official Project

The most recent, stable release of this project is available via [NPM][] or,
developers wishing to contribute may access the [GitHub repo][1].

We also have a [gitcoin tribe][6] for devlopers who want to keep upto date
and participate in the open-source community.


----------------------------------------------------------------

## License

Solidarity is released under the Apache 2.0 License.

See [LICENSE](https://github.com/vigilance91/solidarity/LICENSE.md) file for more details.


----------------------------------------------------------------

## Links

The online API reference is available [here]().

Authors and contributors are listed in [AUTHORS](https://github.com/vigilance91/solidarity/AUTHORS.md).


[1]: https://github.com/vigilance91/solidarity
[2]: https://github.com/vigilance91
[3]: https://
[4]: https://openzeppelin.com
[5]: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts
[6]: https://gitcoin.com
[7]: https://

