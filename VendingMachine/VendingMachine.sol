//SPDX-License-Identifier: UNLICENSED
//Made by Statfone, https://github.com/Statfone/Solidity/tree/main/VendingMachine , please read the instructions before deploying the contract
pragma solidity ^0.7.0;

interface IERC20 {
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function balanceOf(address account) external view returns (uint256);
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract VendingMachine {

    address public ownerAddress;

    //Enter the address of the token you want to use as a currency for your vending machine below
    address private constant MONEY_ADDRESS = 0x0000000000000000000000000000000000000000;

    //Enter all the addresses of the tokens you want to sell in your vending machine
    //I minted food related tokens with 0 decimals for the exemple, but it works with any ERC20 token, just make sure to match the amounts with the decimals

    address private constant BURGER_ADDRESS = 0x0000000000000000000000000000000000000000;
    address private constant COCA_ADDRESS = 0x0000000000000000000000000000000000000000;
    address private constant FANTA_ADDRESS = 0x0000000000000000000000000000000000000000;
    address private constant FRIES_ADDRESS = 0x0000000000000000000000000000000000000000;
    address private constant HOTDOG_ADDRESS = 0x0000000000000000000000000000000000000000;
    address private constant ICECREAM_ADDRESS = 0x0000000000000000000000000000000000000000;
    address private constant POTATOES_ADDRESS = 0x0000000000000000000000000000000000000000;
    address private constant TACOS_ADDRESS = 0x0000000000000000000000000000000000000000;
    address private constant WRAP_ADDRESS = 0x0000000000000000000000000000000000000000;

    constructor ()  {
       ownerAddress = msg.sender;
   }

   modifier OwnerOnlyFunction {
        require(ownerAddress == msg.sender);
        _;
    }

    IERC20 MoneyToken = IERC20(MONEY_ADDRESS);

    //I suggest you to assign an id to each product
    IERC20 BurgerToken = IERC20(BURGER_ADDRESS); //ID:1
    IERC20 CocaToken = IERC20(COCA_ADDRESS); //ID: 2
    IERC20 FantaToken = IERC20(FANTA_ADDRESS); //ID: 3
    IERC20 FriesToken = IERC20(FRIES_ADDRESS); //ID: 4
    IERC20 HotdogToken = IERC20(HOTDOG_ADDRESS); //ID: 5
    IERC20 IcecreamToken = IERC20(ICECREAM_ADDRESS); //ID: 6
    IERC20 PotatoesToken = IERC20(POTATOES_ADDRESS); //ID: 7
    IERC20 TacosToken = IERC20(TACOS_ADDRESS); //ID: 8
    IERC20 WrapToken = IERC20(WRAP_ADDRESS); //ID: 9

    //Now this is the function to buy the products, the customer just have to enter the id of the product he wants and
    //if he have enough money tokens in his wallet and if the product is still available in the vending machine, the contract
    //will take the price of the product from the customer wallet and send him the product he bought.
    //The money will then go to the contract balance and the owner of the vending machine will be able to withdraw it using the withdrawToken() function
    function buyProduct(uint256 productId) public {
        uint256 MoneyBalance = MoneyToken.balanceOf(msg.sender);
        uint256 MoneyAllowance = MoneyToken.allowance(msg.sender, address(this));


        if (productId == 1)
        {        
            uint256 BurgerBalance = BurgerToken.balanceOf(address(this));   
            require(MoneyBalance >= 7000000000000000000 && MoneyAllowance >= 7000000000000000000, "Unable to transfer enough money from your wallet, please check the allowance.");
            require(BurgerBalance >= 1, "No more burgers in the vending machine"); //We first check if the customer have enough money and if the allowance is high enough to buy the product
            MoneyToken.transferFrom(msg.sender, address(this), 7000000000000000000);
            BurgerToken.transfer(msg.sender, 1); //We then take the money from the customer wallet and send him the product
        }
        else if (productId == 2)
        {
            uint256 CocaBalance = CocaToken.balanceOf(address(this));
            require(MoneyBalance >= 2000000000000000000 && MoneyAllowance >= 2000000000000000000, "Unable to transfer enough money from your wallet, please check the allowance.");
            require(CocaBalance >= 1, "No more Coca Cola in the vending machine");
            MoneyToken.transferFrom(msg.sender, address(this), 2000000000000000000);
            CocaToken.transfer(msg.sender, 1);
        }
        else if (productId == 3)
        {
            uint256 FantaBalance = FantaToken.balanceOf(address(this));
            require(MoneyBalance >= 2000000000000000000 && MoneyAllowance >= 2000000000000000000, "Unable to transfer enough money from your wallet, please check the allowance.");
            require(FantaBalance >= 1, "No more Fanta in the vending machine");
            MoneyToken.transferFrom(msg.sender, address(this), 2000000000000000000);
            FantaToken.transfer(msg.sender, 1);
        }
        else if (productId == 4)
        {
            uint256 FriesBalance = FriesToken.balanceOf(address(this));
            require(MoneyBalance >= 1000000000000000000 && MoneyAllowance >= 1000000000000000000, "Unable to transfer enough money from your wallet, please check the allowance.");
            require(FriesBalance >= 1, "No more Fries in the vending machine");
            MoneyToken.transferFrom(msg.sender, address(this), 1000000000000000000);
            FriesToken.transfer(msg.sender, 1);
        }
        else if (productId == 5)
        {
            uint256 HotdogBalance = HotdogToken.balanceOf(address(this));
            require(MoneyBalance >= 1000000000000000000 && MoneyAllowance >= 1000000000000000000, "Unable to transfer enough money from your wallet, please check the allowance.");
            require(HotdogBalance >= 1, "No more Hot dogs in the vending machine");
            MoneyToken.transferFrom(msg.sender, address(this), 1000000000000000000);
            HotdogToken.transfer(msg.sender, 1);
        }
        else if (productId == 6)
        {
            uint256 IcecreamBalance = IcecreamToken.balanceOf(address(this));
            require(MoneyBalance >= 2000000000000000000 && MoneyAllowance >= 2000000000000000000, "Unable to transfer enough money from your wallet, please check the allowance.");
            require(IcecreamBalance >= 1, "No more ice creams in the vending machine");
            MoneyToken.transferFrom(msg.sender, address(this), 2000000000000000000);
            IcecreamToken.transfer(msg.sender, 1);
        }
        else if (productId == 7)
        {
            uint256 PotatoesBalance = PotatoesToken.balanceOf(address(this));
            require(MoneyBalance >= 1000000000000000000 && MoneyAllowance >= 1000000000000000000, "Unable to transfer enough money from your wallet, please check the allowance.");
            require(PotatoesBalance >= 1, "No more potatoes in the vending machine");
            MoneyToken.transferFrom(msg.sender, address(this), 1000000000000000000);
            PotatoesToken.transfer(msg.sender, 1);
        }
        else if (productId == 8)
        {
            uint256 TacosBalance = TacosToken.balanceOf(address(this));
            require(MoneyBalance >= 6000000000000000000 && MoneyAllowance >= 6000000000000000000, "Unable to transfer enough money from your wallet, please check the allowance.");
            require(TacosBalance >= 1, "No more tacos in the vending machine");
            MoneyToken.transferFrom(msg.sender, address(this), 6000000000000000000);
            TacosToken.transfer(msg.sender, 1);
        }
        else if (productId == 9)
        {
            uint256 WrapBalance = WrapToken.balanceOf(address(this));
            require(MoneyBalance >= 5000000000000000000 && MoneyAllowance >= 5000000000000000000, "Unable to transfer enough money from your wallet, please check the allowance.");
            require(WrapBalance >= 1, "No more wrap in the vending machine");
            MoneyToken.transferFrom(msg.sender, address(this), 5000000000000000000);
            WrapToken.transfer(msg.sender, 1);
        }

    }

    //The function used to withdraw the money from the vending machine
    //It can be used only by the owner

    function withdrawTokens(address contractAddress, uint256 amount) external OwnerOnlyFunction {
        IERC20 tokenContract = IERC20(contractAddress);
        tokenContract.transfer(msg.sender, amount);
    }
}
