const BlueCoin = artifacts.require("BlueCoin");
const RWD = artifacts.require("RewardToken");
const DecentralBank = artifacts.require("DecentralBank");

require("chai").use(require("chai-as-promised")).should();


contract("BlueCoin", (accounts) => {

    let blueCoin;
    let rewardToken;
    let decentralBank;

    before(async() => {
       blueCoin =  await BlueCoin.new();
       rewardToken = await RWD.new();
       decentralBank = await DecentralBank.new(blueCoin.address, rewardToken.address);
    })

    describe("Deployment", async () => {
        it("Blue Coin Should have a name", async () => {
            let name = await blueCoin.name();
            assert.equal(name, "Blue Coin", "Blue token name is invalid");
        })

        it("Blue Coin Should have an address", async () => {
            let address = blueCoin.address;
            assert.notEqual(address, null);
            assert.notEqual(address, undefined);
            assert.notEqual(address, "");
        })

        it("Reward Token Should have a name", async () => {
            let name = await rewardToken.name();
            assert.equal(name, "Reward Token");
        })

        it("Reward Token Should have an address", async () => {
            let address = rewardToken.address;
            assert.notEqual(address, null);
            assert.notEqual(address, undefined);
            assert.notEqual(address, "");
        })

        it("Decentral Bank have an address", async () => {
            assert.notEqual(address, undefined);
            assert.notEqual(address, "");
        })
    })
})