// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ImovelRWADN404.sol";

import {RWALib} from "./RWALib.sol";

contract ImovelSP is ImovelRWADN404 {

    RWALib.PessoaFisica[] private _partes;
        
    RWALib.PessoaFisica private _comprador; 
    RWALib.PessoaFisica private _vendedor; 

    constructor() ImovelRWADN404(100 * 10 ** 18, msg.sender) {
    }

    function setEnderecoPartes(address enderecoComprador_, address enderecoVendedor_) public {
        _comprador.enderecoPessoa = enderecoComprador_;
        _vendedor.enderecoPessoa = enderecoVendedor_;
    }

    function _setPartes() private {

        // comprador
        _comprador.nomeCompleto = "Ze das Couves";
        RWALib.Data memory nascimentoComprador = RWALib.Data(1970, 4, 1);
        _comprador.dataNascimento = nascimentoComprador;
        _comprador.numeroIdentidade = "777.777.777-77";
        _comprador.emissorRG = "SSP/SP";
        RWALib.Data memory emissaoRGComprador = RWALib.Data(1980, 1, 1);
        _comprador.dataEmissao = emissaoRGComprador;
        _comprador.numeroCPF = "108.832.463-09"; 
        _comprador.statusCPF = "REGULAR";
        _comprador.estadoCivil = "solteiro";
        _comprador.enderecoPostal = RWALib.EnderecoPostal("RUA", "Rua dos Bobos", 0, "", "Santa Felicidade", "Sao Paulo", "SP", "01001-01");
    //    _comprador.telefone = Telefone(55, 11, 999997777);

        // vendedor
        _vendedor.nomeCompleto = "Ze da Esquina";
        RWALib.Data memory nascimentoVendedor = RWALib.Data(1975, 4, 1);
        _vendedor.dataNascimento = nascimentoVendedor;
        _vendedor.numeroIdentidade = "888.888.888-88";
        _vendedor.emissorRG = "OAB/SP";
        RWALib.Data memory emissaoRGVendedor = RWALib.Data(1985, 1, 1);
        _vendedor.dataEmissao = emissaoRGVendedor;
        _vendedor.numeroCPF = "213.287.835-88"; 
        _vendedor.statusCPF = "REGULAR";
        _vendedor.estadoCivil = "casado"; // deveria ter documentos da cônjuge
        _vendedor.enderecoPostal = RWALib.EnderecoPostal("RUA", "Rua dos Espertos", 10, "", "Santa Eficiencia", "Guarulhos", "SP", "01221-31");
    //    _vendedor.telefone = Telefone(55, 11, 999998888);

    }

    function _setImovel() private {
        RWALib.EnderecoPostal memory endereco_ = RWALib.EnderecoPostal("rua", "Rua A", 10, "", "Praia de Surfista", "Ubatuba", "SP", "10777-77");

        RWALib.Data memory dataEscritura_ = RWALib.Data(1950, 7, 1);

        // terreno na praia de 1 mil m2 
        CaracterizacaoImovel memory descricao_ = CaracterizacaoImovel("terreno", endereco_, 10000000, 0, "terreno a beira mar", 
            "terreno a beira mar na Praia de Surfista", dataEscritura_);

        setCaracterizacaoImovel(descricao_);
    }
       
    function criaTransacao(address enderecoComprador_, address enderecoVendedor_) public returns(Transacao memory t) {

        setEnderecoPartes(enderecoComprador_, enderecoVendedor_);

        // terreno na praia
        _setImovel();

        // define as partes 
        _setPartes();

        // KYC 
        RWALib.setKYC(_comprador, true);
        RWALib.setKYC(_vendedor, true);

        // define dono do imóvel
        setTitular(_vendedor);
        
        _partes.push(_comprador);
        _partes.push(_vendedor);

        // @todo implementar certidões (por enquanto ignora)
        // Certidao[] memory _certidoes;

        // 1 milhão de Reais = 62,6 ETH 
        Transacao memory compraEVenda_ = Transacao("compra e venda", _partes, 100000000, 62600000000000000000, "a vista", "on chain"); // , _certidoes);

        return(compraEVenda_);
    }

/*    function compraVendaTerreno(address payable enderecoComprador_, address payable enderecoVendedor_) public payable {
        Transacao memory t = criaTransacao(enderecoComprador_, enderecoVendedor_);

        uint256 precoImovelETH_ = t.valorETH;
        (bool success, bytes memory data) = enderecoVendedor_.call{value: precoImovelETH_}("compra e venda imovel");
        require(success, "Falha ao enviar ether!"); 

        if (success) {
            _historicoTransacoes.push(t);
            setTitular(_comprador);
        }

    } */
}