import Foundation
import SwiftUI

public struct NavFlowRouter<T: Route, Screen: View>: View {
    
    @StateObject private var flow: NavFlow<T>
    @ViewBuilder let routeMap: (T) -> Screen
    
    public init(
        _ flow: NavFlow<T>,
        @ViewBuilder _ routeMap: @escaping (T) -> Screen
    ) {
        self._flow = StateObject(wrappedValue: flow)
        self.routeMap = routeMap
    }
    
    public var body: some View {
        contentView
    }
    
    private var contentView: some View {
        NavigationStack(path: $flow.path) {
            view(forRoute: flow.initialPath)
                .navigationDestination(for: T.self) {
                    view(forRoute: $0)
                }
        }
    }
    
    @ViewBuilder
    private func view(forPresentable presentable: Presentable<T>) -> some View {
        view(forRoute: presentable.route)
    }
    
    private func view(forRoute route: T) -> some View {
        routeMap(route)
            .environmentObject(flow)
    }
}
