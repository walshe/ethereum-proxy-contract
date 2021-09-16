pragma solidity 0.5.1;

/**
    Cannot be updated
 */
contract Storage{

    mapping(string => uint256) _uintStorage;
    mapping(string => address) _addressStorage;
    mapping(string => bool) _bollStorage;
    mapping(string => string) _stringStorage;
    mapping(string => bytes4) _bytesStorage;

    address public owner;
    bool _initialized;
    
}