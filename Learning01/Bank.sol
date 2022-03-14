//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
/*
 A Simple Bank Application using Solidity for learning purpose 
*/
interface iBank{
    function deposit(address _address,uint _value) external;
    function withdraw(address _address,uint _value) external;
    function getBalance(address _address) external  view returns(uint);
}

contract PersonalDetails {
    
    struct PersonalInfo{        
        string name;
        uint age;   
        uint balance;
        uint accountID;
    }   
    
    uint private AccountId ;
    
    mapping(address => PersonalInfo) public AccountDetails;
    function setPersonalDetails(address _address,string memory _name,uint _age) public {
        AccountId +=1;
        AccountDetails[_address].name=_name;
        AccountDetails[_address].age=_age;        
        AccountDetails[_address].accountID=AccountId;        
    }    
    
}


contract Bank is PersonalDetails,iBank{
    
    uint private value;
    // deposit
    function deposit(address _address,uint _amount) override public {
        AccountDetails[_address].balance+=_amount;
    }
    // withdraw
    function withdraw(address _address,uint _amount) CheckBalance(_address,_amount) override public {
        AccountDetails[_address].balance -= _amount;
    }
    //get balance
    function getBalance(address _address) public override view returns (uint) {
        return AccountDetails[_address].balance;
    }

    // modifier to check the value before withdraw    
    modifier CheckBalance(address _address, uint _amount){
        require(getBalance(_address)>=_amount,"Your Balance is very low compared to the existing balance");
        _;
    }
    

}
