// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol';

import "./Tokens.sol";

contract NFT {
    //user has to manually approve the contract using the token's contract instance
    uint private nft_counter = 0;
    uint private total_supply;
    mapping(address => uint) nfts; //stores the token number with it's owner address
    address developer = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address owner;
    uint ether_price = 0.05 ether;
    uint pluto_price = 5;
    uint comet_price = 10;
    address plutoContractInstance = 0xcD6a42782d230D7c13A74ddec5dD140e55499Df9;
    address cometContractInstance = 0xfC713AAB72F97671bADcb14669248C4e922fe2Bb;
    

    constructor(){
        owner = msg.sender; //set developer
        total_supply = 10;
    }

    function incTotalSupply(uint _amount) public{
        require(msg.sender == owner, "you are not authorized to call this function");
        total_supply += _amount;
    }

    function _mint() internal {
        nft_counter += 1;
        nfts[msg.sender] = nft_counter;
    }

    event Received(address, uint);
    function mintUsingEther() public payable{
        require(nft_counter <= total_supply, "out of stock");
        require(nfts[msg.sender] < 1, "cannot mint more than one nft");
        require(msg.value == ether_price, "Wrong amount of ether");
        emit Received(msg.sender, msg.value);
        _mint();
        //payable(developer).transfer(ether_price / 100 * 10 ** 18);
    }

    function mintUsingPluto() public payable{
        require(nft_counter <= total_supply, "out of stock");
        require(nfts[msg.sender] < 1, "cannot mint more than one nft");
        require(ERC20(plutoContractInstance).transferFrom(msg.sender, address(this), pluto_price), "transfer Failed");
        _mint();
        ERC20(plutoContractInstance).transferFrom(address(this), developer, pluto_price/100*10**18);
    }

    function mintUsingComet() public payable{
        require(nft_counter <= total_supply, "out of stock");
        require(nfts[msg.sender] < 1, "cannot mint more than one nft");
        require(ERC20(cometContractInstance).transferFrom(msg.sender, address(this), comet_price), "transfer Failed");
        _mint();
        ERC20(cometContractInstance).transferFrom(address(this), developer, comet_price/100*10**18);
    }

    function see(address _address) public view returns(uint) {
        return nfts[_address];
    }

    function seeBalance (address _address) public view returns (uint) {
        return _address.balance;
    }

    function withdrawAllEther() public {
        require(msg.sender == owner, "you are not authorized to call this function");
        payable(owner).transfer(address(this).balance);
    }

    // function withdrawSomeEther(uint _amount) public {
    //     require(msg.sender == owner, "you are not authorized to call this function");
    //     payable(owner).transfer(_amount);
    // }

    function withdrawPluto(uint _amount) public {
        require(msg.sender == owner, "you are not authorized to call this function");
        ERC20(plutoContractInstance).transfer(owner, _amount);
    }

    function withdrawComet(uint _amount) public {
        require(msg.sender == owner, "you are not authorized to call this function");
        ERC20(cometContractInstance).transfer(owner, _amount);
    }
}
