import Foundation
import SwiftUI

public struct FlowRouter<T: Route, Screen: View>: View {
    
    @StateObject private var flow: Flow<T>
    @ViewBuilder let routeMap: (T) -> Screen
    
    public init(
        _ flow: Flow<T>,
        @ViewBuilder _ routeMap: @escaping (T) -> Screen
    ) {
        self._flow = StateObject(wrappedValue: flow)
        self.routeMap = routeMap
    }
    
    public var body: some View {
        NavigationStack(path: $flow.routes) {
            rootView
                .navigationDestination(for: T.self) {
                    view(forRoute: $0)
                }
        }
        .present(flow: flow, content: view(forPresentable:))
    }
    
    @ViewBuilder
    private var rootView: some View {
        view(forRoute: flow.initialPath)
    }

    @ViewBuilder
    private func view(forPresentable presentable: Presentable<T>) -> some View {
        view(forRoute: presentable.route)
            .presentationDetents(presentable.detents)
    }
    
    private func view(forRoute route: T) -> some View {
        routeMap(route)
            .environmentObject(flow)
    }
}
