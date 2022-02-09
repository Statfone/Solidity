Hello, i'm Statfone and this is my vending machine contract, you can use it to sell any ERC20 token you want at a fixed price, and use the token you want as the currency used in the vending machine.

Before deploying the contract, remember to edit the product sold in the vending machine to your addresses, dont forget to change the prices in the buyProduct() function too. Also make sure
to respect the number of decimals, my money token is 18 decimals and for the products, i minted 0 decimals tokens, both of them can be changed but don't forget to edit the prices and amount sent
if you do so.

Now, how to use it after the deployement of the contract:

As the owner:
- You just have to send the products you want to sell to the vending machine contract, the customers will then be able to buy your products, and the money will go in the vending machine contract.
- To withdraw the money or the products from the vending machine, just use the withdrawToken() function


As a customer:
- First, you must approve enough of the money tokens for the vending machine contract address
- Then, just use the buyProduct() function with the id of the product you want to buy, the vending machine will take the price of the product from your wallet and send you the product you bought.

