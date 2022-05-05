// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./IPropertyValidator.sol";

contract BitVectorPropertyValidator is IPropertyValidator {

    /// @dev Checks that the given ERC721/ERC1155 asset satisfies the properties encoded in `propertyData`.
    ///      Should revert if the asset does not satisfy the specified properties.
    /// @param tokenId The ERC721/ERC1155 tokenId of the asset to check.
    /// @param propertyData Bit vector of tokenIds that satisfy the properties.
    function validateProperty(
        address /* tokenAddress */,
        uint256 tokenId,
        bytes calldata propertyData
    )
        external
        pure
    {
        require(
            tokenId < propertyData.length * 8, 
            "BitVectorPropertyValidator::validateProperty/EXCEEDS_BITVECTOR_LENGTH"
        );

        require(
            uint8(propertyData[tokenId / 8]) & (0x80 >> (tokenId % 8)) != 0,
            "BitVectorPropertyValidator::validateProperty/INVALID"
        );
    }
}