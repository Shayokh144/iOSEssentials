//
//  View+Extension.swift
//  TextEditor
//
//  Created by Taher on 2/10/23.
//

import SwiftUI

extension View {

    func textEditorBackground(_ content: Color) -> some View {
        if #available(iOS 16.0, *) {
            return self.scrollContentBackground(.hidden)
                .background(content)
        } else {
            UITextView.appearance().backgroundColor = .clear
            return self.background(content)
        }
    }
}
