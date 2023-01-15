# Start the Journey

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
$ export STARKNET_NETWORK=alpha-mainnet
$ export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount
$ starknet tx_status --hash 0x06802a9e4aa641692c315746b7e8a60467d4d52b9d660ec978a76e951b786dde
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
Contract class hash: 0x48d517b07b068823d8fd5a16ab36fc1ad54beac4c7b67ae1b565d896049144d
Transaction hash: 0x1b7719426356d13cba94f6542374e61776a50ca26abcad7b9b8d1da0828e787
```
4. Deploy the contract to the existed Proxy Contract (hash=`0x5f605160db80a58acd9d975b214de49f21bda771896aae05cad856071824aee`):
```
// Input is: 
//      <implementation_hash: felt>: contract class hash of Starkatana.cairo which we declared before
//      <selector: felt>: the function selector of "initializer" in the Starkatana.cairo
//      <calldata_len: felt>: just 1
//      <calldata: felt*>: the owner address

$ starknet deploy --class_hash 0x5f605160db80a58acd9d975b214de49f21bda771896aae05cad856071824aee \
    --inputs 2058939188804104020451372711084395701589198825543277815008102578631712773197 \
        1295919550572838631247819983596733806859788957403169325509326258146877103642 \
        1 \
        1364268300915883459795326175301153127756446113008068701215986546232874415127 \
    --max_fee 999999995550000
```

Use Universal Deployer Contact:
```
- Class Hash:
2696243724147144744408832412117296600246354962449852542208996972633079827182
- Constructor Calldata:
2058939188804104020451372711084395701589198825543277815008102578631712773197,1295919550572838631247819983596733806859788957403169325509326258146877103642,1,1364268300915883459795326175301153127756446113008068701215986546232874415127
>
Contract Address: 0x73d11b8c0128a2b2751bdac9f42b1ca72d9f8a55f382fd83ece608622dce23c
```

6. Set Token URI
```
$ starknet invoke \
    --address 0x73d11b8c0128a2b2751bdac9f42b1ca72d9f8a55f382fd83ece608622dce23c \
    --abi Starkatana_abi.json \
    --function setBaseTokenURI \
    --inputs \
        67 \
        105 112 102 115 58 47 47 98 97 102 121 98 101 105 103 118 98 111 102 117 105 53 50 52 108 103 119 99 117 103 121 122 101 105 110 111 120 104 106 108 102 97 115 117 101 99 55 101 112 54 101 98 109 54 53 50 55 108 115 107 118 117 105 51 97 117 47 \
    --max_fee 99999999555000000
>

```

## Appendix

```
$ ls ~/.starknet_accounts/starknet_open_zeppelin_accounts.json
```