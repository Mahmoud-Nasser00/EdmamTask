//
//  Reciepe.swift
//  EdmamTask
//
//  Created by Mahmoud Nasser on 6/30/20.
//  Copyright © 2020 Mahmoud Nasser. All rights reserved.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct RecipeModel: Codable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
    let bookmarked, bought: Bool
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let shareAs: String
    let yield: Double
    let dietLabels: [String]
//    let healthLabels: [HealthLabel]
    let cautions, ingredientLines: [String]
    let ingredients: [Ingredient]
    let calories, totalWeight: Double
    let totalTime: Double
//    let totalNutrients, totalDaily: [String: Total]
//    let digest: [Digest]
}

// MARK: - Digest
struct Digest: Codable {
    let label, tag: String
    let schemaOrgTag: SchemaOrgTag?
    let total: Double
    let hasRDI: Bool
    let daily: Double
    let unit: Unit
    let sub: [Digest]?
}

enum SchemaOrgTag: String, Codable {
    case carbohydrateContent = "carbohydrateContent"
    case cholesterolContent = "cholesterolContent"
    case fatContent = "fatContent"
    case fiberContent = "fiberContent"
    case proteinContent = "proteinContent"
    case saturatedFatContent = "saturatedFatContent"
    case sodiumContent = "sodiumContent"
    case sugarContent = "sugarContent"
    case transFatContent = "transFatContent"
}

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

enum HealthLabel: String, Codable {
    case alcoholFree = "Alcohol-Free"
    case immunoSupportive = "Immuno-Supportive"
    case peanutFree = "Peanut-Free"
    case sugarConscious = "Sugar-Conscious"
    case treeNutFree = "Tree-Nut-Free"
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String
    let weight: Double
}

// MARK: - Total
struct Total: Codable {
    let label: String
    let quantity: Double
    let unit: Unit
}
