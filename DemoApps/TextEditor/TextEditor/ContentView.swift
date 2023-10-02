//
//  ContentView.swift
//  TextEditor
//
//  Created by Taher on 2/10/23.
//

import SwiftUI

struct ContentView: View {

    @State private var textEditorText = "There's someone in my head, but it's not me"
    var body: some View {
        VStack(alignment: .leading) {
            Text("Share your thoughts!")
                .font(.system(.title2))
            TextEditor(text: $textEditorText)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 300.0)
                .textEditorBackground(Color.gray.opacity(0.2))
                .cornerRadius(15.0)
        }
        .padding()
    }
}
