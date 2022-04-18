// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';

contract Comet is ERC20 {
    address public deployer; //to save adress of the deployer
    
    constructor() ERC20('Comet', 'CMT') { //called by the deployer (once)
        _mint(msg.sender, 10000000 * 10 ** 18); //mint/create tokens - we have created 10000000*10^18 tokens
        deployer = msg.sender;  //set the deployer
    }

    function mint (address to, uint amount) external {  //to mint more tokens, can only be called by the deployer, total supply depends on the deployer's wants
        require (msg.sender == deployer, "only deployers can call this function");
        _mint(to, amount);
    }

    function burn (uint amount) external {  //remove tokens by sending then to a zero address
        _burn(msg.sender, amount);
    }
}

contract Pluto is ERC20 {
    address public deployer; //to save adress of the deployer
    
    constructor() ERC20('Pluto', 'PLT') { //called by the deployer (once)
        _mint(msg.sender, 1000000000000 * 10 ** 18); //mint/create tokens - we have created 100000000000*10^10 tokens
        deployer = msg.sender;  //set the deployer
    }

    //total supply is fixed no more can be created ever

    function burn (uint amount) external {  //remove tokens by sending then to a zero address
        _burn(msg.sender, amount);
    }
}

//approve: approves spender to use x amount of deployer's tokens, does not send spender money


