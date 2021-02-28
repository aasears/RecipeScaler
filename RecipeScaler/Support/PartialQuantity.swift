//
//  PartialQuantity.swift
//  RecipeScaler
//
//  Created by Aaron Sears on 2/23/21.
//

import Foundation

enum PartialQuantity: String, CaseIterable, Identifiable {
    case none = ""
    case eighth = "1/8"
    case quarter = "1/4"
    case third = "1/3"
    case half = "1/2"
    case twothird = "2/3"
    case threequarter = "3/4"
    
    var id: String { self.rawValue }
}
