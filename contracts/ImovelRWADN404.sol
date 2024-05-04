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

/**
 * @title RWADN404
 * @notice DN404 RWA contract that implements RWA abstract tokens. 
 * 
 * DN404 implementation: 
 * When a user has at least one base unit (10^18) amount of tokens, they will automatically receive a NFT.
 * NFTs are minted as an address accumulates each base unit amount of tokens. 
 */

 abstract contract ImovelRWADN404 is DN404, Ownable {

    string internal _name;
    string internal _symbol;
    string internal _baseURI;

    // real estate, vehicle, art
    string internal constant _TYPE = "Real Estate"; // for now only this type of RWA

    struct Data {
        uint256 ano;
        uint256 mes;
        uint256 dia; 
    }

    struct Telefone {
        uint256 codigoInternacional;
        uint256 codigoLocal; // DDD
        uint256 numeroTelefone;
    }

    struct PessoaFisica {
        // KYC, false is not checked or not OK, true is OK
        // maybe we need an intermediate state (checked but not OK)
        bool KYC;

        // endereço cripto
        address enderecoPessoa;
        
        string nomeCompleto;
        
        string numeroIdentidade;
        string emissorRG;
        Data dataEmissao; 
        
        string estadoCivil;
        
        EnderecoPostal enderecoPostal;
        
        Telefone telefone; 
    }

    struct EnderecoPostal {
        string tipo; 
        string rua;
        uint16 numero;
        string complemento;
        string bairro;
        string cidade;
        string estado;
        string pais;
        string cep;
    }
    
    constructor(
        string memory name_,
        string memory symbol_,
        string memory type_,
        uint96 initialTokenSupply,
        address initialSupplyOwner
    ) {
        _initializeOwner(msg.sender);

        _name = name_;
        _symbol = symbol_;
        _type = type_;

        address mirror = address(new DN404Mirror(msg.sender));
        _initializeDN404(initialTokenSupply, initialSupplyOwner, mirror);
    }

    function name() public view override returns (string memory) {
        return _name;
    }

    function symbol() public view override returns (string memory) {
        return _symbol;
    }

    function getRWAType() public view returns (string memory) {
        return _type;
    }
    
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

    function getKYC(PessoaFisica memory pessoaFisica_) public view returns (bool) {
        return(pessoaFisica_.KYC);
    }
}
