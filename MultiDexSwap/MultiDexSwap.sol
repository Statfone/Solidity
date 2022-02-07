//SPDX-License-Identifier: UNLICENSED
//Made by Statfone, https://github.com/Statfone/Solidity/tree/main/MultiDexSwap , please read the instructions before deploying the contract
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

interface IUniswapV2Router {
  function getAmountsOut(uint256 amountIn, address[] memory path)
    external
    view
    returns (uint256[] memory amounts);
  
  function swapExactTokensForTokens(

    uint256 amountIn,
    uint256 amountOutMin,
    address[] calldata path,
    address to,
    uint256 deadline
  ) external returns (uint256[] memory amounts);
}

//Begining of the contract
contract MultiDexSwap {
    
    address private owneraddress; 

    //Setting up the ownership of the contract to the address which deploys it, only this one will be able to use this contract
    constructor ()  {
       owneraddress = msg.sender;
   }

   modifier OwnerOnlyFunction {
        require(owneraddress == msg.sender);
        _;
    }


    //This will be the function to use to perform a multi dex swap
    //The function works like this, enter amountIn and minAmountOut, a path of 3 tokens then the addresses of the routers of the dex In and Out
    //Then the tokens will be swapped like this : Path[0] to Path[1] on dexIn, then Path[1] to Path[2] on dexOut
    function multiDexSwap (uint256 amountIn, uint256 minAmountOut, address TokenIn, address TokenSwap, address TokenOut, address dexIn, address dexOut) external OwnerOnlyFunction {
        //First we will get the current amount out at the time the transaction is mined
        uint256 currentAmountOut;
        uint256 currentAmountSwap;
        address[] memory pathIn;
        address[] memory pathOut;
        pathIn = new address[](2);
        pathIn[0] = TokenIn;
        pathIn[1] = TokenSwap;
        pathOut = new address[](2);
        pathOut[0] = TokenSwap;
        pathOut[1] = TokenOut;

        currentAmountSwap = IUniswapV2Router(dexIn).getAmountsOut(amountIn, pathIn)[1];
        currentAmountOut = IUniswapV2Router(dexOut).getAmountsOut(currentAmountSwap, pathOut)[1];
        if (currentAmountOut >= minAmountOut) {
          IERC20(TokenIn).approve(dexIn, amountIn);
          IUniswapV2Router(dexIn).swapExactTokensForTokens(amountIn, currentAmountSwap, pathIn, address(this), block.timestamp);
          IERC20(TokenSwap).approve(dexOut, currentAmountSwap);
          IUniswapV2Router(dexOut).swapExactTokensForTokens(currentAmountSwap, minAmountOut, pathOut, address(this), block.timestamp);
          //The 2 swaps are executed at the same time only if the amount out of the 2nd swap is at least the minAmountOut, else none of the swaps are executed
          //To withdraw the swapped tokens, use the WithdrawToken function
        }

    }


    //Function to use to remove any ERC20 token from this contract to your address, can be used by the adddress which deployed the contract only
    function withdrawToken (uint256 amount, address tokenContractAddress) external OwnerOnlyFunction {
        IERC20 tokenContract = IERC20(tokenContractAddress);
        tokenContract.transfer(msg.sender, amount);

    }

}
