// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ValorantToken is ERC20, Ownable {
    // Represents an in-game Valorant-themed item
    struct ValorantItem {
        uint256 id;
        string name;
        uint256 price; // Price in tokens
    }

    ValorantItem[] public valorantItems; // Array to store in-game items

    // Constructor to initialize token and in-game items
    constructor() ERC20("ValorantToken", "VAL") {
        _initializeItems();
    }

    // Add Valorant-themed items
    function _initializeItems() internal {
        valorantItems.push(ValorantItem(1, "Elderflame Vandal Skin", 5));
        valorantItems.push(ValorantItem(2, "Riot Gun Buddy", 10));
        valorantItems.push(ValorantItem(3, "Premium Battle Pass", 20));
    }

    // Mint new tokens to a specified address (Owner only)
    function mint(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Cannot mint to zero address");
        require(amount > 0, "Mint amount must be greater than 0");
        _mint(to, amount);
    }

    // Redeem tokens for a Valorant item
    function redeemItem(uint256 itemId) external {
        require(itemId > 0 && itemId <= valorantItems.length, "Invalid item ID");

        ValorantItem storage item = valorantItems[itemId - 1];
        require(balanceOf(msg.sender) >= item.price, "Insufficient tokens to redeem");

        _burn(msg.sender, item.price);

        // Placeholder for redeem logic, e.g., giving item ownership
        // For example: assign skin or item in a game database
    }

    // View token balance of an address
    function checkBalance(address account) external view returns (uint256) {
        return balanceOf(account);
    }

    // Burn tokens (reduce supply)
    function burn(uint256 amount) external {
        require(amount > 0, "Burn amount must be greater than 0");
        _burn(msg.sender, amount);
    }

    // Get the total number of items
    function getItemCount() external view returns (uint256) {
        return valorantItems.length;
    }

    // Retrieve item details by ID
    function getItem(uint256 itemId) external view returns (ValorantItem memory) {
        require(itemId > 0 && itemId <= valorantItems.length, "Invalid item ID");
        return valorantItems[itemId - 1];
    }
}
