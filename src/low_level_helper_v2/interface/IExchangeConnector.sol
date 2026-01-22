// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

interface IExchangeConnector {
    function exchange(address assetIn, address assetOut, uint256 amountIn) external returns (uint256 amountOut);
}