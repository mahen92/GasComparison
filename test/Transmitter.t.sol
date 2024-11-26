// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Transmitter} from "../src/Transmitter.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "./mocks/TestFaucet.t.sol";

contract TransmitterTest is Test {
    Transmitter public transmitter;
    TestFaucet public faucet;
    address user = makeAddr("alice");
    address faucetAddr = makeAddr("faucet");
    address user1 = makeAddr("bob");

    uint256 public constant DECIMAL_PER_TOKEN = 1e18;


    function setUp() public {
        faucet = new TestFaucet();
        transmitter = new Transmitter(faucet);
        vm.startPrank(faucetAddr);
        faucet.mint(address(faucetAddr),10*DECIMAL_PER_TOKEN);
        faucet.approve(address(transmitter),10*DECIMAL_PER_TOKEN);
        vm.stopPrank();
    }

    function test_firstMethod() public {
        vm.startPrank(user);
        transmitter.openFaucetInefficient(faucetAddr,user1,10);
        vm.stopPrank();
    }

    function test_secondMethod() public {
        vm.startPrank(user);
        transmitter.openFaucetEfficient(faucetAddr,user1,10);
        vm.stopPrank();
    }

    function test_thirdMethod() public {
        vm.startPrank(user);
        transmitter.openFaucetMoreEfficient(faucetAddr,user1,10);
        vm.stopPrank();
    }
}
