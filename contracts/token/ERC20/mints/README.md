----------------------------------------------------------------

# Copyright © Tyler R. Drury (vigilance.eth) 03-01-2021, All Rights Reserved

----------------------------------------------------------------

# [Solidarity][1]™ ERC20 Token Mints Directory

**Solidarity™ [\\contracts\\token\\ERC20\\mints][2]** contains fully realized,
concrete [ERC20 compliant][3] Mint contracts capable of safely transfering tokens,
without permanently losing them if accidentally transfered to a contract which
does **not** support and implement iERC20Receiver, iERC20Transactor or other similar contracts
which facilitate the transfer of tokens from and/or to itself or other smart contracts.

These contracts **should** be safe for use in development (although live testing still needs to be done).

These contracts cover the most ubiquitous use cases of ERC20 Tokens common today and include:

* SafeERC20Mint - generic uncapped Token Mint, capabled of being paused and supports minting and burning by permissioned addresses (similar to Ethereum being an uncapped token)
* SafeERC20MutableCapMint - Token Mint with a dynamic (mutable) supply cap capabled of being paused and supports minting and burning by permissioned addresses, as well as explicitly increasing or decreasing the supply cap as desired (similar to a real world Mint)
* SafeERC20StaticCapMint - Token Mint with a static (constant) supply cap, which **never** changes after deployment, capabled of being paused and supports minting and burning by permissioned addresses, with the condition the total supply can never exceed the supply cap (similar to Bitcoin, which has a static supply cap which will never change but also has a minable supply which gradually increases until the cap is reached)
* SafeERC20StaticSupplyToken - An ERC20 Token with both a static cap and static supply (which are the same value) which are not modifiable after contract deployment, not technically a Mint, since the supply never changes (due to not supporting minting or burning), but it iherits from the same Abstracts Base Contracts (ABC) as the other mints in this directory (contract owner is given the entire initial supply upon deployment, to be later exchanged or redistirbuted, such when the government prints a set amount of ballots for an election based on a set list of registered voters)


----------------------------------------------------------------

## Getting Started

Each [Vigilance project][7] is designed to be stand alone,
built with no (or preferably minimal) external dependencies.

Each project is unique, so make sure to review the README.md and LICENSE.md of each project before use or installation,
to ensure your system and the project features meet the desired requirements.

This project's only dependancies are [solidarity™][1] itself, which also includes [OpenZeppelin][4] contracts.

Developers can download the project from the project's [Github repository][1],
which is also available for easy testing using Remix.

Once the repository has been downloaded or the desired contracts have imported into a Remix project,
the contracts in this directory can be immediately utilized by declaring a child contract which inherits from the mint with the desired behaviour as follows:

```
contract UncappedMint is SafeERC20Mint
{
    constructor(
    )public SafeERC20StaticCapMint(
        'Uncapped Mint V1',
        'UM'
    ){
    }
}
contract SCMint is SafeERC20StaticCapMint
{
    constructor(
    )public SafeERC20StaticCapMint(
        'Static Cap Mint V1',
        'SCM',
        0,
        1e18
    ){
    }
}

contract StaticSupplyToken is SafeERC20StaticSupplyToken
{
    constructor(
    )public SafeERC20StaticSupplyToken(
        'Static Supply Token V1',
        'SST',
        1e18
    ){
    }
}

contract MCMint is SafeERC20MutableCapMint
{
    constructor(
    )public SafeERC20MutableCapMint(
        'Mutable Cap Mint V1',
        'MCTM',
        0,
        1e18
    ){
        
    }
}
```

Token Identifier, token symbol, initial supply and supply cap can all be specified as desired by the deveolper
and **must** be supplied

**Note**: Token Supply can not exceed the supply cap and will revert if initial supply is grearter than the supply cap when the contract is deployed

These contracts can also be derived from inorder to add extra functionallity not supported by default.


----------------------------------------------------------------

## License

[Solidarity][1]™ is released under the Apache-2.0 License.

See [LICENSE](https://github.com/vigilance91/solidarity/LICENSE.md) file for more details.


----------------------------------------------------------------

## Links

The online API reference is available [here]().

Support our work on [Gitcoin][6] or help contribute to the community.

Authors and contributors are listed in [AUTHORS](https://github.com/vigilance91/solidarity/AUTHORS.md).


[1]: https://github.com/vigilance91/solidarity
[2]: https://github.com/vigilance91/solidarity/tree/master/contracts/token/ERC20/mints
[3]: https://github.com/vigilance91/solidarity/tree/master/contracts/ERC/token/ERC20
[4]: https://openzeppelin.com
[5]: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts
[6]: https://gitcoin.com
[7]: https://github.com/vigilance91
[8]: https://github.com/vigilance91/solidarity/EIP
[9]: https://github.com/vigilance91/solidarity/ERC
[10]: https://github.com/vigilance91/solidarity/contracts


