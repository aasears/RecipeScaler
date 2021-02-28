//
//  Units.swift
//  RecipeScaler
//
//  Created by Aaron Sears on 2/23/21.
//

import Foundation

enum Unit: String, CaseIterable, Identifiable {
    case c
    case tsp
    case tbsp
    case oz
    case pinch
    case ml
    case lb
    case g
    case kg
    
    var id: String { self.rawValue }
}

