Hello, i'm Statfone and this is a smart contract i created which you can use to perform swaps on 2 dex at the same time in only one transaction

Here's how to make it work:
1 - Send the ERC20 tokens you will need to swap (BEP20 or similar works too since the chain you're using is evm based) DO NOT send any gas token to the contract
2 - From the address you used to deploy the contract, call the multiDexSwap function of the contract with the following arguments: amountIn (uint256), minAmountOut (uint256), TokenIn (address), TokenSwap (address), TokenOut (address), dexIn (address), dexOut (address)

amountIn : The amount of TokenIn which will be swapped
minAmountOut : The minimal amount of TokenOut you will get after the 2 swaps. If this amount is not reached when the transaction is processed, any of the 2 swaps will be executed
TokenSwap : The token which the contract will obtain after the swap on dexIn, which will be immediatly swapped for TokenOut on dexOut
dexIn : The router of the dex which will be used to swap TokenIn for TokenSwap
dexOut : The router of the dex which will be used to swap TokenSwap for TokenOut

3 - To withdraw the tokens inside the contract to you address, call the withdrawToken function of the contract with the following arguments : amount (uint256), tokenContractAddress (address)

Both functions can only be used by the owner, which is set by default to the address used to deploy the contract, so if you plan to use it, don't forget to call it from the owner address.


