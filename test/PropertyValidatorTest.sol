// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BitVectorPropertyValidator.sol";
import "../src/PackedListPropertyValidator.sol";

contract PropertyValidatorTest is Test {
    BitVectorPropertyValidator bitVecValidator;
    PackedListPropertyValidator listValidator;

    function setUp() public {
        bitVecValidator = new BitVectorPropertyValidator();
        listValidator = new PackedListPropertyValidator();
    }

    function testBitVectorPropertyValidatorSuccess() public view {
        // 80 bits
        bytes memory bitVector = new bytes(10);
        // The 63rd bit is set
        bitVector[7] = 0x01;
        bitVecValidator.validateProperty(
            address(0),
            63,
            bitVector
        );
    }
    function testBitVectorPropertyValidatorFailure() public {
        // 80 bits
        bytes memory bitVector = new bytes(10);
        // The 63rd bit is set
        bitVector[7] = 0x01;
        vm.expectRevert("BitVectorPropertyValidator::validateProperty/INVALID");
        bitVecValidator.validateProperty(
            address(0),
            64,
            bitVector
        );
    }

    function testPackedListPropertyValidatorUint8Success() public view {
        bytes memory list = abi.encodePacked(
            uint8(2), 
            uint8(3), 
            uint8(5), 
            uint8(7), 
            uint8(11), 
            uint8(13)
        );
        listValidator.validateProperty(
            address(0),
            7,
            abi.encode(uint256(1), list)
        );
    }
    function testPackedListPropertyValidatorUint8Failure() public {
        bytes memory list = abi.encodePacked(
            uint8(2), 
            uint8(3), 
            uint8(5), 
            uint8(7), 
            uint8(11), 
            uint8(13)
        );
        vm.expectRevert("PackedListPropertyValidator::validateProperty::TOKEN_ID_NOT_FOUND_IN_LIST");
        listValidator.validateProperty(
            address(0),
            8,
            abi.encode(uint256(1), list)
        );
    }
}
