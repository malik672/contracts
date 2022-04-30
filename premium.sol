pragma solidity >=0.4.22 <0.9.0; 

//a contract to add premium address to a dapp i.e premium accounts for a movie site
contract Premium{
    address public owner;
    uint256 public premiumAmount;
    address concAdd;

    //mapping of user address to balance
    mapping(address => uint256) balances;
 
    //constructor to set premium price and contract owner
    constructor() public{
      owner = msg.sender;
      premiumAmount = 5000000000000000 wei;
      concAdd = address(this);
    }

    //modifier for only owner to set premium price
    modifier onlyOwner(){
     require(msg.sender == owner, "only owner set price");
     _;
    }

    //struct for suscriber
    struct Subscriber{
        address subscribe;
        bool isPremium;
    } 

  
    //mapping os user address to struct
    mapping(address => Subscriber) public checkPremium;

    //function to set premiumAmount
    function setAmount(uint256 _amount) public onlyOwner  {
      premiumAmount = _amount;
    }

    //function for contract to receive ether
    receive()external payable{}


    //function to pay premium amount
    function payPremium() payable public returns(bool){
      require(msg.sender != address(0));
      checkPremium[msg.sender].isPremium = true;
      require(msg.value == premiumAmount,"insufficient funds");
      address contrac = address(this);
      (bool success,) = payable(contrac).call{value: premiumAmount}("");
      require(success, "Failed to send money");
     
      
      

      return checkPremium[msg.sender].isPremium;
    }
} 
