// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {UniversalSwapper} from "../src/universalSwapper.sol";
import{IERC20} from '../src/interfaces/IERC20.sol';
import {IAllowanceTransfer} from '../src/interfaces/IAllowanceTransfer.sol';
interface CheatCodes {
           function prank(address) external;    
 }

contract Sniper_tester is Test{
    CheatCodes public cheatCodes;
    UniversalSwapper public sniper;
    address public token;

    function setUp() public {
        sniper = new UniversalSwapper();
        token = 0x532f27101965dd16442E59d40670FaF5eBB142E4;
        cheatCodes = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
        deal(address(this),1e18);//fund this contact with eth
        assertEq(address(this).balance, 1e18);
    }
    function test_snipe() public {
        sniper.execute{value:address(this).balance}(token);
    }
}