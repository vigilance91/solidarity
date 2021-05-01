----------------------------------------------------------------

# Copyright © Tyler R. Drury 03-01-2021, All Rights Reserved

----------------------------------------------------------------

# [Solidarity][1]™

**Solidarity™** contains common solidity (.sol) files, including

* contracts
* interfaces
* libraries

which are commonly used in developing smart contracts or decentralized applications.

These include:


### [solidarity/libraries/][7]

Convenience libraries for use with built-in data types to extend their functionality,
usable in almost every project.

This directory generally contains code for:

* Logic - convenience libraries for logical operations for operators such as ==, !=, >, <, >=, <=
* Math - arithmetic and/or bitwise operation libraries for overloads, +, -, *, \/, %, etc, of various data types with appropriate sanity checks, usually based on Logic
* Constraints - libraries which constrains the state of the EVM based on various conditions, such as those defined in Logic or Math libraries
* utils - utility functions which do not fit into any of the previous categories


### [solidarity/EIP/][8]

Ethereum Improvement Proposals, contracts for EIPs currently in the final or draft phase,
under discussion and on track for adoption as a standard ERC including:

* EIP-1066 Status Codes
* EIP-801 Canaray
* EIP-2135 Consumable
* EIP-2535 Diamond
* etc

### [solidarity/ERC/][9]

Standardized ERC (Ethereum Request for Comments) contracts, including:

* ERC-165 Interface Support
* ERC-173 Ownership
* ERC-1820 Interface Registry contract
* ERC-926 Address Metadata Registry
* ERC-20 Fungible Token Standard
* ERC-721 Non-Fungible Token Standard
* ERC-1155 Fungible/Non-Fungible Token Standard

### [solidarity/contracts/][10]

Solidarity specific implementations of Common Abstract Base Contracts (ABCs) and fully realized smart contracts,
which commonly use libraries from */libraries* and implement or extend appropriate interfaces,
for easy use during development, such as:

* token - implementations for ERC Standard (and some non-standard extensions) Token contracts, including Fixed or Dynamic SUpply ERC20 tokens, ERC-721 Tokens and ERC-11155 tokens
* accessControl - implementations for various permissions based contracts, including assignable roles
* finance - performaing financial transactions, such as deposit, withdraw and transaction between addresses
* presets - Ready to use standardized Token Mints
* democracy - decentralized democratization
* proxy - proxies of other contracts
* etc


### /contracts/finance/

Common contracts related to financial operations

* SafePayable.sol - trivial contract for safely performing payment operations
* Compound.sol - library for calculating compound interest


### /contracts/presets/

Fully realized contracts derived from 's Token Mint types (including ERC20, ERC721, ERC777 and ERC1155), which also inherit from the Gas Station Network (reducing overall gas expenditures of transaction execution)


### /contracts/token/

ERC compliant Token StandardsStand alone contracts deriving from [OpenZeppelin][4]'s payment classes for fully realized uni-directional,
bi-directional and other payment channel types,
which support escrow behaviour and other similar functionality,
directed and facilitating the exchange of value or assets between a producer and consumer(s)


### /contracts/democracy/

Common use cases for secure voting mechanisms (including delegation),
which are implemented on the Vigilance Network for decentralized governance of the project and establishing
new resolutions, partners or for funding new projects,
including general voting mechanism which require VNT to be consumed,
where voting weight per user is based on the VNT supplied by each user (where all non-equity holding participants in the network may contribute) or,
NFT voting for equity holders regarding corporate policies/decisions,
where 1 token repressents 1 vote and users can supply multiple NFT to express their voting rights (which are NOT consumed but refunded upon completion of voting)


### /contracts/proxy/

Deriving from [OpenZeppelin][4]'s Proxy contracts,
these are specialized contracts for proxying other [Solidarity][1]™ contracts,
such as:

* ICO/CrowdFunding contracts
* Tokens and Mints

as well as other common contracts, to be used in composition with eachother,
to form other more robust smart constracts, with minimal gas consumption
and with the goal to allow dynamically upgradeable contracts while also further reducing overall contract size overhead,
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
from the project's Github repository, available [here][5], for easy testing using Remix.


----------------------------------------------------------------

## Getting the Official Project

The most recent, stable release of this project is available for download via [NPM][] or,
developers wishing to contribute may access the [GitHub repo][1].

We also have a [gitcoin tribe][6] for devlopers who want to keep upto date
and participate in the open-source community.


----------------------------------------------------------------

## License

[Solidarity][1]™ is released under the Apache-2.0 License.

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
[7]: https://github.com/vigilance91/solidarity/libraries
[8]: https://github.com/vigilance91/solidarity/EIP
[9]: https://github.com/vigilance91/solidarity/ERC
[10]: https://github.com/vigilance91/solidarity/contracts


