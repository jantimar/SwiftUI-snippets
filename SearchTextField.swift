import SwiftUI

struct SearchTextField: UIViewRepresentable {

	@Binding var text: String

    // MARK: - UIViewRepresentable
	typealias UIViewType = UISearchTextField

	func makeUIView(context: UIViewRepresentableContext<SearchTextField>) -> SearchTextField.UIViewType {
		let textField = UISearchTextField()

		textField.addTarget(
			context.coordinator,
			action: #selector(Coordinator.editingChanged(_:)),
			for: .editingChanged
		)

		return textField
	}

	func updateUIView(_ uiView: UISearchTextField, context: UIViewRepresentableContext<SearchTextField>) {
		uiView.text = text
	}

	// MARK: - Coordinator
	func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

	class Coordinator: NSObject {
        private var textField: SearchTextField

        init(_ textField: SearchTextField) {
            self.textField = textField
        }

        @objc func editingChanged(_ searchTextField: UISearchTextField) {
			textField.text = searchTextField.text ?? ""
		}
    }
}

struct SearchField_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			SearchTextField(text: .constant("test"))
				.environment(\.colorScheme, .light)
				.previewLayout(.fixed(width: 568, height: 44))

			SearchTextField(text: .constant("test"))
				.environment(\.colorScheme, .dark)
				.previewLayout(.fixed(width: 568, height: 44))
		}
	}
}
