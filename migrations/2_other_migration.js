const blueCoin = artifacts.require("BlueCoin");
const rewardToken = artifacts.require("RewardToken");
const decentralBank = artifacts.require("DecentralBank");

module.exports = async (deployer, network, accounts) => {
    await deployer.deploy(blueCoin);
    const deployedBlueCoin = await blueCoin.deployed();

    await deployer.deploy(rewardToken);
    const deployedRewardToken = await rewardToken.deployed();

    await deployer.deploy(decentralBank, deployedBlueCoin.address, deployedRewardToken.address);
    const deployedDecentralBank = await decentralBank.deployed();

    const rwdSupply = await deployedRewardToken.balanceOf(deployedRewardToken.address);
    
    //Transfer all reward token to the decentral bank
    deployedRewardToken.transfer(deployedDecentralBank.address, rwdSupply);

    //Give the first investor 100 blue coin during initialization of the contract
    deployedBlueCoin.transfer(accounts[1], web3.utils.toWei("100", "ether"));
}