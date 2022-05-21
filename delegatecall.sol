// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// NOTE: Deploy this contract first
contract Delegate {
    // NOTE: storage layout must be the same as contract Origin
    uint public num;
    address public sender;
    uint public value;

    function setVariables(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract Origin{
    uint public num;
    address public sender;
    uint public value;

    function setVariables(address _contract, uint _num) public payable {
        // Origin's storage is set, Delegate is not modified.
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVariables(uint256)", _num)
        );
    }
}
