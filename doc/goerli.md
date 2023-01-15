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
Contract class hash: 0x1e8b0cd504bae6659006e60804b4d3175b520e8bf8b7864a8782c00535fa950
Transaction hash: 0x5c9bdb4574871e92fd1c39ec94bb33f921ef4b27a240cf67ced367a03f774e0
```
4. Deploy the contract to the existed Proxy Contract (hash=`0x5f605160db80a58acd9d975b214de49f21bda771896aae05cad856071824aee`):
```
// Input is: 
//      <implementation_hash: felt>: contract class hash of Starkatana.cairo which we declared before
//      <selector: felt>: the function selector of "initializer" in the Starkatana.cairo
//      <calldata_len: felt>: just 1
//      <calldata: felt*>: the owner address

$ starknet deploy --class_hash 0x5f605160db80a58acd9d975b214de49f21bda771896aae05cad856071824aee \
    --inputs 863441610214070251545136174121348186075702128622516726639323153321953306960 \
        1295919550572838631247819983596733806859788957403169325509326258146877103642 \
        1 \
        746150128695972069337583335793513308560513652699026313580996630894093001141 \
    --max_fee 999999995550000
```

Use Universal Deployer Contact:
```
✔ Contract Name (in the contracts folder): … UniversalDeployer
✔ Have contract class hash or not: › Yes
✔ Contract Class Hash: … 0x5f605160db80a58acd9d975b214de49f21bda771896aae05cad856071824aee
    Contract Class Hash is: 0x5f605160db80a58acd9d975b214de49f21bda771896aae05cad856071824aee
✔ Salt: … 0
✔ Unique or not: › No
✔ Constructor CallData: 
      press enter with non Constructor CallData or key elements with ","(e.g. apple, banana, papaya) … 863441610214070251545136174121348186075702128622516726639323153321953306960,1295919550572838631247819983596733806859788957403169325509326258146877103642,1,746150128695972069337583335793513308560513652699026313580996630894093001141
>
Contract Address: 0x23a5fccc6a8c9a47eb275ff4240485b8306540f006f34ec0f13f05d40a89e66
```

6. Set Token URI
```
$ starknet invoke \
    --address 0x23a5fccc6a8c9a47eb275ff4240485b8306540f006f34ec0f13f05d40a89e66 \
    --abi Starkatana_abi.json \
    --function setBaseTokenURI \
    --inputs \
        67 \
        105 112 102 115 58 47 47 98 97 102 121 98 101 105 103 118 98 111 102 117 105 53 50 52 108 103 119 99 117 103 121 122 101 105 110 111 120 104 106 108 102 97 115 117 101 99 55 101 112 54 101 98 109 54 53 50 55 108 115 107 118 117 105 51 97 117 47 \
    --max_fee 99999999555000000
```

7. Transfer Ownership
```
$ starknet invoke \
    --address 0x23a5fccc6a8c9a47eb275ff4240485b8306540f006f34ec0f13f05d40a89e66 \
    --abi Starkatana_abi.json \
    --function transferOwnership \
    --inputs 1839532911728319949577805561336351143590444159269087242333698784473075743270 \
    --max_fee 9999999955500000
```
## Appendix

```
$ ls ~/.starknet_accounts/starknet_open_zeppelin_accounts.json
```