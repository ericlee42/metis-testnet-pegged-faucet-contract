// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
    address public admin = msg.sender;
    mapping(address => bool) internal owners;

    constructor() {
        owners[msg.sender] = true;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "only admin");
        _;
    }

    modifier onlyOwner() {
        require(owners[msg.sender], "only owner");
        _;
    }

    function addOwner(address _owner) public onlyAdmin {
        owners[_owner] = true;
    }

    function removeOwner(address _owner) public onlyAdmin {
        owners[_owner] = false;
    }

    function isOwner(address _owner) public view returns (bool) {
        return owners[_owner];
    }
}
