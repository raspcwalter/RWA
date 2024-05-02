// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./RWADN404.sol";

/**
 * @title ImovelRWA
 * @notice RWA contract that implements Brazilian real estate property.  
 * 
 * Uses Vectorized´s DN404 implementation: 
 * When a user has at least one base unit (10^18) amount of tokens, they will automatically receive a NFT.
 * NFTs are minted as an address accumulates each base unit amount of tokens. 
 */

/* 
DADOS ESSENCIAIS
Nome completo do vendedor e comprador;
RG, CPF, Estado Civil, Endereço completo  de ambos; 

Condições da venda: Preço e forma de pagamento;
Apresentação de certidões negativas fiscais (Municipal, Estadual e Federal), 
além de certidão negativa de débitos trabalhistas em nome do Vendedor, 
Ações reipersecutórias e Cíveis expedidas com busca no CPF do Vendedor. 

*Todas as certidões devem ser apresentadas no momento da lavratura da escritura. 
Averbação da escritura no Registro Geral de Imóveis a ser realizada pelo comprador no prazo convencionado pelas partes.
Alteração de titularidade de impostos, taxas, contas de consumo e todos os encargos direcionados ao imóvel ( A ser realizado pelo comprador no prazo convencionado).

*/

contract ImovelRWA is RWADN404 {

    constructor(
        string memory name_,
        string memory symbol_,
        uint96 initialTokenSupply,
        address initialSupplyOwner
    ) {
      
        _type = "Real Estate Property";

        super(name_, symbol_, _type, initialTokenSupply, initialSupplyOwner);

    }

}