//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SimpleToken is ERC20 {
	constructor(uint256 initialSupply) ERC20("SimpleToken", "SIM") {
		_mint(msg.sender, initialSupply);
	}

	function mint(address to, uint256 amount) public {
		_mint(to, amount);
	}
}
