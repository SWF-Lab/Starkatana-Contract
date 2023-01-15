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
Contract class hash: 0x7070dc855d251fa1ec8ba8ebbfb84e0d2ecd8e7d339cefff195229ec8f2edbc
Transaction hash: 0x64ef6ee0511245e51d0860c32a9d128a8a0a7a4ad2d858d3c74a9f70e893156
```
4. Deploy the contract to the existed Proxy Contract (hash=`0x5f605160db80a58acd9d975b214de49f21bda771896aae05cad856071824aee`):
```
// Input is: 
//      <implementation_hash: felt>: contract class hash of Starkatana.cairo which we declared before
//      <selector: felt>: the function selector of "initializer" in the Starkatana.cairo
//      <calldata_len: felt>: just 1
//      <calldata: felt*>: the owner address

$ starknet deploy --class_hash 0x5f605160db80a58acd9d975b214de49f21bda771896aae05cad856071824aee \
    --inputs 3178652993266220629476114653829251756821046710105508678145114204628770287036 \
        1295919550572838631247819983596733806859788957403169325509326258146877103642 \
        1 \
        746150128695972069337583335793513308560513652699026313580996630894093001141 \
    --max_fee 999999995550000
```

Use Universal Deployer Contact:
```
- Class Hash:
0x5f605160db80a58acd9d975b214de49f21bda771896aae05cad856071824aee
- Constructor Calldata:
3178652993266220629476114653829251756821046710105508678145114204628770287036,1295919550572838631247819983596733806859788957403169325509326258146877103642,1,746150128695972069337583335793513308560513652699026313580996630894093001141
>
Contract Address: 0x647f4b4a6cbe94aa0daff9e018329de74aa648c860ee58e726673a360865191
```

6. Set Token URI
```
$ starknet invoke \
    --address 0x647f4b4a6cbe94aa0daff9e018329de74aa648c860ee58e726673a360865191 \
    --abi Starkatana_abi.json \
    --function setBaseTokenURI \
    --inputs \
        67 \
        105 112 102 115 58 47 47 98 97 102 121 98 101 105 103 118 98 111 102 117 105 53 50 52 108 103 119 99 117 103 121 122 101 105 110 111 120 104 106 108 102 97 115 117 101 99 55 101 112 54 101 98 109 54 53 50 55 108 115 107 118 117 105 51 97 117 47 \
    --max_fee 99999999555000000
>
Invoke transaction was sent.
Contract address: 0x0647f4b4a6cbe94aa0daff9e018329de74aa648c860ee58e726673a360865191
Transaction hash: 0x1d51651a5ce21f076ef2a9df81fe7c1f3da3d30c0d334de245874c49f75f9c3
```

7. Transfer Ownership
```
$ starknet invoke \
    --address 0x647f4b4a6cbe94aa0daff9e018329de74aa648c860ee58e726673a360865191 \
    --abi Starkatana_abi.json \
    --function transferOwnership \
    --inputs 1364268300915883459795326175301153127756446113008068701215986546232874415127 \
    --max_fee 9999999955500000
```
## Appendix

```
$ ls ~/.starknet_accounts/starknet_open_zeppelin_accounts.json
```