// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ImovelRWADN404.sol";
import "./PessoaFisica.sol";
// import "./RWALib.sol";

contract ImovelSP is ImovelRWADN404 {

//    PessoaFisica[] private _partes;
        
    PessoaFisica private _comprador; 
    PessoaFisica private _vendedor; 

    constructor() ImovelRWADN404(100 * 10 ** 18, msg.sender) {
    }

    function setEnderecoPartes(address enderecoComprador_, address enderecoVendedor_) public {
        _comprador.setAddress(enderecoComprador_);
        _vendedor.setAddress(enderecoVendedor_);
    }

    function _setPartes() private {

        // comprador
        string memory nomeCompleto = "Ze das Couves";
        PessoaFisica.Data memory nascimentoComprador = PessoaFisica.Data(1970, 4, 1);
        // string dataNascimento = nascimentoComprador;
        string memory documentoCompleto = "777.777.777-77, SSP/SP";
        // _comprador.emissorRG = "SSP/SP";
        // Data memory emissaoRGComprador = Data(1980, 1, 1);
        //_comprador.dataEmissao = emissaoRGComprador;
        string memory numeroCPF = "108.832.463-09"; 
        //_comprador.statusCPF = "REGULAR";
        PessoaFisica.EstadoCivil estadoCivil = PessoaFisica.EstadoCivil.Solteiro; // solteiro
       // _comprador.enderecoPostal = EnderecoPostal("RUA", "Rua dos Bobos", 0, "", "Santa Felicidade", "Sao Paulo", "SP", "01001-01");
    //    _comprador.telefone = Telefone(55, 11, 999997777);

        _comprador = new PessoaFisica(nomeCompleto, nascimentoComprador, documentoCompleto, numeroCPF, estadoCivil);

        // vendedor
        nomeCompleto = "Ze da Esquina";
        PessoaFisica.Data memory nascimentoVendedor = PessoaFisica.Data(1975, 4, 1);
        // dataNascimento = nascimentoVendedor;
        documentoCompleto = "888.888.888-88, OAB/SP";
        //_vendedor.emissorRG = "OAB/SP";
        //Data memory emissaoRGVendedor = Data(1985, 1, 1);
        //_vendedor.dataEmissao = emissaoRGVendedor;
        numeroCPF = "213.287.835-88"; 
        //_vendedor.statusCPF = "REGULAR";
        // deveria ter documentos da cônjuge
        estadoCivil = PessoaFisica.EstadoCivil.Casado; // casado 
       // _vendedor.enderecoPostal = EnderecoPostal("RUA", "Rua dos Espertos", 10, "", "Santa Eficiencia", "Guarulhos", "SP", "01221-31");
    //    _vendedor.telefone = Telefone(55, 11, 999998888);
        _vendedor = new PessoaFisica(nomeCompleto, nascimentoVendedor, documentoCompleto, numeroCPF, estadoCivil);


    }

    function _setImovel() private {
        EnderecoPostal memory endereco_ = EnderecoPostal("Rua A, 10, Praia de Surfista, Ubatuba (SP) CEP 10777-77");

        Data memory dataEscritura_ = Data(1950, 7, 1);

        // terreno na praia de 1 mil m2 
        CaracterizacaoImovel memory descricao_ = CaracterizacaoImovel(TipoImovel.Terreno, endereco_, 10000000, 0, 
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
        _comprador.setKYC(true);
        _vendedor.setKYC(true);

        // define dono do imóvel
        setTitular(_vendedor);
        
    //    _partes.push(_comprador);
    //    _partes.push(_vendedor);

        // @todo implementar certidões (por enquanto ignora)
        // Certidao[] memory _certidoes;

        // 1 milhão de Reais = 62,6 ETH 
        Transacao memory compraEVenda_ = Transacao(TipoTransacao.CompraEVenda, _comprador, _vendedor, 100000000, 62600000000000000000, FormaPagamento.OnChain); // , _certidoes);

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