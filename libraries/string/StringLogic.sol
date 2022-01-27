// SPDX-License-Identifier: Apache-2.0

pragma solidity >=0.6.4 <0.8.0;
pragma experimental ABIEncoderV2;

import "https://github.com/vigilance91/solidarity/libraries/bytes32/Bytes32Logic.sol";
//import "https://github.com/vigilance91/solidarity/libraries/libraries/stringUtils.sol";
/// 
/// @title String Logic Library
/// @author Tyler R. Drury <vigilstudios.td@gmail.com> (www.twitter.com/StudiosVigil) - copyright 3/1/2021, All Rights Reserved
/// @notice trivial functions for logical operations on strings not provided natively by Solidity.
/// @dev The official Ethereum StringUtils library (found here https://github.com/ethereum/dapp-bin/blob/master/library/stringUtils.sol) is vulnerable to timing attacks!
/// it is NOT recommend for use, ever, for any reason
/// 
/// This library, on the otherhand, is NOT vulnerable to timing attacks and thus,
/// is recommended as an alternative as it is designed and intended for use in cryptographically secure applications
///
library stringLogic
{
    //using Bytes32Logic for bytes32;
    //using stringUtils for string;
    
    //string private constant _NAME = " stringLogic: ";
    //
    //bytes1 private constant _80 = 0x80;  //> 128 range characters (uft-8 characters above ascii DEL)
    //bytes1 private constant _E0 = 0xE0;  //> 224 range characters (3 bytes)
    //bytes1 private constant _F0 = 0xF0;  //> 240 range characters (4 bytes)
    //bytes1 private constant _F8 = 0xF8;  //> 248 range characters (5 bytes)
    //bytes1 private constant _FC = 0xFC;  //> 252 range characters (6 bytes)
    //
    /*
    //note: in uft-8 and ascii, anything  < 0x20 is non-humanreadbale whitespace characters
    //string private constant _SPACE = string(0x20);
    //
    //utf-8 multi-bytes whitespace characters, reference:
    //  https://stackoverflow.com/questions/2227921/simplest-way-to-get-a-complete-list-of-all-the-utf-8-whitespace-characters-in-ph#2228012
    //
    string private constant _NO_BREAK_SPACE = "\xC2\xA0";
    
    string private constant _LINE_SEPARATOR = "\x20\x28";
    string private constant _PARAGRAPH_BOUNDARY = "\x20\x29";
    //
    string private constant _OGHAM_SPACE_MARK = \xE1\x9A\x80;
    string private constant _EN_QUAD = "\xE2\x80\x80";    //"\xe2\x80\x80";
    string private constant _EM_QUAD = "\xE2\x80\x81";
    string private constant _EN_SPACE = "\xE2\x80\x82";
    string private constant _EM_SPACE = "\xE2\x80\x83";
    string private constant _THREE_PER_EM_SPACE = "\xE2\x80\x84";
    string private constant _FOUR_PER_EM_SPACE = "\xE2\x80\x85";
    string private constant _SIX_PER_EM_SPACE = "\xE2\x80\x86";
    string private constant _FIGURE_SPACE = "\xE2\x80\x87";
    string private constant _PUNCTUATION_SPACE = "\xE2\x80\x88";
    string private constant _THIN_SPACE = "\x0E2\x80\x89";
    string private constant _HAIR_SPACE = "\xE2\x80\x8A";
    string private constant _ZERO_WIDTH_SPACE = "\xE2\x80\x8B";
    string private constant _NARROW_NO_BREAK_SPACE = "\xE2\x80\xAF";
    string private constant _MEDIUM_MATHEMATICAL_SPACE = "\xE2\x81\x9F";
    string private constant _IDEOGRAPHIC_SPACE = "\xE3\x80\x80";
    */
    string internal constant EMPTY = "";
    
    bytes32 internal constant EMPTY_HASH = keccak256(bytes(""));  //''.hash();
    /**
     * compare string hashes using XOR, rather than iteratively compare each element in strings
     * not only is this appraoch generally faster for larger strings but is also NOT vulnerable to timing attacks
     * and is not dependant upon the length of the strings being compared since bitwise ^ is a single asm instruction
     * and hashing algorithms are relatively fast and computationally efficient!
    */
    /**
    modifier _notEmpty(
        string memory lhs,
        string memory rhs
    )internal
    {
        logicConstraints.requireTrue(
            notEmpty(lhs) && notEmpty(rhs)
            'empty' //_NAME.concatenate('empty')
        );
        _;
    }
    */
    function equal(
        string memory lhs,
        string memory rhs
    )internal pure returns(
        bool
    ){
        //return lhs.hash().equal(
            //rhs.hash()
        //);
        
        return Bytes32Logic.equal(
            keccak256(bytes(lhs)),
            keccak256(bytes(rhs))
        );
    }
    
    function notEqual(
        string memory lhs,
        string memory rhs
    )internal pure returns(
        bool
    ){
        //return lhs.hash().notEqual(
            //rhs.hash()
        //);
        return Bytes32Logic.notEqual(
            keccak256(bytes(lhs)),
            keccak256(bytes(rhs))
        );
    }
    //
    //@returns {bool} true if string `s` contains only whitespace
    //function isWhitespace(
        //string memory s
    //)internal pure returns(
        //bool
    //){
    //}
    //
    //@returns {bool} true upon the first instance of a whitespace character in string `s`,
    //if no whitespace is encountered returns false
    //
    //function containsWhitespace(
        //string memory s
    //)internal pure returns(
        //bool
    //){
    //}
    
    function empty(
        string memory lhs
    )internal pure returns(
        bool
    ){
        //return lhs.hash().equal(EMPTY_HASH);
        return Bytes32Logic.equal(
            keccak256(bytes(lhs)),
            EMPTY_HASH
        );
    }
    
    function notEmpty(
        string memory lhs
    )internal pure returns(
        bool
    ){
        //return lhs.hash().notEqual(EMPTY_HASH);
        
        return Bytes32Logic.notEqual(
            keccak256(bytes(lhs)),
            EMPTY_HASH
        );
    }
    
    function notEmptyAndNotEqual(
        string memory lhs,
        string memory rhs
    )internal pure returns(
        bool
    ) //_notEmpty(lhs,rhs)
    {
        return notEmpty(
            lhs
        ) && notEmpty(
            rhs
        ) && notEqual(lhs,rhs);
    }
    
    function notEmptyAndAreEqual(
        string memory lhs,
        string memory rhs
    )internal pure returns(
        bool
    ) //_notEmpty(lhs,rhs)
    {
        return notEmpty(
            lhs
        ) && notEmpty(
            rhs
        ) && equal(lhs,rhs);
    }
    /**
     * lhs and rhs MUST be the same length otherwise revert
    //function xor(
        //string memory lhs,
        //string memory rhs
    //)internal returns(
        string memory
    //) _notEmpty(lhs,rhs)
    //{
        //bytes lb = bytes(lhs);
        //bytes rb = bytes(rhs);
        
        //lb.requireLengthEqual(rb);
        
        //return string(lb ^ rb);
    //}
    //function and(
        //string memory lhs,
        //string memory rhs
    //)internal returns(
        string memory
    //) _notEmpty(lhs,rhs)
    //{
        //bytes lb = bytes(lhs);
        //bytes rb = bytes(rhs);
        
        //lb.requireLengthEqual(rb);
        
        //return string(lb & rb);
    //}
    //function or(
        //string memory lhs,
        //string memory rhs
    //)internal returns(
        //string memory
    //) _notEmpty(lhs,rhs)
    //{
        //bytes lb = bytes(lhs);
        //bytes rb = bytes(rhs);
        
        //lb.requireLengthEqual(rb);
        
        //return string(bytes(lb) | bytes(rb));
    //}
    //function not(
        //string memory self
    //)internal returns(
        string memory
    ){
        notEmpty(self);
        
        //return string(!bytes(self));
    //}
    */   
}