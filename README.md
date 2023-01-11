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
Contract class hash: 0x12d232009efb35c1668480c9ab829dc947d5d1a71efd6966de4677006f02ab4
Transaction hash: 0x247a2626f7e199156b3f267aaa8a097390d9cab6283d6ca1e16e50495a3856c
```

4. Deploy the contract:
```bash
\\ $ starknet deploy --class_hash <Class_Hash>

$ starknet deploy --class_hash 0x12d232009efb35c1668480c9ab829dc947d5d1a71efd6966de4677006f02ab4 \
    --max_fee 999999995550000
>

```