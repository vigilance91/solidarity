----------------------------------------------------------------

# Copyright © Tyler R. Drury (vigilance.eth) 03-01-2021, All Rights Reserved

----------------------------------------------------------------

# [Solidarity][1]™ Contracts Access Control 

**Solidarity™ [\\contracts\\accessControl][4]** contains contracts and frameworks capable of
either granting, restricting or verifying access to the inheriting contract based on arbitrary, user defined roles.

Common contracts include

[accessControl][4]

[accessControl\\pausable][5]

* Pausable - a contract which allows paused on unpaused of processing transactions
* AccessControlABC - Abstract base contract for all Access Control derivatives
* PausableAccessControlABC - Abstract base contract with both pausable and accessControl functionality


[accessControl\\whitelist][6]

* WhitelistABC - Abstract base contract for generic Whitelsts
* Whitelist - Fully realized Whitelists contract


[accessControl\\blacklist][7]

* BlacklistABC - Abstract base contract for generic Blacklists
* Blacklist - Fully realized Blacklists contract


[accessControl\\greylist][8]

* GreylistABC - Abstract base contract for singular functionality of both a whitelist and a blacklist
* Greylist - Fully realized contract which supports functionality of both and Whitelist and Blacklist


[accessControl\\receiver][9]

* SafeAccessControlReceiverConstraintsABC - Abstract base constraints contract for safely assigning access control roles (must be either an EOA or iAccessControlReceiver implimenting contract)


[accessControl\\token][10]

* PausableAccessControlERC20 - Pausable Access Controled ERC-20 contract
* PausableAccessControlERC721 - Pausable Access Controled ERC-721 contract
* PausableAccessControlERC1155 - Pausable Access Controled ERC-1155 contract


----------------------------------------------------------------

## License

[Solidarity][1]™ is released under the Apache-2.0 License.

See [LICENSE][2] file for more details.


----------------------------------------------------------------

## Links

The online API reference is available [here]().

Support our work on [Gitcoin][8] or help contribute to the community.

Authors and contributors are listed in [AUTHORS][3].


[1]: https://github.com/vigilance91/solidarity
[2]: https://github.com/vigilance91/solidarity/LICENSE.md
[3]: https://github.com/vigilance91/solidarity/AUTHORS.md
[4]: https://github.com/vigilance91/solidarity/tree/master/contracts/accessControl
[5]: https://github.com/vigilance91/solidarity/tree/master/contracts/accessControl/pausable
[6]: https://github.com/vigilance91/solidarity/tree/master/contracts/accessControl/whitelist
[7]: https://github.com/vigilance91/solidarity/tree/master/contracts/accessControl/blacklist
[8]: https://github.com/vigilance91/solidarity/tree/master/contracts/accessControl/greylist
[9]: https://github.com/vigilance91/solidarity/tree/master/contracts/accessControl/receiver
[10]: https://github.com/vigilance91/solidarity/tree/master/contracts/accessControl/token
[11]: https://gitcoin.com
[12]: https://github.com/vigilance91

