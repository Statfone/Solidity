Hello, i'm Statfone and this is my multi sig storage smart contract code.
It can be used to store your coins in a more secure way than keeping them on your address.
When ERC20 tokens are sent to this contract, the only way to withdraw them is to execute the 3 unlock functions with the 3 addresses specified on the contract, then to execute the WithdrawToken function with the owner address. The tokens will then be transfered to the owner address.
There's no ways for the owner address to withdraw coins if the 3 others addresses haven't executed their unlock functions, and those 3 addresses won't be able to remove tokens at any time.

/!\ BEFORE DEPLOYING THE CONTRACT /!\
- Replace the 3 0x000000000000000000000000000000 sigAddresses by 3 public addresses you have access to, these 3 addresses will be needed to unlock your tokens
- Optional : Go to the bottom of the contract at the withdrawToken function and remove the // before the lockAll(); if you want the contract to lock again after a withdraw, if you plan to store multiple coins in the contract, leave it as it is.

Now you can deploy it

/!\ BEFORE SENDING MASSIVE AMOUNTS OF COINS TO THE CONTRACT, TEST WITH SMALL AMOUNTS TO VERIFY YOU SET UP EVERYTHING CORRECTLY /!\ 
The contract is composed of different functions:

unlockSig1,2,3() : These 3 functions are used to unlock the withdrawal of tokens, you will have to call the 3 with the corresponding addresses before a withdrawal or the tokens won't be transfered
lockAll() : The function used to lock again all 3 addresses after a withdraw, can be executed by the owner only
withdrawToken(tokenContractAddress, amount) : The function used to withdraw tokens from the contract, can be executed by the owner only if the sig1,2,3 are unlocked
