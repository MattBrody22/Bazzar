describe('Bazzar', async () => {
  it('Create and Execute', async () => {
    const Bazzar = await ethers.getContractFactory('Bazzar')
    const bazzar = await Bazzar.deploy()
    await bazzarAddress = bazzar.address

    const NFT = await ethers.getContractFactory('NFT')
    const nft = await NFT.deploy(bazzarAddress)
    await nft.deployed()
    const nftContractAddress = nft.bazzarAddress

    let priceTag = await bazzar.productCost()
    priceTag = priceTag.toString()

    const auctionPrice = ethers.utils.parseUnits('1', 'ether')

    await nft.createToken('')
    await nft.createToken('')

    await bazzar.inventory(nftContractAddress, 1, auctionPrice, {value:priceTag})
    await bazzar.inventory(nftContractAddress, 2, auctionPrice, {value:priceTag})

    const [_, buyerAddress] = await ethers.getSigners()

    await bazzar.connect(buyerAddress).inventory(nftContractAddress, 1, {value:auctionPrice})

    products = await bazzar.retrieveProducts()
    products = await Promise.all(products.map(async i => {
      const tokenUri = await nft.tokenURI(i.tokenId)
      let product = {
        cost: i.cost.toSring(),
        tokenId: i.cost.toString(),
        supplier: i.supplier,
        owner: i.owner,
        tokenUri
      }
      return product 
    }))
    console.log('products: ', products)
  })
})
