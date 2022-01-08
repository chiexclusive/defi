//SPDX-License-Identifier: MIT

//Bing in solidity
pragma solidity >=0.4.22 <0.9.0;

//Get the token interface
import "./TokenInterface.sol";

contract BlueCoin is TokenInterface{

    //Variables
    address owner = msg.sender;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    string public name  = "Blue Coin";
    string public symbol = "BLC";
    uint256 public totalSupply = 1000000000000000000000000;
    uint8 public decimals = 18;

    //Get initilization data
    constructor(){
        //Allocated all available supply to the minter or the owner
        balanceOf[owner] = totalSupply;
    }

    //Event for successfully sending the coin
    event Transfer(address _from, address _to, uint256 _value);

    //Event for successfully sending the coin
    event Approved(address _owner, address _spender, uint256 _value);

    //Check if the helper is approved
    function isApproved(address _spender, uint256 _value) public view returns(bool success){
        if(allowance[_spender][msg.sender] >= _value) return true;
        return false;
    }

    //Check if the spender has the right balance
    function hasBalance (address _from, uint256 _value) public view returns (bool success){
        if(balanceOf[_from] >= _value) return true;
        else return false;
    }

    //Check if the account has a zero balance
    function hasZeroBalace(address _address) public view returns (bool success){
        if(balanceOf[_address] <= 0) return true;
        return false;
    }

    //Add helper to approval list
    function approve(address _spender, uint256 _value) public payable returns (bool success){
        allowance[msg.sender][_spender] = _value;
        emit Approved(msg.sender, _spender, _value);
        return true;
    }

    //Send Coin form the senders account
    function transfer (address _to, uint _value ) public payable returns (bool success){
        //Check if the the sender has sufficient balance
        require(hasBalance(msg.sender, _value), "Insufficient Balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    //Send Coin form the senders account
    function transferFrom (address _from , address _to, uint _value ) public payable returns (bool success){
        //Check if the the sender has sufficient balance
        address _spender = msg.sender;
        require(hasBalance(_from, _value), "Insufficient Balance");
        require(isApproved(_spender, _value), "Spender is not approved");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}