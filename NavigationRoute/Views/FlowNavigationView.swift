import SwiftUI

public typealias FlowNavigationView = NavigationView

public extension View {
    func embeddedInFlowNavigation(_ embedded: Bool = true) -> some View {
        modifier(EmbeddedInNavigation(embedded: embedded))
    }
}

struct EmbeddedInNavigation: ViewModifier {

    let embedded: Bool

    func body(content: Content) -> some View {
        if embedded {
            FlowNavigationView {
                content
            }
            .navigationViewStyle(.stack)
        } else {
            content
        }
    }
}
