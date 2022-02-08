//SPDX-License-Identifier: UNLICENSED
//Made by Statfone, https://github.com/Statfone/Solidity/tree/main/SellOwnershipWithEscrow , please read the instructions before deploying the contract
pragma solidity ^0.7.0;

interface IContractSold {
    function getOwner() external view returns (address);
    function transferOwnership(address newOwner) external;
}

contract SellOwnershipWithEscrow {

    //The buyer of the seller will fill the 3 correct addresses before deploying
    address payable public constant sellerAddress = 0x0000000000000000000000000000000000000000;
    address payable public constant buyerAddress = 0x0000000000000000000000000000000000000000;
    address public constant soldContractAddress = 0x0000000000000000000000000000000000000000;

    //Set the price asked by the seller here
    uint256 public constant contractPrice = 1 * 10 ** 18;

    uint256 public isOwnershipTransfered = 1;
    uint256 public isPaymentMade = 1;
    uint256 public isTradeFinished = 1;

    modifier isBuyer {
        require(buyerAddress == msg.sender);
        _;
    }

    modifier isSeller {
        require(sellerAddress == msg.sender);
        _;
    }

    //Needed to receive gas tokens
    receive() external payable {}

    //Here's the function the seller will use to prove he has transfered the ownership of the contract he wants to sell to the contract address
    function confirmOwnershipTransfer() external isSeller {
        IContractSold SoldContract = IContractSold(soldContractAddress);
        address currentOwnerAddress;
        currentOwnerAddress = SoldContract.getOwner();
        if (currentOwnerAddress == address(this))
        {
            isOwnershipTransfered = 0;
        }
    }

    //The function which the buyer will use to prove he made the payment
    function confirmPayment() public isBuyer {
        uint256 contractBalance = address(this).balance;
        if (contractBalance >= contractPrice)
        {
            isPaymentMade = 0;
        }

    }


    //A function the seller can use to get back the ownership of the contract sold if the buyer don't complete the payment
    function retractOwnership() external isSeller {
        if(isPaymentMade == 1 && isOwnershipTransfered == 0)
        {
            IContractSold SoldContract = IContractSold(soldContractAddress);
            SoldContract.transferOwnership(sellerAddress);
            isOwnershipTransfered = 1;
        }
    }

    //A function the buyer can use to get his money back if he completed the payment but the seller didn't transfered the ownership to the contract
    function retractPayment() public isBuyer {
        if(isPaymentMade == 0 && isOwnershipTransfered == 1)
        {
            uint256 contractBalance = address(this).balance;
            buyerAddress.transfer(contractBalance);
            isPaymentMade = 1;
        }
    }

    //The function to execute after both buyer and seller confirmed their payment / ownership transfer
    function sealTheDeal() external{
        if (isPaymentMade == 0 && isOwnershipTransfered == 0)
        {
            IContractSold SoldContract = IContractSold(soldContractAddress);
            SoldContract.transferOwnership(buyerAddress);
            uint256 contractBalance = address(this).balance;
            sellerAddress.transfer(contractBalance);
            isTradeFinished = 0;
        }
    }


}
