//
//  AlertViewModel.swift
//  FetchChallenge
//
//  Created by S J on 1/9/24.
//

import Foundation
import SwiftUI

@propertyWrapper
struct EquatableNoop<Value>: Equatable {
    var wrappedValue: Value

    static func == (lhs: EquatableNoop<Value>, rhs: EquatableNoop<Value>) -> Bool {
        true
    }
}

struct AlertViewModel: Identifiable, Equatable {
    var id = UUID().uuidString
    let title: String
    let message: String?
    @EquatableNoop var onDismiss: (() -> Void)?

    init(title: String,
         message: String?,
         onDismiss: (() -> Void)?) {
        self.title = title
        self.message = message
        self.onDismiss = onDismiss
    }
}

struct AlertViewModifier: ViewModifier {
    @Binding var viewModel: AlertViewModel?

    func body(content: Content) -> some View {
        content.fullScreenCover(item: $viewModel, onDismiss: viewModel?.onDismiss) { modal in
            VStack(spacing: 0) {
                Text(modal.title)
                    .font(.body)
                    .foregroundColor(.red)
                    .padding([.vertical, .horizontal])
                    .multilineTextAlignment(.center)

                if let message = modal.message {
                    Text(message)
                        .font(.caption)
                        .padding([.bottom, .horizontal])
                        .multilineTextAlignment(.center)
                }

                VStack(spacing: 0) {
                    Button("Dismiss") {
                        modal.onDismiss?()
                    }
                    .foregroundColor(.black)
                    .padding()
                }
            }
            .background(Color.init(white: 0.9).opacity(0.5).clipShape(RoundedRectangle(cornerRadius: 10)))
            .background(FullScreenClearBackgroundView())
        }
    }
}


extension View {
    func alert(modal: Binding<AlertViewModel?>) -> some View {
        modifier(AlertViewModifier(viewModel: modal))
    }
}
