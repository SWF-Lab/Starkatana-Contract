# Starkatana

## Start the Journey

1. Prepare the development environment:
```bash
$ python3.9 -m venv myENV
$ source myENV/bin/activate
$ python --version
> Python 3.9.15 // ✅

$ pip install cairo-lang
$ pip install openzeppelin-cairo-contracts
```

2. Setting the Starknet CLI:
```bash
$ export STARKNET_NETWORK=alpha-goerli
$ export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount
$ starknet tx_status --hash 0x7067a0b671587f52adc49f11d79eb17b5df86820fc3bf0e71b82f460cc40738
> Print the tx which is accepted in L1 // ✅
```

3. Compile & Declare the Token Contract:
```bash
$ starknet-compile Starkatana.cairo \
    --output Starkatana_compiled.json \
    --abi Starkatana_abi.json
$ starknet declare --contract Starkatana_compiled.json --max_fee 999999995550000
>
Declare transaction was sent.
Contract class hash: 0x4f583696b59f2c3b81becd117c14b95933d186111eff633d215e7a0e3fdb2d2
Transaction hash: 0x9ed286c1869e96e0a01a671ff98f07cc1318383ca0f6122299289208037e10
```

4. Change the `string` to `felt` for constructor calldata:
```python
$ python
>>> from nile.utils import str_to_felt
>>> str_to_felt('Starkatana')
394103262183566193290849
>>> str_to_felt('SK')
21323
```

5. Deploy the contract:
```bash
\\ $ starknet deploy --class_hash <Class_Hash> \
\\    --inputs <name: felt> <symbol: felt> <owner: felt>

$ starknet deploy --class_hash 0x4f583696b59f2c3b81becd117c14b95933d186111eff633d215e7a0e3fdb2d2 \
    --inputs 394103262183566193290849 21323 0x01a64e56778a3d208caac766f4f211a227f27eb89598f91393ff038dd0c7e1b5 \
    --max_fee 999999995550000
>
Sending the transaction with max_fee: 0.000714 ETH (714047439973103 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 
Transaction hash: 
```