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

## Start the Journey

1. Prepare the development environment:
```
$ python3.9 -m venv myENV
$ source myENV/bin/activate
$ python --version
> Python 3.9.15 // ✅

$ pip install cairo-lang
$ pip install openzeppelin-cairo-contracts
```

2. Setting the Starknet CLI:
```
$ export STARKNET_NETWORK=alpha-goerli
$ export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount
$ starknet tx_status --hash 0x7067a0b671587f52adc49f11d79eb17b5df86820fc3bf0e71b82f460cc40738
> Print the tx which is accepted in L1 // ✅
```

3. Compile & Declare the Token Contract to get the contract class hash:
```
$ cd Logic // To the starknet implementation contract folder
$ starknet-compile Starkatana.cairo \
    --output Starkatana_compiled.json \
    --abi Starkatana_abi.json
$ starknet declare --contract Starkatana_compiled.json --max_fee 999999995550000
>
Declare transaction was sent.
Contract class hash: 0x63d0a86658d3d4a6021fcf3ae3c1acd92aeb012662fa6dc2653e35203f02a2
Transaction hash: 0x25a4cc7ef520bee1485e2cdae30846184db4874b6f608082372eb1cc0c689e2
```
4. Deploy the contract to the existed Proxy Contract (hash=`0x5f605160db80a58acd9d975b214de49f21bda771896aae05cad856071824aee`):
```
// Input is: 
//      <implementation_hash: felt>: contract class hash of Starkatana.cairo which we declared before
//      <selector: felt>: the function selector of "initializer" in the Starkatana.cairo
//      <calldata_len: felt>: just 1
//      <calldata: felt*>: the owner address

$ starknet deploy --class_hash 0x5f605160db80a58acd9d975b214de49f21bda771896aae05cad856071824aee \
    --inputs 176357962702627816401336130717389041404265252562120594167038387363659055778 \
        1295919550572838631247819983596733806859788957403169325509326258146877103642 \
        1 \
        1190032577508977998252422876849379676461610928276148882343076591873421236258 \
    --max_fee 999999995550000
```

176357962702627816401336130717389041404265252562120594167038387363659055778,1295919550572838631247819983596733806859788957403169325509326258146877103642,1,746150128695972069337583335793513308560513652699026313580996630894093001141

6. Set Token URI
```
$ cd ../Logic
$ starknet invoke \
    --address 0x3cc67d021a54a64b63d77b20feb3700fbb65a3652f69203a9388ec26d3daee3 \
    --abi Starkatana_abi.json \
    --function setBaseTokenURI \
    --inputs \
        67 \
        105 112 102 115 58 47 47 98 97 102 121 98 101 105 103 118 98 111 102 117 105 53 50 52 108 103 119 99 117 103 121 122 101 105 110 111 120 104 106 108 102 97 115 117 101 99 55 101 112 54 101 98 109 54 53 50 55 108 115 107 118 117 105 51 97 117 47
>
Sending the transaction with max_fee: 0.001401 ETH (1400923872295864 WEI).
Invoke transaction was sent.
Contract address: 0x02c0d94a1b27d8f264145b3acd16ec18713872f9161123fb3a42459a3c9cd0cf
Transaction hash: 0x4634110a9b7ea29f7a136501eb7e12128fcff3f68d8afd2371780846cf9dccd
```

## Appendix

```
$ ls ~/.starknet_accounts/starknet_open_zeppelin_accounts.json
```