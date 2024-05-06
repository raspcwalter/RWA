import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const RWALibModule = buildModule("RWALibModule", (m) => {

  const lib = m.contract("RWALib");

  return { lib };
});

export default RWALibModule;
