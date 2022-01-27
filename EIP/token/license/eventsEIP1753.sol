// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

///Ethereum Improvments Proposal: Smart Contract Interface for Licences[sic]: https://eips.ethereum.org/EIPS/eip-1753
///
library eventsEIP1753
{
    event LicenseRenewalRequested(
        address owner,
        string licenseName,
        uint currentExpiration,
        uint timeRequested,
        uint blockRequested
    );
    event LicenseRenewed(
        address issuer,
        address owner,
        string licenseName,
        uint renewedExpirationTime,
        uint timeRenewed,
        uint blockRenewed
    );
    event LicensePurchased(
        address owner,
        string licenseName,
        uint timePurchased,
        uint blockAtPurchase
    );
    
    event LicenseIssued(
        address issuer,
        address owner,
        string licenseName,
        uint timeIssued,
        uint blockIssued
    );
    event LicenseRevoked(
        address issuer,
        address owner,
        string licenseName,
        uint timeRevoked,
        uint blockRevoked
    );
    event LicenseExpired(
        //address issuer,
        address owner,
        string licenseName,
        uint timeExpired,
        uint blockExpired
    );
    
    function emitLicenseRenewalRequested(
        address owner,
        string memory licenseName,
        uint licenseExpiration
    )public
    {
        emit LicenseRenewalRequested(
            owner,
            licenseName,
            licenseExpiration,
            block.timestamp,
            block.number
        );
    }
    function emitLicenseRenewed(
        address sender,
        address owner,
        string memory licenseName,
        uint renewedExpirationTime
    )internal
    {
        emit LicenseRenewed(
            sender,
            owner,
            licenseName,
            renewedExpirationTime,
            block.timestamp,
            block.number
        );
    }
    /**
    function emitLicenseRenewed(
        address owner,
        string memory licenseName
        //uint renewedExpirationTime
    )public
    {
        emit PurchasedRenewed(
            owner,
            licenseName,
            now,
            block.number
        );
    }
    */
    function emitLicenseIssued(
        address sender,
        address owner,
        string memory licenseName
    )public
    {
        emit LicenseIssued(
            sender,
            owner,
            licenseName,
            block.timestamp,
            block.number
        );
    }
    function emitLicenseRevoked(
        address sender,
        address owner,
        string memory licenseName
    )internal
    {
        emit LicenseRevoked(
            sender,
            owner,
            licenseName,
            block.timestamp,
            block.number
        );
    }
    function emitLicenseExpired(
        address owner,
        string memory licenseName,
        uint timeExpired,
        uint blockExpired
    )internal
    {
        emit LicenseExpired(
            //msg.sender,
            owner,
            licenseName,
            timeExpired,
            blockExpired
        );
    }
}

library eventsEIP1753AccessControl
{
    event GrantLicenseAuthority(
        address admin,
        address account,
        uint time,
        uint block
    );
    event RevokeLicenseAuthority(
        address admin,
        address account,
        uint time,
        uint block
    );
    
    function emitGrantLicenseAuthority(
        address issuer,
        address account
    )public
    {
        emit GrantLicenseAuthority(
            issuer,
            account,
            block.timestamp,
            block.number
        );
    }
    function emitRevokeLicenseAuthority(
        address revoker,
        address account
    )internal
    {
        emit RevokeLicenseAuthority(
            revoker,
            account,
            block.timestamp,
            block.number
        );
    }
}