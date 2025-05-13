//
//  Errors.swift
//  AHE Simple Supply
//
//  Created by Will Gibson on 4/22/25.
//

import Foundation


//TODO: Implement Error types and improve Alerts on the UI.

enum SIError: LocalizedError {
    case NotEnoughMaterials
    case SaveError
    case InvalidMaterialName

    
    var errorDescription: String? {
        switch self {
        case .NotEnoughMaterials:
            "Not Enough Materials"
        case .SaveError:
            "Cannot Save"
        case .InvalidMaterialName:
            "Invalid Material Name"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .NotEnoughMaterials:
            "There are not enough materials to create this product."
        case .SaveError:
            "There was an issue saving to the server. Please try again later."
        case .InvalidMaterialName:
            "That material name is already in use. Please change the name and try again."
        }
    }
}
