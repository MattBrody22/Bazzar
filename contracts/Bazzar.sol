// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import '@openzeppelin/contracts/utils/Counter.sol';
import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/security.ReentracyGuard.sol';

contract Bazzar is ReentrancyGuard {
  using Counters for Counters.Counter;
  Counters.Counter private products;
  Counters.Counter private trades;

  address payable owner;
  uint256 priceTag = 0.2 ether;

  mapping(uint256 => Product) private _products;

  struct Product {
    uint product;
    address contractId;
    uint256 tokenId;
    address payable supplier;
    address payable owner;
    uint256 cost;
    bool traded:
  }
  event Products(
    uint indexed product,
    address indexed contractId,
    uint256 indexed tokenId,
    address supplier,
    address owner, 
    uint256 cost,
    bool traded 
    );

  constructor() {
    owner = payable(msg.sender);
  }
  function productCost() public view returns(uint256) {
    return priceTag;
  }
  function inventory(
    address contractId, 
    uint256 tokenId, 
    uint256 cost
    ) public payable nonReentract {
    require(cost > 0.1, 'cost needs to be at least 0.1')
    require(msg.value == priceTag, 'cost needs to equal price tag');
    products.increment();
    uint256 product = products.current();
    _products[product] = HyperItem(
      product,
      contractId, 
      tokenId,
      payable(msg.sender),
      payable(address(0)),
      cost,
      false
    );
    IERC721(contractId).transferFrom(msg.sender, address(this), tokenId);
    emit Products(
      product,
      contractId,
      tokenId,
      msg.sender,
      address(0),
      cost;
      false
    );
  }
  function productTraded(
    address contractId,
    uint256 product
    ) public payable nonReentrant {
    uint cost = _products[product].cost;
    uint tokenId = _products[product].tokenId;
    require(msg.value == cost, 'Summit item cost');
    _products[product].supplier.transfer(msg.value);
    IERC721(contractId).transferFrom(address(this), msg.sender, tokenId);
    _products[product].owner = payable(msg.sender);
    _products[product].traded = true;
    trades.increment();
    payable(owner).transfer(priceTag);
  }
  function retrieveProducts() public view returns(Product[] memory) {
    uint productsTotal = products.current();
    uint productsAvailable = products.current() - trades.current();
    uint productsRegistry = 0;
    Product[] memory inventory = new  Product[](productsAvailable);
    for(uint i = 0; i < productsTotal; i++) {
      if(_products[i + 1].owner == address(0)) {
        uint PresentId = i + 1;
        Products storage presentProduct = Product[presentId];
        inventory[productsRegistry] = presentProduct;
        productsRegistry += 1;
      }
    }
    return inventory;
  }
  function retrieveNFTs() public view returns(Product[] memory) {
    uint productsSupply = products.current();
    uint productsTotal = 0;
    uint productsRegistry = 0;
    for(uint i = 0; i < productSupply; i++) {
      if(_products[i + 1].owner == msg.sender) {
        productsTotal += 1;
      }
    }
    Product[] memory inventory = new Product[](productsTotal);
    for(uint i = 0; i < productsSupply; i++) {
      if(_products[i + 1].owner == msg.sender) {
        uint presentId = i + 1;
        Products storage presentProduct = _products[presentId];
        inventory[presentRegistry] = presentProduct;
        productRegistry += 1;
      }
    }
    return inventory;
  }
  function retrieveInventory() public view returns(Product[] memory) {
    uint productsSupply = products.current();
    uint productsTotal = 0;
    uint productsRegistry = 0;
    for(uint i = 0; i < productsSupply; i++) {
      if(_products[i + 1].supplier == msg.sender) {
        productsTotal +=;
      }
    }
    Product[] memory inventory = new Product[](productsTotal);
    for(uint i =  0; i < productsSupply; i++) {
      if(_products[i + 1].supplier == msg.sender) {
        uint presentId = i + 1;
        Product storage presentProduct = _products[presentId];
        inventory[productsRegistry] = presentProduct;
        productsRegistry += 1;
      }
    }
    return inventory;
  }
}