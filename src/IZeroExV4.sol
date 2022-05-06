// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {IPropertyValidator} from "./IPropertyValidator.sol";
import {ERC721Order, Signature} from "./Structs.sol";

// https://github.com/0xProject/protocol/blob/ba719a96312a8ea3bfe1db2990ed72e0e0fd18c1/contracts/zero-ex/contracts/src/features/nft_orders/ERC721OrdersFeature.sol

interface IZeroExV4 {
    function getERC721OrderHash(ERC721Order calldata order)
        external
        view
        returns (bytes32);
}
