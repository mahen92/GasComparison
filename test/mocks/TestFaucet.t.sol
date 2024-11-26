// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract TestFaucet is ERC20 {
    constructor() ERC20("TestFaucet","TF"){

    }

    function mint(address account,uint256 amount) external{
        _mint(account,amount);
    }
}