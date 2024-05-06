// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// source for DN-404: https://github.com/Vectorized

// install packages dn404 and solady:
// npm install Vectorized/dn404 
// npm install Vecotrized/solady

import "dn404/src/DN404.sol";
import "dn404/src/DN404Mirror.sol";
import {Ownable} from "solady/src/auth/Ownable.sol";
import {LibString} from "solady/src/utils/LibString.sol";
import {SafeTransferLib} from "solady/src/utils/SafeTransferLib.sol";

import {DateTimeLib} from "solady/src/utils/DateTimeLib.sol";

import {RWALib} from "./RWALib.sol";

/**
 * @title RWADN404
 * @notice DN404 RWA contract that implements RWA abstract tokens. 
 * 
 * DN404 implementation: 
 * When a user has at least one base unit (10^18) amount of tokens, they will automatically receive a NFT.
 * NFTs are minted as an address accumulates each base unit amount of tokens. 
 */

 contract ImovelRWADN404 is DN404, Ownable {

    string internal _name;
    string internal _symbol;
    string internal _baseURI;

    // real estate, vehicle, art
    string internal constant _TYPE = "Real Estate"; // for now only this type of RWA

    // titular do imóvel
    RWALib.PessoaFisica private _titular;
    // descrição imóvel
    CaracterizacaoImovel private _descricao;
    // histórico de transações
    Transacao[] public _historicoTransacoes;

    // mapeamento tokens RWA => transações
//    mapping(ImovelRWADN404 => Transacao[]) _registroTransacoes;


/*    struct Telefone {
        uint256 codigoInternacional;
        uint256 codigoLocal; // DDD
        uint256 numeroTelefone;
    } */

     struct CaracterizacaoImovel {
        // casa, apartamento, terreno
        string tipo; 
        RWALib.EnderecoPostal enderecoPostal;
        // areas em cm2, 1 m2 = 10.000 cm2
        uint256 areaTerreno;
        uint256 areaConstruida;
        // quartos, bnaheiros, sala, cozinha, garagem, etc. 
        // dúvida: o melhor seria ter diversas variáveis inteiras, quartos, salas, cozinha, etc.? 
        string distribuicao;   
        string descricaoDetalhada;
        // data de constituição do imóvel (e.g. habite-se de casa/apartamento, demarcação terreno, etc.)
        RWALib.Data dataImovel;
    }

    struct Transacao {
        // tipo de transação: "compra e venda", "alienação", etc. 
        string tipo;

        RWALib.PessoaFisica[] partes;

        // valor da transação em centavos (1 R$ = 100 centavos)
        uint256 valorBRL;
        // valor em ETH no momento da transação (ETH c/ 18 zeros, ou seja, em gwei)
        uint256 valorETH; 
        // forma de pagamento: "à vista, parcelado, financiado, etc."
        string formaPagamento;
        // condições da transação
        string condicoesTransacao;

    //    Certidao[] certidoes; 
    }

/*   struct Certidao {
        // descrição da certidão
        string descricao;
        string orgaoCertidao;
        RWALib.PessoaFisica titularCertidao;
        // negativa, positiva com efeito de negativa, etc. 
        string statusCertidao;
        // pendências: dívida ativa, ... 
        string pendenciasCertidao;
        RWALib.Data emissaoCertidao;
        RWALib.Data validadeCertidao;

        // URI 
        string certidaoURI;
    } */
    
    constructor(
    //    string memory name_,
    //    string memory symbol_,
    //    string memory type_,
        uint96 initialTokenSupply,
        address initialSupplyOwner
    ) {
        _initializeOwner(msg.sender);

        _name = "Imovel RWA DNA-404"; //name_;
        _symbol = "IRWADN404"; // symbol_;
    //    _type = type_;

        address mirror = address(new DN404Mirror(msg.sender));
        _initializeDN404(initialTokenSupply, initialSupplyOwner, mirror);
    }

    function name() public view override returns (string memory) {
        return _name;
    }

    function symbol() public view override returns (string memory) {
        return _symbol;
    }

    function getRWAType() public pure returns (string memory) {
        return _TYPE;
    }
    
    function getTitultar() public view returns(RWALib.PessoaFisica memory t) {
        return(_titular);
    }

    function setTitular(RWALib.PessoaFisica memory titular_) public onlyOwner {
        _titular = titular_;
    }

    function getCaracterizacaoImovel() public view returns(CaracterizacaoImovel memory c) {
        return(_descricao);
    }

    function setCaracterizacaoImovel(CaracterizacaoImovel memory descricao_) public onlyOwner {
        _descricao = descricao_;
    }

//    function pushTransacao(Transacao memory t_) public onlyOwner {
//        _historicoTransacoes.push(t_);
//    }

    // ###########################################################################################
    function _tokenURI(uint256 tokenId) internal view override returns (string memory result) {
        if (bytes(_baseURI).length != 0) {
            result = string(abi.encodePacked(_baseURI, LibString.toString(tokenId)));
        }
    }

    // This allows the owner of the contract to mint more tokens.
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function setBaseURI(string calldata baseURI_) public onlyOwner {
        _baseURI = baseURI_;
    }

    function withdraw() public onlyOwner {
        SafeTransferLib.safeTransferAllETH(msg.sender);
    }
    // ###########################################################################################
}
