pragma solidity 0.5.1;

import "./Storage.sol";

contract Dogs is Storage {

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function getNumberOfDogs() public view returns (uint256) {
        return _uintStorage["Dogs"];
    }

    function setNumberOfDogs(uint256 numberOfDogs) public {
        _uintStorage["Dogs"] = numberOfDogs;
    }
}
