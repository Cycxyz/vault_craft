// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

import {Scenario} from "./Scenario.sol";

library GetCurrentScenario {
    error InvalidScenario(int256 deltaCollateral, int256 deltaBorrow, int256 deltaShares, bool isBorrowAsset);

    function getCurrentScenario(int256 deltaCollateral, int256 deltaBorrow, int256 deltaShares, bool isBorrowAsset)
        internal
        pure
        returns (Scenario)
    {
        if (deltaShares > 0) {
            if (deltaCollateral > 0 && deltaBorrow >= 0) {
                return isBorrowAsset ? Scenario.MINT_WITH_BORROW_DEPOSIT_FLASH_LOAN : Scenario.MINT_WITH_COLLATERAL_DEPOSIT_FLASH_LOAN;
            } else if (deltaCollateral >= 0 && deltaBorrow <= 0) {
                return isBorrowAsset ? Scenario.MINT_WITH_BORROW_NO_FLASH_LOAN : Scenario.MINT_WITH_COLLATERAL_NO_FLASH_LOAN;
            } else if (deltaCollateral <= 0 && deltaBorrow < 0) {
                return isBorrowAsset ? Scenario.MINT_WITH_BORROW_WITHDRAW_FLASH_LOAN : Scenario.MINT_WITH_COLLATERAL_WITHDRAW_FLASH_LOAN;
            }
        } else if (deltaShares < 0) {
            if (deltaCollateral >= 0 && deltaBorrow > 0) {
                return isBorrowAsset ? Scenario.REDEEM_WITH_BORROW_DEPOSIT_FLASH_LOAN : Scenario.REDEEM_WITH_COLLATERAL_DEPOSIT_FLASH_LOAN;
            } else if (deltaCollateral <= 0 && deltaBorrow >= 0) {
                return isBorrowAsset ? Scenario.REDEEM_WITH_BORROW_NO_FLASH_LOAN : Scenario.REDEEM_WITH_COLLATERAL_NO_FLASH_LOAN;
            } else if (deltaCollateral < 0 && deltaBorrow <= 0) {
                return isBorrowAsset ? Scenario.REDEEM_WITH_BORROW_WITHDRAW_FLASH_LOAN : Scenario.REDEEM_WITH_COLLATERAL_WITHDRAW_FLASH_LOAN;
            }
        }

        revert InvalidScenario(deltaCollateral, deltaBorrow, deltaShares, isBorrowAsset);
    }
}
