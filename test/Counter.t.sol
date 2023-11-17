// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {CrowdFunding} from "../src/CrowdFunding.sol";
import {SimpleToken} from "../src/SimpleToken.sol";

contract CrowdFundingTest is Test {
	CrowdFunding public crowdFunding;
	address john = makeAddr("john");
	SimpleToken public token;

	function setUp() public {
		token = new SimpleToken(1000);
		crowdFunding = new CrowdFunding(msg.sender, token);
		crowdFunding.setNumber(0);
	}

	function test_Increment() public {
		crowdFunding.increment();
		assertEq(crowdFunding.number(), 1);
	}

	function testFuzz_SetNumber(uint256 x) public {
		crowdFunding.setNumber(x);
		assertEq(crowdFunding.number(), x);
	}

	function test_ownerCheck() public {
		assertEq(crowdFunding._owner(), msg.sender);
	}

	function test_depositCheck() public {
		token.approve(address(crowdFunding), 10);
		crowdFunding.deposit(10);
		assertEq(token.balanceOf(address(crowdFunding)), 10);

		vm.startPrank(john);
		token.mint(john, 10);
		token.approve(address(crowdFunding), 10);
		crowdFunding.deposit(10);
		vm.stopPrank();
		assertEq(token.balanceOf(address(crowdFunding)), 20);
		console2.log(token.balanceOf(address(crowdFunding)));
	}

	function test_withdrawCheck() public {
		// token.approve(address(crowdFunding), 10);
		// crowdFunding.deposit(10);
		// assertEq(token.balanceOf(address(crowdFunding)), 10);

		vm.startPrank(john);
		token.mint(john, 10);
		token.approve(address(crowdFunding), 10);
		crowdFunding.deposit(10);
		vm.stopPrank();
		// assertEq(token.balanceOf(address(crowdFunding)), 20);
		console2.log(msg.sender);
		console2.log(crowdFunding._owner());

		// vm.prank(address(crowdFunding));
		// token.approve(address(crowdFunding), 10);
		vm.prank(msg.sender);
		crowdFunding.withdraw();

		assertEq(token.balanceOf(msg.sender), 10);
	}
}
