
# eth-proxy-contract

Demonstrates using a proxy pattern to build an upgradeable contract.

Original Dogs contract has a normal setNumberOfDogs() function.

The new version of the contract DogsUpdated has a new onlyOwner modifier feature on the setNumberOfDogs() function. 


## notes

DogsUpdated checks that the setter is called by the owner using the owner variable in inherited Storage

Since we are usign delegatecall however , it checks for the owner in the Proxy's owner variable which is not set. 

We need to initialize the proxy so that it has info about the owner. We do this with an initialize function in the DogsUpdated contract.

## local deployment

    truffle develop //simulate a local blockchain on our computer

    migrate --reset


