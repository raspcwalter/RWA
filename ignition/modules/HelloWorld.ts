import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const HelloWorldModule = buildModule("HelloWorldModule", (m) => {

  const hello = m.contract("HelloWorld");

  return { hello };
});

export default HelloWorldModule;
