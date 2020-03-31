import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {

    @Binding var annotations: [MapAnnotation]

    // MARK: - UIViewRepresentable
    typealias UIViewType = MKMapView

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MapView.UIViewType {
        return MKMapView()
    }

    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations.map(MKAnnotationWrapper.init(annotation:)))
    }
}

// MARK: - Swift helpers

/// Map annotation protocol in swif
protocol MapAnnotation {
	/// The center point (specified as a map coordinate) of the annotation.
	var coordinate: CLLocationCoordinate2D { get }
	/// The string containing the annotation’s title.
	var title: String? { get }
	/// The string containing the annotation’s subtitle.
	var subtitle: String? { get }
}

extension MapAnnotation {
	var title: String? { nil }
	var subtitle: String? { nil }
}

/// Enable remove `NSObject` and `MKAnnotation` depedencies from initialize `MapView`
class MKAnnotationWrapper: NSObject, MKAnnotation {
	/// The center point (specified as a map coordinate) of the annotation.
	var coordinate: CLLocationCoordinate2D { annotation.coordinate }
	/// The string containing the annotation’s title.
	var title: String? { annotation.title }
	/// The string containing the annotation’s subtitle.
	var subtitle: String? { annotation.subtitle }

	var annotation: MapAnnotation

	init(annotation: MapAnnotation) {
		self.annotation = annotation
	}
}

// MARK: - Previews

struct MapView_Previews: PreviewProvider {
	private struct TestAnnotation: MapAnnotation {
		var title: String? = "Title"
		var subtitle: String? = "Subtitle"
		var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
	}

    static var previews: some View {
		MapView<TestAnnotation>(annotations: .constant([TestAnnotation()]))
    }
}
