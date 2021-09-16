pragma solidity 0.5.1;

import "./Storage.sol";

contract Proxy is Storage {
    
    address currentAddress;
    
    constructor(address _currentAddress) public {
        currentAddress = _currentAddress;
    
    }

    
    function upgradeContract(address _newAddress) public {
        currentAddress = _newAddress;
    }

    // fallback function to catch all function calls that don't exist
    // will redirect to current address
    function () payable external{
        address implementation = currentAddress;
        require(implementation != address(0));
        bytes memory data = msg.data;

        assembly {
            //0x20 is 32 which needs to be added to data
            //mload is memory load function
            let result := delegatecall(gas, implementation, add(data, 0x20), mload(data), 0, 0)
            let size := returndatasize
            let ptr := mload(0x40)
            returndatacopy(ptr, 0 ,size)
            switch result
            case 0 {revert(ptr,size)}
            default {return(ptr,size)}
        }
    }
}