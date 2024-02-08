//
//  Decompostion.swift
//  FStationWorkshops
//
//  Created by Michael Cherniavsky on 22/07/2021.
//

import Foundation

/// Decomposing ingredients input into an array of ingredients, where each element is separate ingredient
func decompose(ingredients: String) -> [String] {
    /// Receiving an array of ingredients
    return ingredients.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n")
}

/// Decomposing `cooking steps` String into an array of Strings, each element of an array has to be the new cooking step
func decompose(cookingSteps steps: String) -> [String] {
    /// Receiving an array of steps
    return steps.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n\n")
}

/// Decomposing ingredient input into product name and quantity
func decompose(_ inputText: String) -> (quantity: String, productName: String) {
    
    //let pattern = "[0-9]{1,}gr"
    var quantity = ""
    var productName = inputText
    
    if let pattern = regexPattern(for: inputText) {
        
        let regexOptions: NSRegularExpression.Options = [.caseInsensitive]
        let matchingOptions: NSRegularExpression.MatchingOptions = [.reportCompletion]
        let range = NSRange(location: 0, length: inputText.utf16.count)
        
        
        let regex = try! NSRegularExpression(pattern: pattern, options: regexOptions)
        if let matchIndex = regex.firstMatch(in: inputText, options: matchingOptions, range: range) {
            
            let startIndex = inputText.index(inputText.startIndex, offsetBy: matchIndex.range.lowerBound)
            let endIndex = inputText.index(inputText.startIndex, offsetBy: matchIndex.range.upperBound)
            
            quantity = String(inputText[startIndex..<endIndex])
            quantity = quantity.trimmingCharacters(in: .whitespaces)
            
            productName.removeSubrange(startIndex..<endIndex)
            
            
        } else {
            print("\n No match for --- \(inputText) ---. \n")
        }
        
        //pattern to remove things like 'of'
        let patternToRemoveConnectors = #"^\s{0,}?(of)"#
        let regexToRemoveConnectors = try? NSRegularExpression(pattern: patternToRemoveConnectors, options: regexOptions)
        if let connectorsRange = regexToRemoveConnectors?.firstMatch(in: productName, options: matchingOptions, range: NSRange(location: 0, length: productName.utf16.count)) {
            
            let startIndex = productName.index(productName.startIndex, offsetBy: connectorsRange.range.lowerBound)
            let endIndex = productName.index(productName.startIndex, offsetBy: connectorsRange.range.upperBound)
            
            productName.removeSubrange(startIndex..<endIndex)
            
        } else {
            // No match for removing connectors
        }
    }
    
    // final touch on productName string
    productName = productName.trimmingCharacters(in: .whitespaces)
    
    return (quantity, productName)
}
