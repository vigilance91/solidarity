// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;
///
/// 0xF* Off-Chain, for off-chain actions
/// Much like th 0x0*: Generic range, 0xF* is very general, and does little to modify the reason.
/// Among other things, the meta code 0xFF may be used to describe what the off-chain process is
///
library offchainCodes
{
    string internal constant OFF_CHAIN_FAILURE = "0xF0";
    string internal constant OFF_CHAIN_SUCCESS = "0xF1";
    string internal constant AWAITING_OFF_CHAIN_PROCESS = "0xF2";
    string internal constant OFF_CHAIN_PROCESS_STRATED = "0xF3";
    string internal constant OFF_CHAIN_SERVICE_UNREACHABLE = "0xF4";
    string internal constant OFF_CHAIN_ACTION_REQUIRED = "0xF5";
    string internal constant OFF_CHAIN_TIMEOUT_REACHED = "0xF6";
    //string internal constant [reserved] = "0xF7";
    string internal constant DUPLICATE_OFF_CHAIN_REQUEST = "0xF8";
    //string internal constant [reserved] = "0xF9";
    //string internal constant [reserved] = "0xFA";
    //string internal constant [reserved] = "0xFB";
    //string internal constant [reserved] = "0xFC";
    //string internal constant [reserved] = "0xFD";
    //string internal constant [reserved] = "0xFE";
    string internal constant METADATA = "0xFF";
}
/**
library FinanceError
{
    string internal constant INSUFFICIENT_FUNDS = "101{ISF}";
    //use when manually pre-checking if an account does NOT has enough gas to execute a transaction
    string internal constant INSUFFICIENT_GAS = "102{ISG}";
    string internal constant INSUFFICIENT_ALLOWANCE = "103{ISA}";
    string internal constant PAYMENT_REQUIRED = "104{PAYREQ}";
    //similar to HTTP 500 (forbidden) error, such as restricting access based on geography,
    //or laws specific to various international jurisidictions,
    //such as where cryptocurrencies are illegal
    string internal constant ACCESS_FORBIDDEN = "500{FORBIDDEN}";
}

///
///Invalid Addresses
///
library AddressError
{
    //use this if an account tries to transact with the null address, itself or with a contract which does not supoort receive() or fallback()
    string internal constant IS_NULL = "301{AIN}";
    string internal constant IS_NOT_NULL = "302{AINN}";
    //use this if an account tries to withdraw an allowance from the null address, itself or with a contract which does not supoort receive() or fallback()
    string internal constant INVALID_RECIPIENT = "303{IRA}";
    string internal constant INVALID_FROM = "304{AIF}";
}
///
///Strings
///
//library StringError
//{
    //string internal constant EMPTY = "301{ESTR}";
    //string internal constant INVALID_SECRET = "303{IVS}";
//}
///
///AccessControl
///
//library PermissionsError
//{
    //for when an AccessControl or Ownable or other such role based permissions are denied to a registered account
    //400, bad request due to invalid client data
    //string internal constant INVALID_PERMISSIONS = "400{IVP}";
    //caller is not a client of this platform and does not have rights to access its functionality,
    //similar to IVP except this is the default state, when non-registered account,
    //by default are not clients and must undergo a registration process first
    //401 unauthorized, use when authentication fails
    //string internal constant IS_NOT_CLIENT = "401{INC}";
    //HTTP 404 resouce not found, for when fallback() can not resolve an external call,
    //or a contract has been killed and no longer exists/is "alive" in a functioning state
    //string internal constant ACCESS_NOT_FOUND = "404{NF}";
    //useful when a function is deleted or proxying is not enabled
    //string internal constant METHOD_NOT_ALLOWED = "405{MNA}";
//}
*/