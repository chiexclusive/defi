//SPDX-License-Identifier: MIT

//Bing in solidity
pragma solidity >=0.4.22 <0.9.0;

import "./BlueCoin.sol";
import "./RewardToken.sol";

contract DecentralBank {

    //Variables 
    BlueCoin internal BLC;
    RewardToken internal RWD;
    mapping (address => uint256) public stakedAmount;
    mapping(address => bool) public hasStaked;
    address [] public stakers;
    address internal owner;
    uint8 rate = 13;

    //Restriction
    modifier OnlyOwner {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }

    constructor(BlueCoin blueCoin, RewardToken rewardToken){
        //Get Instances of these contracts
        BLC = blueCoin;
        RWD = rewardToken;
        owner = msg.sender;
    }

    //Staker deposit function
    function deposit (address _from, uint256 _value) public payable returns (bool success){

        //Ensure that investor has the right balance
        require(BLC.hasBalance(_from, _value), "Insufficient Balance");

        //Transfer Blc to Decentral Bank Address    
        BLC.transferFrom(_from, address(this), _value);

        //Register the stake
        stakedAmount[_from] += _value;
        if(hasStaked[_from] != true){
            hasStaked[_from] = true;
            stakers.push(_from);
        }
        
        return true;
    }

    //Withdraw  Staked Token
    function withdraw (uint256 _amount) public payable returns (bool success){
        require(_amount  <= stakedAmount[msg.sender], "Withdrawal exceeds existing stake");
        stakedAmount[msg.sender] -= _amount;
        return true;
    }

    //Issue token to staker
    function issueToken() public OnlyOwner payable returns (bool success){
        
        // Issue staker based on the gravity of individual stake
        for(uint x; x < stakers.length; x++){
            if(!BLC.hasZeroBalace(stakers[x])) BLC.transferFrom(address(this), stakers[x], stakedAmount[stakers[x]] * (rate/100));
        }

        return true;
    }

    //Update rate of return
    function updateRate (uint8 _rate) public OnlyOwner payable returns (bool success){

        //Ensure that rate used is below nothing
        require(_rate > 0, "Rate cannot be insignigicant");

        rate = _rate;

        return true;
    }
}