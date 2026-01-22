// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

import {ILowLevelVault} from "../interfaces/ILowLevelVault.sol";
import {SafeERC20, IERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract LowLevelHelper {
    using SafeERC20 for IERC20;
    using SafeERC20 for ILowLevelVault;
}