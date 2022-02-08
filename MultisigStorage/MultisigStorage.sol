//SPDX-License-Identifier: UNLICENSED
//Made by Statfone, https://github.com/Statfone/Solidity/tree/main/MultisigStorage , please read the instructions before deploying the contract
pragma solidity ^0.7.0;

interface IERC20 {
    function totalSupply() external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract MultisigStorage {

    address private ownerAddress;
    address private constant sigAddress1 = 0x0000000000000000000000000000000000000000; //Replace by a personal address
    address private constant sigAddress2 = 0x0000000000000000000000000000000000000000; //Replace by another personal address
    address private constant sigAddress3 = 0x0000000000000000000000000000000000000000; //Replace by another personal address

    uint256 sig1Lock; //1 means locked, 0 means unlocked
    uint256 sig2Lock;
    uint256 sig3Lock;

    constructor ()  {
       ownerAddress = msg.sender;
       sig1Lock = 1;
       sig2Lock = 1;
       sig3Lock = 1;
   }
    

    modifier OwnerOnlyFunction {
        require(ownerAddress == msg.sender);
        _;
    }
    
    modifier requireSig1 {
        require(sigAddress1 == msg.sender);
        _;
    }

    modifier requireSig2 {
        require(sigAddress2 == msg.sender);
        _;
    }

    modifier requireSig3 {
        require(sigAddress3 == msg.sender);
        _;
    }

    

    //Here are the functions to unlock the multisig, you have to execute each function with the corresponding address to be able to withdraw tokens from the contract
    
    //Needed to receive gas tokens
    receive() external payable {}

    function unlockSig1() public requireSig1 {
        sig1Lock = 0;
    }

    function unlockSig2() public requireSig2 {
        sig2Lock = 0;
    }

    function unlockSig3() public requireSig3 {
        sig3Lock = 0;
    }

    //Now the function to lock the withdrawals, don't forget to execute it after a withdrawal to keep the coins inside the contract secure
    //Can only be executed by the owner address of the contract
    function lockAll() public OwnerOnlyFunction {
        sig1Lock = 1;
        sig2Lock = 1;
        sig3Lock = 1;
    }

    //Finally, the function to withdraw any token from the contract
    //The function have to be executed by the owner and the 3 sigs have to be unlocked or else it won't work
    function withdrawToken(address tokenContractAddress, uint256 amount) external OwnerOnlyFunction {
        if (sig1Lock == 0 && sig2Lock == 0 && sig3Lock == 0)
        {
            IERC20 tokenContract = IERC20(tokenContractAddress);
            tokenContract.transfer(msg.sender, amount);

            //Optional : remove the // below to lock the 3 sig again automatically after a withdrawal, it can be boring if you need to withdraw multiple tokens at the same time
            //lockAll();
        }
    }
    
    //The function to use if you want to withdraw gas token from the contract
    //The function have to be executed by the owner and the 3 sigs have to be unlocked or else it won't work
    function withdrawGasToken(uint256 amount) public OwnerOnlyFunction {
        if (sig1Lock == 0 && sig2Lock == 0 && sig3Lock == 0)
        {
            msg.sender.transfer(amount);
            //Optional : remove the // below to lock the 3 sig again automatically after a withdrawal, it can be boring if you need to withdraw multiple tokens at the same time
            //lockAll();
        }
    }
}
