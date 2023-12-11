//
//  ContentViewModel.swift
//  Regex Wizardry
//
//  Created by Erislam Nurluyol on 8.12.2023.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var exampleString = "" { didSet { updateHighlightedText() } }
    @Published var regex = "" { didSet{ updateHighlightedText() } }
    @Published var matchedText = ""
    @Published var unmatchedPrefixString = ""
    @Published var unmatchedSuffixString = ""
    
    func updateHighlightedText() {
        do {
            let regex = try NSRegularExpression(pattern: self.regex)
            
            let matchedStringNSRange = regex.rangeOfFirstMatch(in: exampleString,
                                                               range: NSRange(location: 0, length: exampleString.count))
            
            let matchedStringRange = Range(matchedStringNSRange, in: exampleString)
            var unmatchedprefixRange = Range(NSRange(location: 0, length: 0), in: exampleString)
            var unmatchedsuffixRange = Range(NSRange(location: exampleString.count - 1, length: 0), in: exampleString)
            
            if matchedStringNSRange.location > 0 {
                unmatchedprefixRange = Range(NSRange(location: 0,
                                            length: matchedStringNSRange.location),
                                    in: exampleString)
            }
            
            if matchedStringNSRange.location + matchedStringNSRange.length < exampleString.count  {
                unmatchedsuffixRange = Range(NSRange(location: (matchedStringNSRange.location + matchedStringNSRange.length),
                                            length: (exampleString.count - 1) - (matchedStringNSRange.location + matchedStringNSRange.length - 1)),
                                    in: exampleString)
            }
            
            if let matchedStringRange,
               let unmatchedprefixRange,
               let unmatchedsuffixRange {
                unmatchedPrefixString = exampleString[unmatchedprefixRange].description
                unmatchedSuffixString = exampleString[unmatchedsuffixRange].description
                matchedText =  exampleString[matchedStringRange].description
            } else {
                unmatchedPrefixString = ""
                matchedText = ""
                unmatchedSuffixString = ""
            }
        } catch {
            matchedText = ""
        }
    }
}
