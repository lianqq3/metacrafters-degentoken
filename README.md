# ValorantToken Smart Contract

## Overview
The **ValorantToken** contract is an Ethereum-based ERC20 token. It creates a token called **Degen (DGN)**, which can be used in a Valorant-inspired ecosystem to redeem in-game items such as skins, gun buddies, and battle passes. The contract includes features for minting, burning, and managing tokens.

---

## Features
- **Token Name**: Degen  
- **Token Symbol**: DGN  

### Valorant-Themed Items
- Items include:
  - **Elderflame Vandal Skin** (5 DGN)
  - **Riot Gun Buddy** (10 DGN)
  - **Premium Battle Pass** (20 DGN)

### Core Functionalities
1. **Mint Tokens**: Owner can mint tokens to specified addresses.
2. **Redeem Items**: Users can redeem tokens for Valorant-themed items.
3. **Burn Tokens**: Users can burn their tokens to reduce supply.
4. **Check Balance**: View token balance of any address.
5. **View Items**: Retrieve item details and count of available items.

---

## How It Works

### Initialization
When deployed:
- The contract creates the **Degen (DGN)** token with ERC20 features.
- Preloads a list of Valorant-themed items with unique IDs, names, and prices in tokens.

### Key Functions

```solidity
// Constructor to initialize the token and in-game items
constructor() ERC20("Degen", "DGN") {
    _initializeItems();
}

// Internal function to initialize the Valorant-themed items
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
```
### Authors

Eymard Julian S. Jimeno | 202110545@fit.edu.ph
