const Dogs = artifacts.require("Dogs"); //truffle looks for contract name not the filename
const Proxy = artifacts.require("Proxy");
const DogsUpdated = artifacts.require("DogsUpdated");

module.exports = async (deployer, network, accounts) => {
  const dogs = await Dogs.new(); //deployer.deploy(Dogs);
  const proxy = await Proxy.new( dogs.address ); 

  //create instance of Dog contract but do it from an existing deployed contract (//fooling truffle to belive proxy contract is really a dog contract)
  //proxyDog is really pointing to the proxy
  var proxyDog = await Dogs.at(proxy.address); 
  
  //send request through proxy but
  await proxyDog.setNumberOfDogs(10);

  var nrOfDogs = await proxyDog.getNumberOfDogs();

  console.log("from proxy >>>",nrOfDogs.toNumber())

  nrOfDogs = await dogs.getNumberOfDogs();

  console.log("from underlying contract storage (will differ)>>>",nrOfDogs.toNumber()) //will differ because the storage is actually in the proxy contract!
  
  //update the contract

  const dogsUpdated = await DogsUpdated.new();
  await proxy.upgradeContract(dogsUpdated.address);
  
  //fool truffle again, it now thinks proxyDog has all functions
  proxyDog = await DogsUpdated.at(proxy.address); 
  
  //initialize proxy state so it has same "owner" state as contract
  await proxyDog.initialize(accounts[0]);
  
  //check setter works with new upgraded contract
  await proxyDog.setNumberOfDogs(30);


  nrOfDogs = await proxyDog.getNumberOfDogs();
  console.log("from proxy and updated contract >>>",nrOfDogs.toNumber())

  
  //await proxyDog.setNumberOfDogs(30, {from: accounts[1]}); //should fail because account[1] not the owner

};
