// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
interface IAeroRouter {
    struct Route {
        address from;
        address to;
        bool stable;
        address factory;
    }
  function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        Route[] calldata routes,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);
    /// @notice Perform chained getAmountOut calculations on any number of pools
    function getAmountsOut(uint256 amountIn, Route[] memory routes) external view returns (uint256[] memory amounts);

}