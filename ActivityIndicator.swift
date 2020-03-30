import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

	var isAnimating: Bool
	let style: UIActivityIndicatorView.Style

	// MARK: - UIViewRepresentable

	typealias UIViewType = UIActivityIndicatorView

	func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
		return UIActivityIndicatorView(style: style)
	}

	func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
		isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
	}
}

struct AcivityIndicator_Previews: PreviewProvider {
	static var previews: some View {
		return ActivityIndicator(
			isAnimating: true,
			style: .large
		)
	}
}
