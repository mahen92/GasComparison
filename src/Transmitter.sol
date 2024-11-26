//SDPX-Identification:MIT
pragma solidity ^0.8.2;

import "../lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol";

/**
 * @title Gas Comparison
 * @author Mahendran Anbarasan
 * @notice The three methods show the gas difference when an ERC20 balance increased from 0 to any value repeatedly.
 */

contract Transmitter{
    uint256 public constant DECIMAL_PER_TOKEN = 1e18;
    IERC20 token;

    constructor(IERC20 _token){
        token = _token;
    }

    function openFaucetInefficient(address faucet,address receiver,uint256 amount) external{
        for(uint256 i=0;i<amount;i++){
               token.transferFrom(faucet,address(this),DECIMAL_PER_TOKEN);
               token.transfer(receiver,DECIMAL_PER_TOKEN);
        }
    }

    function openFaucetEfficient(address faucet,address receiver,uint256 amount) external{
        token.transferFrom(faucet,address(this),DECIMAL_PER_TOKEN);
        for(uint256 i=0;i<amount-1;i++){
               token.transferFrom(faucet,address(this),DECIMAL_PER_TOKEN);
               token.transfer(receiver,DECIMAL_PER_TOKEN);
        }
        token.transfer(receiver,DECIMAL_PER_TOKEN);
    }

    function openFaucetMoreEfficient(address faucet,address receiver,uint256 amount) external{
        token.transferFrom(faucet,address(this),DECIMAL_PER_TOKEN);
        for(uint256 i=0;i<amount-1;){
               token.transferFrom(faucet,address(this),DECIMAL_PER_TOKEN);
               token.transfer(receiver,DECIMAL_PER_TOKEN);
               unchecked{
                ++i;
               }
        }
        token.transfer(receiver,DECIMAL_PER_TOKEN);
    }
}