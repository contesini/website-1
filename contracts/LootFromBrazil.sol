// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Base64.sol";


contract LootFromBrazil is ERC721Enumerable, ReentrancyGuard, Ownable {


    // Structure for the item category
    struct Category {
        string[] common;
        string[] rare;
        string[] epic;
    }

    // Structure for the item suffix
    struct Suffix {
        string[] rare;
        string[] epic;
    }

    // Categories
    Category private transportation;
    Category private profession;
    Category private roles;
    Category private drink;
    Category private accessories;
    Category private appearance;
    Category private title;
    Category private pet;

    // Suffixes
    Suffix private transportASuffixes;
    Suffix private transportBSuffixes;
    Suffix private rolesSuffixes;
    Suffix private drinkSuffixes;

    constructor() {
        // ------------ITEMS---------------- //
        // Initialize transportation (common, rare, epic)
        transportation.common = [];
        transportation.rare = [];
        transportation.epic = [];

        // Itinialize profession (common, rare, epic)
        profession.common = [];
        profession.rare = [];
        profession.epic = [];

        // Initialize roles
        roles.common = [];
        roles.rare = [];
        roles.epic = [];

        // Initialize drink
        drink.common = [];
        drink.rare = [];
        drink.epic = [];

        // Initialize accessories
        accessories.common = [];
        accessories.rare = [];
        accessories.epic = [];

        // Initialize appearance
        appearance.common = [];
        appearance.rare = [];
        appearance.epic = [];

        // Initialize title
        title.common = [];
        title.rare = [];
        title.epic = [];

        // Initialize pet
        pet.common = [];
        pet.rare = [];
        pet.epic = [];

        // ------------SUFFIXES-------------- //

        // Initialize transportASuffixes
        transportASuffixes.rare = [];
        transportASuffixes.epic = [];

        // Initialize transportBSuffixes
        transportBSuffixes.rare = [];
        transportBSuffixes.epic = [];

        // Initialize rolesSuffixes
        rolesSuffixes.rare = [];
        rolesSuffixes.epic = [];

        // Initialize drinkSuffixes
        drinkSuffixes.rare = [];
        drinkSuffixes.epic = [];
    }

    //<OLD CODE STRUCTURE>//

//     string[] private transport = [
//         "charrete",
//         "jumento",
//         "brasilia amarela", 
//         "fusca",
//         "busao",
//         "camaro amarelo", 
//         "tobata",
//         "CG-150",
//         "uno",
//         "citroen",
//         "rr",
//         "hornet",
//         "1100",
//         "kawasaki",
//         "bandit"
//     ];
    
//     string[] private profession = [
//         "mendigo",
//         "estudante",
//         "flanelinha",
//         "politico",
//         "empresario",
//         "professor",
//         "gamer",
//         "tiktoker",
//         "youtuber",
//         "boneca",
//         "day-trader",
//         "fogueteiro",
//         "uber",
//         "aviaozinho",
//         "militante",
//         "seguranca de balada",
//         "cafetao",
//         "concursado",
//         "pastor",
//         "padre",
//         "rabino",
//         "jornaleiro"
//     ];
    
//     string[] private roles = [
//         "barzinho",
//         "rave",
//         "baile funk", 
//         "micareta",
//         "frevo",
//         "luau",
//         "culto"
//     ];
    
//     string[] private drink = [
//         "agua",
//         "leite",
//         "gim",
//         "catuaba",
//         "breja",
//         "vinho",
//         "tequila",
//         "velho guerreiro",
//         "whisky",
//         "kombucha"
//     ];
	
// 	string[] private accessories = [
//         "tr3s 8tao",
//         "12 mola",
//         "rolex",
//         "ray-ban",
//         "corrente de ouro 14K",
//         "iphone",
//         "xaiomi",
//         "radinho"
// 	];
	
//     string[] private appearance = [
//         "anao",
//         "gordx",
//         "altx",
//         "magrx",
//         "desnutridx",
//         "maromba",
//         "tchutchuca",
//         "paniquete",
//         "cabeca de pika"
//     ];
    
//     string[] private title = [
// 	    "crente",
// 	    "maconheirx",
// 	    "macumbeirx",
// 	    "cachaceirx",
// 	    "roqueirx",
// 	    "pagodeirx",
// 	    "rolezeirx",
// 	    "fofoqueirx",
// 	    "nerd"
//     ];

//     string[] private pet = [
//         "viralata caramelo", 
//         "capivara",
//         "louro jose", 
//         "cacatua",
//         "gato",
//         "cachorro",
//         "bem-te-vi",
//         "sabia",
//         "galinha",
//         "chupa cu",
//         "et de varginha",
//         "et bilu"
//     ];
    
//    string[] private transportASuffixes = [
//         "",
//         "",
//         "",
//         "",
//         "",
//         "",
//         "",
//         "",
//         "",
//         "",
//         "",
//         "",
//         "",
//         "usado ",
//         "quebrado ",
//         "zero "
//     ];

//     string[] private transportBSuffixes = [
//         "",
//         "",
//         "",
//         "",
//         "",
//         "",
//         "rebaixado",
//         "turbinado",
//         "para nunca",
//         "com escada"
//     ];

//     string[] private rolesSuffixes = [
//         "",
//         "",
//         "",
//         "",
//         "",
//         "",
//         "chic",
//         "vagabunda"
//     ];
    //</OLD CODE STRUCTURE>// 

    string[] private professionSuffixes = ["corrupto", "", "", ""];

    string[] private drinkSuffixe = ["adulteradx", "", "", ""];

    function getSuffixes(uint256 tokenId, string[] memory sourceArray) public pure returns (string memory) {
        uint256 rand = random(string(abi.encodePacked(toString(tokenId))));
        return sourceArray[rand % sourceArray.length];
    }
    
    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }
    
    function getTransport(uint256 tokenId) public view returns (string memory) {
        string memory suffixeA = getSuffixes(tokenId, transportASuffixes);
        string memory suffixeB = getSuffixes(tokenId, transportBSuffixes);
        return string(abi.encodePacked(pluck(tokenId, "TRANSPORT", transport), " ", suffixeA, suffixeB));
    }
    
    function getProfession(uint256 tokenId) public view returns (string memory) {
        string memory suffixe = getSuffixes(tokenId, professionSuffixes);
        return string(abi.encodePacked(pluck(tokenId, "PROFESSION", profession), " ", suffixe));
    }
    
    function getRoles(uint256 tokenId) public view returns (string memory) {
        string memory suffixe = getSuffixes(tokenId, rolesSuffixes);
        return string(abi.encodePacked(pluck(tokenId, "ROLE", roles), " ", suffixe));
    }
    
    function getDrink(uint256 tokenId) public view returns (string memory) {
        string memory suffixe = getSuffixes(tokenId, drinkSuffixe);
        return string(abi.encodePacked(pluck(tokenId, "DRINK", drink), " ", suffixe));
    }

    function getAccessories(uint256 tokenId) public view returns (string memory) {
        return pluck(tokenId, "ACESSORIES", accessories);
    }
    
    function getAppearance(uint256 tokenId) internal view returns (string memory) {
        return pluck(tokenId, "APPEARANCE", appearance);
    }
    
    function getTitle(uint256 tokenId) internal view returns (string memory) {
        return pluck(tokenId, "TITLE", title);
    }

    function getPet(uint256 tokenId) internal view returns (string memory) {
        return pluck(tokenId, "PET", pet);
    }
    
    function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
        uint256 rand = random(string(abi.encodePacked(keyPrefix, toString(tokenId))));
        string memory output = sourceArray[rand % sourceArray.length];
        return output;
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string[17] memory parts;
        parts[0] = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width='100%' height='100%' fill='black' /><text x='10' y='20' class='base'>";

        parts[1] = getTransport(tokenId);

        parts[2] = "</text><text x='10' y='40' class='base'>";

        parts[3] = getProfession(tokenId);

        parts[4] = "</text><text x='10' y='60' class='base'>";

        parts[5] = getRoles(tokenId);

        parts[6] = "</text><text x='10' y='80' class='base'>";

        parts[7] = getDrink(tokenId);

        parts[8] = "</text><text x='10' y='100' class='base'>";

        parts[9] = getAccessories(tokenId);

        parts[10] = "</text><text x='10' y='120' class='base'>";

        parts[11] = getAppearance(tokenId);

        parts[12] = "</text><text x='10' y='140' class='base'>";

        parts[13] = getTitle(tokenId);

        parts[14] = "</text><text x='10' y='160' class='base'>";

        parts[15] = getPet(tokenId);

        parts[16] = "</text></svg>";

        string memory output = string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6], parts[7], parts[8]));
        output = string(abi.encodePacked(output, parts[9], parts[10], parts[11], parts[12], parts[13], parts[14], parts[15], parts[16]));
        
        string memory json = Base64.encode(bytes(string(abi.encodePacked("{'name': 'Bag #", toString(tokenId), ", 'description': 'A Brazilian meme version of Loot. We love loot <3', 'image': 'data:image/svg+xml;base64,", Base64.encode(bytes(output)), "'}"))));
        output = string(abi.encodePacked("data:application/json;base64,", json));

        return output;
    }

    function claim(uint256 tokenId) public nonReentrant {
        require(tokenId > 0 && tokenId < 7778, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }
    
    function ownerClaim(uint256 tokenId) public nonReentrant onlyOwner {
        require(tokenId > 7777 && tokenId < 8001, "Token ID invalid");
        _safeMint(owner(), tokenId);
    }
    
    function toString(uint256 value) internal pure returns (string memory) {
    // Inspired by OraclizeAPI's implementation - MIT license
    // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
    
    constructor() ERC721("Loot (for Brazilians)", "LOOT-HUE-BRL") Ownable() {}
}