// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CrowdFunding {
	uint256 public number;
	address public _owner;
	IERC20 public _asset;

	constructor(address owner, IERC20 asset) {
		_owner = owner;
		_asset = asset;
	}

	function setNumber(uint256 newNumber) public {
		number = newNumber;
	}

	function increment() public {
		number++;
	}

	function deposit(uint256 _amount) public {
		_asset.transferFrom(msg.sender, address(this), _amount);
	}

	function withdraw() public {
		require(_owner == msg.sender, "not Owner");
        uint256 amount = _asset.balanceOf(address(this));
        _asset.approve(address(this), amount);
		_asset.transferFrom(address(this), msg.sender, amount);
	}
}
