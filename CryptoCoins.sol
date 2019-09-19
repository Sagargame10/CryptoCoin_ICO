// CryptoCoins ICO

// Version of Compiler
pragma solidity ^0.4.11;

contract CryptoCoin_ico{
    
    // Maximum number of ico's available 
    uint public max_cryptocoins = 1000000;
    
    // Conversion : USD(or Rupees, but USD is prefered as internationally USD is accepted) to CryptoCoins
    uint public usd_to_cryptocoins = 1000;
    
    // Total CryptoCoins bought by investors 
    uint public total_cryptocoins_bought = 0;
    
    // Mapping from the investors address to its equity in CryptoCoins and USD
    mapping(address => uint) equity_cryptocoin;
    mapping(address => uint) equity_USD;
    
    // Check whether investors can buy CryptoCoins or not
    modifier can_buy_cryptocoins(uint usd_invested) 
    { 
        require((usd_invested * usd_to_cryptocoins) + total_cryptocoins_bought <= max_cryptocoins );
        _;
    }
    
    // Getting the equity in CryptoCoins of investors
    function equity_in_cryptocoin(address investor) external constant returns(uint)  // constant for "address of investor" since it is constant
    {
        return equity_cryptocoin[investor];
    }
    
    // Getting the equity in USD of investors
    function equity_in_usd(address investor) external constant returns(uint)  
    {
        return equity_USD[investor];
    }   
    
    // Buying CryptoCoins
    function buy_cryptocoins(address investor,uint usd_invested) external 
    can_buy_cryptocoins(usd_invested){                                   // modifier "can_buy_cryptocoins" attached to the function 
        uint cryptocoins_bought = (usd_invested*usd_to_cryptocoins);
        equity_cryptocoin[investor] += cryptocoins_bought;
        equity_USD[investor] = (equity_cryptocoin[investor]/usd_to_cryptocoins);
        total_cryptocoins_bought += cryptocoins_bought;
    }
    
    // Selling CryptoCoins
    function sell_cryptocoins(address investor,uint cryptocoins_sold) external 
    {
        equity_cryptocoin[investor] -= cryptocoins_sold;
        equity_USD[investor] = (equity_cryptocoin[investor]/usd_to_cryptocoins);
        total_cryptocoins_bought -= cryptocoins_sold; 
    }
}