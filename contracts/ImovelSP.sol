// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ImovelRWADN404.sol";

contract ImovelSP is ImovelRWADN404 {

    PessoaFisica[] private _partes;
        
    PessoaFisica private _comprador; 
    PessoaFisica private _vendedor; 

    constructor() ImovelRWADN404(100 * 10 ** 18, msg.sender) {
    }

    function setEnderecoPartes(address enderecoComprador_, address enderecoVendedor_) public {
        _comprador.enderecoPessoa = enderecoComprador_;
        _vendedor.enderecoPessoa = enderecoVendedor_;
    }

    function _setPartes() private {

        // comprador
        _comprador.nomeCompleto = "Ze das Couves";
        Data memory nascimentoComprador = Data(1970, 4, 1);
        _comprador.dataNascimento = nascimentoComprador;
        _comprador.numeroIdentidade = "777.777.777-77";
        _comprador.emissorRG = "SSP/SP";
        Data memory emissaoRGComprador = Data(1980, 1, 1);
        _comprador.dataEmissao = emissaoRGComprador;
        _comprador.numeroCPF = "108.832.463-09"; 
        _comprador.statusCPF = "REGULAR";
        _comprador.estadoCivil = "solteiro";
        _comprador.enderecoPostal = EnderecoPostal("RUA", "Rua dos Bobos", 0, "", "Santa Felicidade", "Sao Paulo", "SP", "Brasil", "01001-01");
        _comprador.telefone = Telefone(55, 11, 999997777);

        // vendedor
        _vendedor.nomeCompleto = "Ze da Esquina";
        Data memory nascimentoVendedor = Data(1975, 4, 1);
        _vendedor.dataNascimento = nascimentoVendedor;
        _vendedor.numeroIdentidade = "888.888.888-88";
        _vendedor.emissorRG = "OAB/SP";
        Data memory emissaoRGVendedor = Data(1985, 1, 1);
        _vendedor.dataEmissao = emissaoRGVendedor;
        _vendedor.numeroCPF = "213.287.835-88"; 
        _vendedor.statusCPF = "REGULAR";
        _vendedor.estadoCivil = "casado"; // deveria ter documentos da cônjuge
        _vendedor.enderecoPostal = EnderecoPostal("RUA", "Rua dos Espertos", 10, "", "Santa Eficiencia", "Guarulhos", "SP", "Brasil", "01221-31");
        _vendedor.telefone = Telefone(55, 11, 999998888);

    }

    function _setImovel() private {
        EnderecoPostal memory endereco_ = EnderecoPostal("rua", "Rua A", 10, "", "Praia de Surfista", "Ubatuba", "SP", "Brasil", "10777-77");

        Data memory dataEscritura_ = Data(1950, 7, 1);

        // terreno na praia de 1 mil m2 
        CaracterizacaoImovel memory descricao_ = CaracterizacaoImovel("terreno", endereco_, 10000000, 0, "terreno a beira mar", 
            "terreno a beira mar na Praia de Surfiista de Ubatuba", dataEscritura_);

        setCaracterizacaoImovel(descricao_);
    }
       
    function criaTransacao(address enderecoComprador_, address enderecoVendedor_) public returns(Transacao memory t) {

        setEnderecoPartes(enderecoComprador_, enderecoVendedor_);

        // terreno na praia
        _setImovel();

        // define as partes 
        _setPartes();

        // KYC 
        setKYC(_comprador, true);
        setKYC(_vendedor, true);

        // define dono do imóvel
        setTitular(_vendedor);
        
        _partes.push(_comprador);
        _partes.push(_vendedor);

        // @todo implementar certidões (por enquanto ignora)
        Certidao[] memory _certidoes;

        // 1 milhão de Reais = 62,6 ETH 
        Transacao memory compraEVenda_ = Transacao("compra e venda", _partes, 100000000, 62600000000000000000, "a vista", "on chain", _certidoes);

        return(compraEVenda_);
    }

    function compraVendaTerreno(address payable enderecoComprador_, address payable enderecoVendedor_) public payable {
        Transacao memory t = criaTransacao(enderecoComprador_, enderecoVendedor_);

        uint256 precoImovelETH_ = t.valorETH;
        (bool success, bytes memory data) = enderecoVendedor_.call{value: precoImovelETH_}("compra e venda imovel");
        require(success, "Falha ao enviar ether!"); 

        if (success) {
            _historicoTransacoes.push(t);
            setTitular(_comprador);
        }

    }
}