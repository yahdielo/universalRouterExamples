// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {IUniversalRouter} from './interfaces/IUniversalRouter.sol';
import {Commands} from './interfaces/Commands.sol';
import{IERC20} from './interfaces/IERC20.sol';
import {IUniswapV3Factory } from './interfaces/IUniswapV3Factory.sol';
import { IPermit2 } from './interfaces/IPermit2.sol';


contract UniversalSwapper {

    address public owner;
    //ISwapRouter02 public immutable swapRouter02;
    IUniversalRouter public immutable router;
    IPermit2 public immutable permit2;
    IERC20 public immutable weth;

    event Error(string);
   
    constructor(){
        owner = msg.sender;
        router = IUniversalRouter(0x3fC91A3afd70395Cd496C647d5a6CC9D4B2b7FAD);//0x198EF79F1F515F02dFE9e3115eD9fC07183f02fC);
        permit2 = IPermit2(0x000000000022D473030F116dDEE9F6B43aC78BA3);
        weth = IERC20(0x4200000000000000000000000000000000000006);//0xfFf9976782d46CC05630D1f6eBAb18b2324d6B14);//base weth 0x4200000000000000000000000000000000000006
        permit2.approve(address(weth), address(router), type(uint160).max, type(uint48).max);
        weth.approve(address(permit2),type(uint256).max);
        //swapRouter02 = ISwapRouter02(0x2626664c2603336E57B271c5C0b26F421741e481);
    }
   
    function execute(address token) payable public returns(uint[] memory amounts) {
        if(msg.value == 0) revert();
        
        bytes memory commands = abi.encodePacked(
            bytes1(uint8(Commands.WRAP_ETH)),
            bytes1(uint8(Commands.V2_SWAP_EXACT_IN))
            );

        uint256 amount = msg.value;
        address[] memory path = new address[](2);
        path[0] = address(weth);
        path[1] = token;

        bytes[] memory inputs = new bytes[](2);
        inputs[0] = abi.encode(address(this), amount);
        inputs[1] = abi.encode(
            msg.sender,
            amount,
            0,
            path,
            true
            );

         try router.execute{value: amount}(commands, inputs, block.timestamp) {
        // Success
            } catch (bytes memory reason) {
                // Handle failure
                emit Error(string(reason));
            }
    }
    fallback() external payable{}
}
