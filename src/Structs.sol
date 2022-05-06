// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {IPropertyValidator} from "./IPropertyValidator.sol";

// https://github.com/0xProject/protocol/blob/ba719a96312a8ea3bfe1db2990ed72e0e0fd18c1/contracts/zero-ex/contracts/src/features/libs/LibSignature.sol

enum SignatureType {
    ILLEGAL,
    INVALID,
    EIP712,
    ETHSIGN,
    PRESIGNED
}

struct Signature {
    SignatureType signatureType;
    uint8 v;
    bytes32 r;
    bytes32 s;
}

// https://github.com/0xProject/protocol/blob/ba719a96312a8ea3bfe1db2990ed72e0e0fd18c1/contracts/zero-ex/contracts/src/features/libs/LibNFTOrder.sol

enum TradeDirection {
    SELL_NFT,
    BUY_NFT
}

struct Property {
    IPropertyValidator propertyValidator;
    bytes propertyData;
}

struct Fee {
    address recipient;
    uint256 amount;
    bytes feeData;
}

struct ERC721Order {
    TradeDirection direction;
    address maker;
    address taker;
    uint256 expiry;
    uint256 nonce;
    address erc20Token;
    uint256 erc20TokenAmount;
    Fee[] fees;
    address erc721Token;
    uint256 erc721TokenId;
    Property[] erc721TokenProperties;
}
