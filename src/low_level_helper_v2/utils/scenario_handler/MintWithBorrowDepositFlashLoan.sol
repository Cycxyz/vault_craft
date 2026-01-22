// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

import {ILowLevelVault} from "../../../interfaces/ILowLevelVault.sol";
import {IFlashLoanConnector} from "../../interface/IFlashLoanConnector.sol";
import {IExchangeConnector} from "../../interface/IExchangeConnector.sol";
import {SafeERC20, IERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract MintWithBorrowDepositFlashLoan {
    using SafeERC20 for IERC20;
    using SafeERC20 for ILowLevelVault;

    function _handleMintWithBorrowInDepositFlashLoan(
        address vault,
        address borrowToCollateralExchange,
        address collateralToBorrowExchange,
        address borrowFlashLoanConnector,
        address collateralFlashLoanConnector,
        address borrowAsset,
        address collateralAsset,
        bool useShareAsInput,
        uint256 assetsIn,
        uint256 limitAssetsOut
    ) internal returns (uint256) {
        IFlashLoanConnector(collateralFlashLoanConnector).flashLoan(asset, assetsIn, abi.encode());
    }

    function _handleMintWithBorrowDepositFlashLoanFallback(bytes memory data) internal {
        int256 deltaShares;
        int256 deltaBorrow;
        int256 deltaCollateral;
        if (useSharesAsInput) {
            deltaShares = int256(assetIn);
            (deltaCollateral, deltaBorrow) = ILowLevelVault(vault).previewLowLevelRebalanceShares(deltaShares);
        } else {
            deltaBorrow = int256(assetsIn);
            (deltaCollateral, deltaShares) = ILowLevelVault(vault).previewLowLevelRebalanceBorrow(deltaBorrow);
        }
    }
}
