// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Base64.sol";


contract LootFromBrazil is ERC721Enumerable, ReentrancyGuard, Ownable {

    // modifier: Check if number of tokens matches
    modifier validateTokenDistribution(address[] memory _contributors) {
        require(numberOfContributorTokens + numberOfOwnerTokens + numberOfPublicTokens == totalNumberOfTokens, "Incorrect token distribution!");
        require(numberOfContributorTokens % _contributors.length == 0, "Bad Contributor token division!");
        _;
    }

    // modifier: Check if msg.sender is one of the contributors
    modifier onlyContributors {
        bool isContributor = false;
        for (uint256 i = 0; i < contributors.length; i++) {
            if (msg.sender == contributors[i]) {
                isContributor = true;
                break;
            }
        }
        require(isContributor, "Only contributors allowed!");
        _;
    }

    // modifier: Check if contributor already claimed it's tokens
    modifier checkContributorClaims {
        require(contributorClaims[msg.sender] <= numberOfContributorTokens / contributors.length, "Tokens already claimed!");
        _;
    }

    // modifier: Check if msg.sender is the contributor or owner
    modifier ownerOrContributor {
        bool isOwnerOrContributor = false;
        if (msg.sender == owner) {
            isOwnerOrContributor = true;
        } else {
            for (uint256 i = 0; i < contributors.length; i++) {
                if (msg.sender == contributors[i]) {
                    isOwnerOrContributor = true;
                    break;
                }
            }
        }
        require(isOwnerOrContributor, "Owner or contributors allowed!");
        _;
    }

    // Contributor's claims
    mapping(address => uint256) public contributorClaims;
    
    // Contributor array
    address[] public contributors;

    // Total number of tokens
    uint256 public totalNumberOfTokens = 8000;

    // Token distribution
    uint256 public numberOfPublicTokens = 7777;
    uint256 public numberOfOwnerTokens = 223;
    uint256 public numberOfContributorTokens = 0;

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

    constructor(address[] memory _contributors) 
        validateTokenDistribution(_contributors) 
        ERC721("Loot (from Brazil)", "LOOT-HUE-BR") 
        Ownable() 
    {
        // Registering contributors
        for (uint256 i = 0; i < _contributors.length; i++) {
            contributors.push(_contributors[i]);
        }

        // ------------ITEMS---------------- //
        // Initialize transportation (common, rare, epic)
        transportation = Category({
            common: [],
            rate: [],
            epic: []
        });

        // Itinialize profession (common, rare, epic)
        profession = Category({
            common: [],
            rate: [],
            epic: []
        });

        // Initialize roles
        roles = Category({
            common: [],
            rate: [],
            epic: []
        });

        // Initialize drink
        drink = Category({
            common: [],
            rate: [],
            epic: []
        });

        // Initialize accessories
        accessories = Category({
            common: [],
            rate: [],
            epic: []
        });

        // Initialize appearance
        appearance = Category({
            common: [],
            rate: [],
            epic: []
        });
        // Initialize title
        title = Category({
            common: [],
            rate: [],
            epic: []
        });

        // Initialize pet
        pet= Category({
            common: [],
            rate: [],
            epic: []
        });

        // ------------SUFFIXES-------------- //
        // Initialize transportASuffixes
        transportASuffixes = Suffix({
            rare: [],
            epic: []
        });

        // Initialize transportBSuffixes
        transportBSuffixes = Suffix({
            rare: [],
            epic: []
        });

        // Initialize rolesSuffixes
        rolesSuffixes = Suffix({
            rare: [],
            epic: []
        });

        // Initialize drinkSuffixes
        drinkSuffixes = Suffix({
            rare: [],
            epic: []
        });
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
    

//     string[] private professionSuffixes = ["corrupto", "", "", ""];

//     string[] private drinkSuffixe = ["adulteradx", "", "", ""];

    

//     function getSuffixes(uint256 tokenId, string[] memory sourceArray) public pure returns (string memory) {
//         uint256 rand = random(string(abi.encodePacked(toString(tokenId))));
//         return sourceArray[rand % sourceArray.length];
//     }
    
//     function random(string memory input) internal pure returns (uint256) {
//         return uint256(keccak256(abi.encodePacked(input)));
//     }
    
//     function getTransport(uint256 tokenId) public view returns (string memory) {
//         string memory suffixeA = getSuffixes(tokenId, transportASuffixes);
//         string memory suffixeB = getSuffixes(tokenId, transportBSuffixes);
//         return string(abi.encodePacked(pluck(tokenId, "TRANSPORT", transport), " ", suffixeA, suffixeB));
//     }
    
//     function getProfession(uint256 tokenId) public view returns (string memory) {
//         string memory suffixe = getSuffixes(tokenId, professionSuffixes);
//         return string(abi.encodePacked(pluck(tokenId, "PROFESSION", profession), " ", suffixe));
//     }
    
//     function getRoles(uint256 tokenId) public view returns (string memory) {
//         string memory suffixe = getSuffixes(tokenId, rolesSuffixes);
//         return string(abi.encodePacked(pluck(tokenId, "ROLE", roles), " ", suffixe));
//     }
    
//     function getDrink(uint256 tokenId) public view returns (string memory) {
//         string memory suffixe = getSuffixes(tokenId, drinkSuffixe);
//         return string(abi.encodePacked(pluck(tokenId, "DRINK", drink), " ", suffixe));
//     }

//     function getAccessories(uint256 tokenId) public view returns (string memory) {
//         return pluck(tokenId, "ACESSORIES", accessories);
//     }
    
//     function getAppearance(uint256 tokenId) internal view returns (string memory) {
//         return pluck(tokenId, "APPEARANCE", appearance);
//     }
    
//     function getTitle(uint256 tokenId) internal view returns (string memory) {
//         return pluck(tokenId, "TITLE", title);
//     }

//     function getPet(uint256 tokenId) internal view returns (string memory) {
//         return pluck(tokenId, "PET", pet);
//     }
    
//     function pluck(uint256 tokenId, string memory keyPrefix, string[] memory sourceArray) internal pure returns (string memory) {
//         uint256 rand = random(string(abi.encodePacked(keyPrefix, toString(tokenId))));
//         string memory output = sourceArray[rand % sourceArray.length];
//         return output;
//     }
    //</OLD CODE STRUCTURE>// 

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

        bytes32 memory outputBytes = abi.encodePacked(parts[0]);
        for (uint256 i = 1; i < parts.length; i++) {
            outputBytes = abi.encodePacked(outputBytes, parts[i]);
        }
        
        string memory json = Base64.encode(abi.encodePacked(
            "{'name': 'Bag #", 
            toString(tokenId), 
            ", 'description': 'A Brazilian meme version of Loot. We love loot <3', 'image': 'data:image/svg+xml;base64,", 
            Base64.encode(bytes(outputBytes)), "'}"));
        string memory output = string(abi.encodePacked("data:application/json;base64,", json));

        return output;
    }

    function claim(uint256 tokenId) public nonReentrant {
        require(tokenId > 0 && tokenId <= numberOfPublicTokens, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
    }
    
    function ownerClaim(uint256 tokenId) public nonReentrant onlyOwner {
        require(tokenId > numberOfPublicTokens && tokenId <= numberOfPublicTokens+numberOfOwnerTokens, "Token ID invalid");
        _safeMint(owner(), tokenId);
    }

    function contributorClaim(uint256 tokenId) public nonReentrant onlyContributors checkContributorClaims {
        require(tokenId > numberOfOwnerTokens+numberOfContributorTokens 
        && tokenId <= numberOfPublicTokens+numberOfOwnerTokens+numberOfContributorTokens, "Token ID invalid");
        _safeMint(_msgSender(), tokenId);
        contributorClaims[_msgSender()] += 1;
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
}