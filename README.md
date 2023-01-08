# Starkatana

## Start the Journey

1. Prepare the development environment:
```bash
$ python3.9 -m venv myENV
$ source myENV/bin/activate
$ python --version
> Python 3.9.15 // ✅

$ pip install cairo-lang
$ export STARKNET_NETWORK=alpha-goerli
$ export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount
$ starknet tx_status --hash 0x7067a0b671587f52adc49f11d79eb17b5df86820fc3bf0e71b82f460cc40738
> Print the tx which is accepted in L1 // ✅
```

2. Compile & Declare the Token Contract
```bash
$ starknet-compile Starkatana.cairo \
    --output Starkatana_compiled.json \
    --abi Starkatana_abi.json
$ starknet declare --contract Starkatana_compiled.json
>
Sending the transaction with max_fee: 0.000156 ETH (156109659823106 WEI).
Declare transaction was sent.
Contract class hash: 0x340c199c1c3495bce67566a83f7ac7817a49d89864e3f05b9f264a2c33c1300
Transaction hash: 0x1005c5219fbfbb1f1dbfc7329c8b69f66073aae2143a3ce7e891d3ff19da421
```

3. Change the `string` to `felt` for constructor calldata:
```python
$ python
>>> from nile.utils import str_to_felt
>>> str_to_felt('Starkatana')
394103262183566193290849
>>> str_to_felt('SK')
21323
```

4. Deploy the contract
```bash
\\ $ starknet deploy --class_hash <Class_Hash> \
\\    --inputs <name: felt> <symbol: felt> <decimals> <initial_supply> <recipient>

$ starknet deploy --class_hash 0x340c199c1c3495bce67566a83f7ac7817a49d89864e3f05b9f264a2c33c1300 \
    --inputs 394103262183566193290849 21323 18 1000 0 0x6368016dcd1e3846aedc4b4828fb15ff6397a096424870e59da68f3ff40d7ee
>
Sending the transaction with max_fee: 0.000714 ETH (714047439973103 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 
Transaction hash: 
```