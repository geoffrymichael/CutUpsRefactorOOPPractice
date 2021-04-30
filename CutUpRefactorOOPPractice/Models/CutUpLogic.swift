//
//  CutUpLogic.swift
//  CutUpRefactorOOPPractice
//
//  Created by Geoffry Gambling on 4/26/21.
//

import UIKit
struct CutUpLogic {
   
    
    func cutUpSeparatedByComponents(text: String, separator: String, _ _: UIAlertAction) -> [String] {
        var array = [String]()
        
        array = text.components(separatedBy: separator)
        
        return array
    }
    
    func cutUpBySelectedAmount(text: String, chunkSize: Int) -> [String] {
        var array = [String]()
        
        //Replace new lines with spaces
        let newString = text.replacingOccurrences(of: "\n", with: " ", options: .literal, range: nil)
        
        //Use array chunk extension to split by chosen iterator
        let chunkedArray = newString.split(separator: " ").chunked(into: chunkSize)
        
        //Append the newly defined lines into the data array
        for (_ , wordGroup) in chunkedArray.enumerated() {
            array.append(wordGroup.joined(separator: " "))
        }
        
        return array
    }
    
    
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
