import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const PessoaFisicaModule = buildModule("PessoaFisicaModule", (m) => {

  const pf = m.contract("PessoaFisica");

  return { pf };
});

export default PessoaFisicaModule;
