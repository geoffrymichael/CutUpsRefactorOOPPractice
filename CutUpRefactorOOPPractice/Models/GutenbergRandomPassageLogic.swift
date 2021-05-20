//
//  GutenbergRandomPassageLogic.swift
//  CutUpRefactorOOPPractice
//
//  Created by Geoffry Gambling on 5/19/21.
//

import Foundation

struct GutenbergRandomPassageLogic {
    
    
    
    func getGutenbergPassage()  {
        var gutenbergText = String()
        
        let rando = Int.random(in: 0...1600)
        
        let url = "https://www.gutenberg.org/cache/epub/\(rando)/pg\(rando).txt"
        
        let session = URLSession.shared
        
        session.dataTask(with: URL(string: url)!) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    gutenbergText = "Cut-ups error. Something went wrong, please make sure you are conected to the internet to use the random feature."
                }
            } else {
                let str = String(decoding: data!, as: UTF8.self)
                
                
                let randomInt = Int.random(in: 400...str.count - 301)
                                                                         
                let substring = str[randomInt..<randomInt + 300]

                let myString = str.components(separatedBy: .newlines)
                
                
                
                // Print source author and work of gutenberg text
//                print(myString[0...1], randomInt)

                DispatchQueue.main.async {
                    gutenbergText = substring
                    print(gutenbergText, "😾")
//                    self.activityIN.stopAnimating()
//
//                    self.setupGutenbergCitationView()
//                    self.placeholderLabel.text = ""
                    
//                    gutenbergText = substring
                    
//                    if myString[0].count > 1         {
//                        self.gutenbergCitationView.text = "From: \(myString[0]), https://www.gutenberg.org/cache/epub/\(rando)/pg\(rando).txt"
//
//                    } else {
//                        self.gutenbergCitationView.text = "Citation could not be found"
//                    }
//
//                    self.setupGutenbergCitationView()

                }
                
                
            }
            
        }.resume()
        
        
    }
    
}

extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}
