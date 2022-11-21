// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract PaymentSplitter {
    address payable[] public recipients;
    event TransferReceived(address _from, uint _amount);

    constructor(address payable[] memory _addresses) {
        for (uint i = 0; i < _addresses.length; i++) {
            recipients.push(_addresses[i]);
        }
    }

    receive() external payable {
        uint256 share = msg.value / recipients.length;

        for (uint i = 0; i < recipients.length; i++) {
            recipients[i].transfer(share);
        }

        emit TransferReceived(msg.sender, msg.value);
    }
}
