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
Contract class hash: 0x4229b650a78aee137327921789c3c18397a3e72b80aacd72eaab924ee0111d0
Transaction hash: 0x64a20dda73865025169a3b158350aa46b4e056daef80689facac198b6d58da3
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
Transaction hash: 0x348ee78ff584e615a03e5535a6cfef9d5af2fdb8c1d90f8e13da7dd88185153
```
5. Deploy the contract:
```
// Input is: 
//      <implementation_hash: felt>: contract class hash of Starkatana.cairo which we declared before
//      <selector: felt>: the function selector of "initializer" in the Starkatana.cairo
//      <calldata_len: felt>: just 1
//      <calldata: felt*>: the owner address
$ export OWNER=746150128695972069337583335793513308560513652699026313580996630894093001141
$ starknet deploy --class_hash 0x5f605160db80a58acd9d975b214de49f21bda771896aae05cad856071824aee \
    --inputs 0x4229b650a78aee137327921789c3c18397a3e72b80aacd72eaab924ee0111d0 \
        1295919550572838631247819983596733806859788957403169325509326258146877103642 \
        1 \
        $OWNER \
    --max_fee 999999995550000
```

6. Set Token URI
```
$ cd ../Logic
$ starknet invoke \
    --address 0x2c0d94a1b27d8f264145b3acd16ec18713872f9161123fb3a42459a3c9cd0cf \
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