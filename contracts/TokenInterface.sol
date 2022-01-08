//SPDX-License-Identifier: MIT

//Bing in solidity
pragma solidity >=0.4.22 <0.9.0;

//Interface to ensure that all methods or function is the
//bluecoin and the reward token are implemented compulsorily
interface TokenInterface {
    
    //Check if the spender is approved to spend token for the owner
    function isApproved(address _spender, uint256 _value) external view returns(bool success);

    //Handle the transfer of token made by the owner
    function transfer (address _to, uint _value ) external payable returns (bool success);

    //Handle the transfer by a spender from another address
    function transferFrom (address _from , address _to, uint _value ) external payable returns (bool success);

    //Check if the spender has the right balance
    function hasBalance (address _from, uint256 _value) external view returns (bool success);

    //Approve spender for third party transactions
    function approve(address _spender, uint256 _value) external payable returns (bool success);
}