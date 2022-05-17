# Generalized Property Validators

This repository contains two smart contracts implementing the 0x V4 `PropertyValidator` interface, enabling trait-based orders for any ERC721 or ERC1155 collection. 

## BitVectorPropertyValidator

`propertyData` encodes a bit vector, where the bit at index `i` is set if `tokenId = i` is considered valid.
The size of `propertyData` grows linearly with the number of tokenIds in the collection. 
Note that any trailing zeros in the bit vector can be truncated –– if `tokenId` is greater than the length of the bit vector, it will revert.

## PackedListPropertyValidator

`propertyData` encodes two values: `uint256 bytesPerTokenId` and `bytes packedList`. `packedList` is a packed encoding (as in `abi.encodePacked`) of all the tokenIds considered valid.
Each `tokenId` is allocated `bytesPerTokenId` bytes in the packed encoding. `packedList` is sorted in ascending order of tokenId. 
`PackedListPropertyValidator` performs a binary search over the packed list to determine whether the given tokenId is in the list. 
The size of `propertyData` grows linearly with the number of tokenIds in the valid subset (e.g. the number of tokenIds that have a certain trait). 

## Suggested Usage

For a given collection/trait, the corresponding bit vector or packed list can be generated off-chain (and presumably stored in a database somewhere). 
`eth_call` simulations can be used to determine which of the two approaches is more gas efficient for the given collection/trait.
For the rare cases where both the collection and the desired subset of tokenIds is extremely large, it may be more efficient to use a Merkle tree, which scales logarithmically with the size of the subset. 

## Deployed contracts

Mainnet:
- `BitVectorPropertyValidator`: https://etherscan.io/address/0x345db61cf74cea41c0a58155470020e1392eff2b
- `PackedListPropertyValidator`: https://etherscan.io/address/0xda9881fcdf8e73d57727e929380ef20eb50521fe

## Disclaimer

These contracts have not been audited (or thoroughly tested, for that matter). Use at your own risk.