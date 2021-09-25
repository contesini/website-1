
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

abstract contract Categories {
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
        transportation = Category({
            common: [],
            rare: [],
            epic: []
        });

        // Itinialize profession (common, rare, epic)
        profession = Category({
            common: [],
            rare: [],
            epic: []
        });

        // Initialize roles
        roles = Category({
            common: [],
            rare: [],
            epic: []
        });

        // Initialize drink
        drink = Category({
            common: [],
            rare: [],
            epic: []
        });

        // Initialize accessories
        accessories = Category({
            common: [],
            rare: [],
            epic: []
        });

        // Initialize appearance
        appearance = Category({
            common: [],
            rare: [],
            epic: []
        });
        // Initialize title
        title = Category({
            common: [],
            rare: [],
            epic: []
        });

        // Initialize pet
        pet= Category({
            common: [],
            rare: [],
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
}