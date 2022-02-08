Hello, i'm Statfone and this is my contract which allows you to buy or sell the ownership of a token in a safe and decentralized way. 

The only requirement for the ownership to be transfered if the contract you want to buy/sell contain the following functions :
- function getOwner() returns (address)
- function transferOwnership(address)

Now, the buyer or the seller need to fill the address (sellerAddress, buyerAddress, soldContractAddress) and also the contract price (in gas tokens).
The buyer/seller will then publish the contract code on the explorer so the seller/buyer will be able to view if the buyer/seller/soldContractAddress are correct, and if the price
is the same as decided.

The seller will then transfer the ownership of the contract he wants to sold to the escrow contract, then he will execute the confirmOwnershipTransfer() function so the escrow contract will
check if he's the owner of the sold contract.

The buyer will then send the price the seller asked for to the escrow contract (In gas tokens only, ERC20 tokens are not supported by the escrow contract currently). After sending enough coins
to the contract to match the price asked, the buyer will execute the confirmPayment() function to update the escrow contract and confirm that there's enough tokens in the escrow contract 
balance to pay the seller.

When both buyer and seller have confirmed their actions on the smart contract, anyone will be able to complete the trade by executing the sealTheDeal() function. This function will work
only if the buyer confirmed the payment and if the seller confirmed the ownership transfer. The ownership of the sold contract will then be transfered to the buyer address and the payment 
will be sent to the seller address.

SECURITY :

There's 2 functions made to protect both buyer and seller from getting scammed:
- retractOwnership() : This function will work if the seller transfered the ownership to the escrow but the buyer didn't sent the payment. The escrow will then reassign the seller as the sold contract owner
- retractPayment() : This function is used to send the payment back to the buyer if the seller didn't confirmed the ownership transfer

To be able to retract the payment or ownership, you need to confirm it in the first place

Reminder:
/!\ Before interacting with the escrow contract, make sure all the addresses and price have been filled correctly and that the rest of the code is the same /!\  
