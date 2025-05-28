//
//  SwiftUI+UITextView.swift
//  RickAndMorty-Combine
//
//  Created by Mert Gökduman on 27.05.2025.
//

import SwiftUI
import UIKit

struct NativeWritingToolsTextView: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true

        textView.supportsAdaptiveImageGlyph = true

        context.coordinator.placeholderLabel.text = placeholder
        context.coordinator.placeholderLabel.font = UIFont.systemFont(ofSize: 16)
        context.coordinator.placeholderLabel.textColor = UIColor.placeholderText
        context.coordinator.placeholderLabel.numberOfLines = 0
        context.coordinator.placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.addSubview(context.coordinator.placeholderLabel)

        NSLayoutConstraint.activate([
            context.coordinator.placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8),
            context.coordinator.placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5),
            context.coordinator.placeholderLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -5)
        ])

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        context.coordinator.placeholderLabel.isHidden = !text.isEmpty
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: NativeWritingToolsTextView
        let placeholderLabel = UILabel()

        init(_ parent: NativeWritingToolsTextView) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            placeholderLabel.isHidden = !textView.text.isEmpty
        }
    }
}


