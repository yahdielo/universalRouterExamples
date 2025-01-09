# uniswap Universal Router examples

the uniswap universalRouter allow us to swap v2, v3 , v4 and nfts all from one router.
the uniswap universal router is signicanlty diferrent  from the regular SwapRouters.

the idea of this repo is to provide a base contract for people wanting to interact with the uniswap **UniversalRouter**, saving them hours of finding out as all interfaces needed to swap tokens are rigth here.

**NOTE**:
currenlty allows swaps on v2swap eth->erc20 
*to add*
v3 eth<->token

v3 token<->token

v2 token<->token

## Running the test
foundry allow us to test our contract by forking the current state of the network , you can run this test on any evm chain.
but you will have to change the contract addresses for the corresponding ones.

**to run test**:   forge test -vvvvv  --fork-url <your_rpc_provider>
