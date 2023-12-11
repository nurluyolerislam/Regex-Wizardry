//
//  ContentView.swift
//  Regex Wizardry
//
//  Created by Erislam Nurluyol on 7.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel: ContentViewModel = .init()
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            Label("Example string", systemImage: "pencil.and.ellipsis.rectangle")
                .font(.headline)
            
            TextField("Enter an Example String", text: $viewModel.exampleString, axis: .vertical)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding()
                .overlay { RoundedRectangle(cornerRadius: 20).stroke() }
            
            Label("RegEx", systemImage: "pencil.and.ellipsis.rectangle")
                .font(.headline)
            
            TextField("Enter Regex",text: $viewModel.regex, axis: .vertical)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding()
                .overlay { RoundedRectangle(cornerRadius: 20).stroke() }
            
            Label("Highlighted text", systemImage: "highlighter")
                .font(.headline)
            
            HStack(spacing: 0) {
                if viewModel.matchedText.isEmpty {
                    Text(viewModel.exampleString)
                } else {
                    Text(viewModel.unmatchedPrefixString)
                    Text(viewModel.matchedText)
                        .background(.gray)
                    Text(viewModel.unmatchedSuffixString)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .onAppear{ viewModel.updateHighlightedText() }
    }
}

