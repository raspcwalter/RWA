// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {DateTimeLib} from "solady/src/utils/DateTimeLib.sol";

contract RWALib {

    struct Data {
        
        uint256 ano;
        uint256 mes;
        uint256 dia; 
    }

    struct EnderecoPostal {
        string tipo; 
        string rua;
        uint16 numero;
        string complemento;
        string bairro;
        string cidade;
        string estado;
//        string pais;
        string cep;
    }

    struct PessoaFisica {
        // KYC, false is not checked or not OK, true is OK
        // maybe we need an intermediate state (checked but not OK)
        bool KYC;

        // endereço cripto
        address enderecoPessoa;
        
        string nomeCompleto;
        Data dataNascimento; 
        
        string numeroIdentidade;
        string emissorRG;
        Data dataEmissao; 

        string numeroCPF;
        string statusCPF; 
        
        string estadoCivil;
        
        EnderecoPostal enderecoPostal;
        
        // Telefone telefone; 
    }

   
    function getKYC(PessoaFisica memory pessoaFisica_) public pure returns (bool) {
        return(pessoaFisica_.KYC);
    }

    function setKYC(PessoaFisica memory pessoaFisica_, bool kyc_) public pure {
        pessoaFisica_.KYC = kyc_;
    }

}