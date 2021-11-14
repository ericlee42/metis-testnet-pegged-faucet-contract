// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PeggedToken.sol";
import "./Ownable.sol";

contract Faucet is Ownable {
    mapping(string => address) internal created;
    address[] internal tokens;

    event Create(string sybmol, address token);
    event Claim(string symbol, address reciever, uint256 amount);

    function getTokenAddress(string memory _symbol)
        public
        view
        returns (address token)
    {
        return created[_symbol];
    }

    function getTokens()
        public
        view
        returns (string[] memory symbols, address[] memory addresses)
    {
        symbols = new string[](tokens.length);
        addresses = new address[](tokens.length);
        for (uint256 i = 0; i < tokens.length; i++) {
            address token = tokens[i];
            symbols[i] = PeggedToken(token).symbol();
            addresses[i] = token;
        }
    }

    function create(string memory _symbol) public onlyOwner {
        require(created[_symbol] == address(0), "token has created");
        address token = address(new PeggedToken(_symbol));
        created[_symbol] = token;
        tokens.push(token);
        emit Create(_symbol, token);
    }

    function claim(string memory _symbol, uint256 _amount) public {
        require(created[_symbol] != address(0), "token has not created");
        PeggedToken token = PeggedToken(created[_symbol]);
        token.mint(msg.sender, _amount);
        emit Claim(_symbol, msg.sender, _amount);
    }
}
