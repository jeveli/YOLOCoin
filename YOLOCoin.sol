// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


contract YOLOCoin is ERC20, Ownable {
    uint256 public constant BURN_RATE = 1; // 0.1% burn per transaction

    constructor() ERC20("YOLOCoin", "YOLO") Ownable(msg.sender) {
        _mint(msg.sender, 1_000_000_000_000 * 10**decimals()); // 1 Trillion YOLO
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        uint256 burnAmount = (amount * BURN_RATE) / 1000; // Calculate burn amount (0.1%)
        uint256 transferAmount = amount - burnAmount; // Final amount to transfer

        _burn(msg.sender, burnAmount); // Burn the tokens
        _transfer(msg.sender, recipient, transferAmount); // Transfer remaining tokens
        return true;
    }
}
