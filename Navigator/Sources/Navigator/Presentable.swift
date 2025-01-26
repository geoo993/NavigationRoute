import SwiftUI

public enum PresentableStyle {
    case sheet
    case fullScreenCover
}

struct Presentable<T: Route>: Identifiable {
    var id: String = UUID().uuidString
    let style: PresentableStyle
    let route: T
    var detents: Set<PresentationDetent> = [.large]
    var onDismiss: (() -> Void)?
}

struct PresentableSheet<T: Hashable, C: View>: ViewModifier {
    var flow: Flow<T>
    let view: (Presentable<T>) -> C

    func body(content: Content) -> some View {
        content
            .sheet(
                item: .init(get: {
                    flow.presenter?.style == .sheet ? flow.presenter : nil
                }, set: {
                    flow.presenter = $0
                }),
                onDismiss: flow.presenter?.onDismiss,
                content: view
            )
            .fullScreenCover(
                item: .init(get: {
                    flow.presenter?.style == .fullScreenCover ? flow.presenter : nil
                }, set: {
                    flow.presenter = $0
                }),
                onDismiss: flow.presenter?.onDismiss,
                content: view
            )
    }
}

extension View {
    func present<T: Hashable, C: View>(
        flow: Flow<T>,
        content: @escaping (Presentable<T>) -> C
    ) -> some View {
        modifier(PresentableSheet(
            flow: flow,
            view: content
        ))
    }
}
