pragma solidity >=0.7.0;
contract Escrow
{
    address payable public payer;
    address payable public payee;
    address payable public thirdParty;
    uint256 public amount;
    constructor(address payable sender, address payable receiver, uint256 amt) payable
    {
        payer=sender;
        payee=receiver;
        amount=amt;
        thirdParty=payable(msg.sender);
    }
    function deposit() public payable
    {
        require(payer==msg.sender, "Sender must be the payer");
        require(address(this).balance<=amount*(1 ether), "Cant send more than escrow amount");
    }
    function release() public payable
    {
        require(amount*(1 ether)==address(this).balance, "Cannot release funds before full amount is sent");
        require(thirdParty==msg.sender, "Only thirdParty can release funds");
        payee.transfer(address(this).balance);
    }
    function balanceOf() public view returns (uint256)
    {
        return address(this).balance;
    }
}
