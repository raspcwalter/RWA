import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const ImovelSPModule = buildModule("ImovelSPModule", (m) => {

  const imovel = m.contract("ImovelSP");

  return { imovel };
});

export default ImovelSPModule;
