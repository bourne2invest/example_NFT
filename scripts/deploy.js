async function main() {
    const ExampleNFT = await ethers.getContractFactory("ExampleNFT")

    // start deployment, return promise resolving to contract object
    const exampleNFT = await ExampleNFT.deploy()
    await exampleNFT.deployed()
    console.log("Contract deployed to address:", exampleNFT.address)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })