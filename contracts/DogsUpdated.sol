pragma solidity 0.5.1;

import "./Storage.sol";


/* 
this contract is overly explicit and could simply be written as:

import "./Dogs.sol";

contract DogsUpdated is Dogs {

    constructor() public {
        initialize(msg.sender);
    }

    //in here is how you tell proxy about the state
    function initialize(address _owner) public{
        require(!_initialized);
        owner = _owner; // this is for the DogsUpdated
        _initialized = true; // this is for the Proxy
    }

    function setNumberOfDogs(uint256 numberOfDogs) public onlyOwner {
        _uintStorage["Dogs"] = numberOfDogs;
    }


*/


contract DogsUpdated is Storage {

    modifier onlyOwner(){
        require(msg.sender == owner, "must be owner");
        _;
    }

    constructor() public {
        initialize(msg.sender);
    }

    //in here is how you tell proxy about the state
    function initialize(address _owner) public{
        require(!_initialized);
        owner = _owner; // this is for the DogsUpdated
        _initialized = true; // this is for the Proxy
    }

    function getNumberOfDogs() public view returns (uint256) {
        return _uintStorage["Dogs"];
    }

    function setNumberOfDogs(uint256 numberOfDogs) public onlyOwner {
        _uintStorage["Dogs"] = numberOfDogs;
    }
}
