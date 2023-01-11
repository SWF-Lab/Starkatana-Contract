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
Contract class hash: 0x12d232009efb35c1668480c9ab829dc947d5d1a71efd6966de4677006f02ab4
Transaction hash: 0x247a2626f7e199156b3f267aaa8a097390d9cab6283d6ca1e16e50495a3856c
```
4. Compile & Declare the Proxy Contract to get the contract class hash:
```
$ cd ../Proxy // To the proxy contract folder
$ starknet-compile Proxy.cairo \
    --output Proxy_compiled.json \
    --abi Proxy_abi.json
$ starknet declare --contract Proxy_compiled.json --max_fee 999999995550000
>
Declare transaction was sent.
Contract class hash: 0x77fdf98d9646ae428afd0377d041999c0e1e67af9d360fa2c556f156c1adb4c
Transaction hash: 0x7e2f53e1abe2e49641e230abf4a2c5295890c1bb06b9b98193f67570a987381
```
5. Deploy the contract:
```
// Input is: 
//      <implementation_hash: felt>: contract class hash of Starkatana.cairo which we declared before
//      <selector: felt>: the function selector of "initialize()" in the Starkatana.cairo
//      <calldata_len: felt>: just 1
//      <calldata: felt*>: the owner address
$ starknet deploy --class_hash 0x77fdf98d9646ae428afd0377d041999c0e1e67af9d360fa2c556f156c1adb4c \
    --input 0x \
        215307247182100370520050591091822763712463273430149262739280891880522753123 \
        1 \
        0x \
    --max_fee 999999995550000
>

```