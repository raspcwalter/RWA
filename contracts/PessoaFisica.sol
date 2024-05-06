// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract PessoaFisica {

    struct Data {
        uint256 ano;
        uint256 mes;
        uint256 dia; 
    }

    enum EstadoCivil {
        Solteiro, 
        Casado, 
        Divorciado,
        Separado
    }

        // KYC, false is not checked or not OK, true is OK
        // maybe we need an intermediate state (checked but not OK)
        bool _KYC;

        // endereço cripto
        address _endereco;
        
        string public nomeCompleto;
        Data public dataNascimento; 
        
        string public documentoCompleto;
        /* string numeroIdentidade;
        string emissorRG;
        Data dataEmissao; */ 

        string public numeroCPF;
    //    string statusCPF; 
        
        EstadoCivil public estadoCivil;
        
    //    EnderecoPostal enderecoPostal;
        
    //    Telefone telefone;

        constructor(string memory nome_, Data memory dn_, string memory rg_, string memory cpf_, EstadoCivil civil_) {
            nomeCompleto = nome_;
            dataNascimento = dn_;
            documentoCompleto = rg_;
            numeroCPF = cpf_;
            estadoCivil = civil_;
        }

    function getKYC() public view returns (bool) {
        return(_KYC);
    }

    function setKYC(bool kyc_) public {
        _KYC = kyc_;
    }

    function getAddrees() public view returns (address) {
        return(_endereco);
    }

    function setAddress(address endereco_) public {
        _endereco = endereco_;
    }
 
    }
