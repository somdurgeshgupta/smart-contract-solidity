pragma solidity ^0.4.17;
// We have to specify what version of compiler this code will compile with

contract Customer {

  /* Events */
  event OrderRaisedOrUpdated(uint idOrder);

  struct AvailableCustomer {
    uint idCustomer;
    bytes32 customerName;
  }

  struct Orderlog {
    uint idOrder;
    uint idCustomer;
    bytes32 itemName;
    uint quantity;
    bool status;
  }

  // STATE Variables.
  uint numberOfItemsPurchased;
  uint numberOfItemsReceived;

  // Mappings 
  mapping (uint => AvailableCustomer) customers;
  mapping (uint => Orderlog) orderLogs;

  /* Constructor */
  constructor() public {
      customers[0] = AvailableCustomer(1, "John Snow");
  }

  /* TRANSACTIONS */
  function purchaseItem(bytes32 itemName, uint quantity) public {
    uint idOrder = numberOfItemsPurchased++;
    orderLogs[idOrder] = Orderlog(idOrder, 0, itemName, quantity, false);
    emit OrderRaisedOrUpdated(idOrder);
  }

  function recieveItem(uint idOrder) public {
      numberOfItemsReceived++;
      orderLogs[idOrder].status = true;
      emit OrderRaisedOrUpdated(idOrder);
  }

  /* GETTERS */
  function getOrderDetails(uint idOrder) view public returns (bytes32, uint, bool){
    /*returns itemName, quantity & completionStatus*/
    return (orderLogs[idOrder].itemName, orderLogs[idOrder].quantity, orderLogs[idOrder].status);
  }

  function getNumberOfItemsPurchased() view public returns (uint) {
    return numberOfItemsPurchased;
  }

  function getNumberOfItemsReceived() view public returns (uint) {
    return numberOfItemsReceived;
  }

}
