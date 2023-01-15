# Starkatana

## Explanation

### URI
- `contractURI`: Contract Metadata (Information) IPFS link
```JSON
{
  "name": "Starkatana",
  "description": "Starkatana launched as the NFTs collection on StarkNet in 2023. A Revolution Is About To Erupt.",
  "image": "https://pbs.twimg.com/profile_image/...",
  "banner_image_url": "https://pbs.twimg.com/profile_banner/...",
  "external_link": "<official_website>",
  "seller_fee_basis_points": 1000,
  "fee_recipient": "<owner>"
}
```
- `baseTokenURI`: Token Metadata IPFS **CID**, which means the folder storing the metadata
- `tokenURI`:  Token Metadata IPFS link, with is the `baseTokenURI`(CID) + `tokenID`
```JSON
{
    "name": "Starkatana #<tokenID>",
    "description": "Starkatana launched as the NFTs collection on StarkNet in 2023. A Revolution Is About To Erupt.",
    "image": "ipfs://bafybeiemirme4sfwuwom7f4oz25ddixmaisukvq76wfjq7qp2wxyco4qsm/<tokenID>.png",
    "attributes": [
        {
            "trait_type": "Races",
            "value": "<tokenRaces>"
        },
        {   
            "trait_type": "Aether Color",
            "value": "<tokenAetherColor>"
        },
        {
            "trait_type": "Rarity",
            "value": "<tokenRarity>"
        }
    ]
}
```

