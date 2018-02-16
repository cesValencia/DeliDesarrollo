//
//  TriviasModel.swift
//  Deli
//
//  Created by David Valencia on 11/02/18.
//  Copyright © 2018 AMG Arts. All rights reserved.
//

import Foundation

struct TriviasModel {
    enum Meal: String {
        case breakfast, lunch, dinner
    }
    
    let name: String
    let meals: Set<Meal>
}

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

extension TriviasModel {
    init(json: [String: Any]) throws {
        // Extract name
        guard let name = json["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        // Extract and validate coordinates
        guard let coordinatesJSON = json["coordinates"] as? [String: Double],
            let latitude = coordinatesJSON["lat"],
            let longitude = coordinatesJSON["lng"]
            else {
                throw SerializationError.missing("coordinates")
        }
        
        let coordinates = (latitude, longitude)
        guard case (-90...90, -180...180) = coordinates else {
            throw SerializationError.invalid("coordinates", coordinates)
        }
        
        // Extract and validate meals
        guard let mealsJSON = json["meals"] as? [String] else {
            throw SerializationError.missing("meals")
        }
        
        var meals: Set<Meal> = []
        for string in mealsJSON {
            guard let meal = Meal(rawValue: string) else {
                throw SerializationError.invalid("meals", string)
            }
            
            meals.insert(meal)
        }
        
        // Initialize properties
        self.name = name
        self.meals = meals
    }
}
