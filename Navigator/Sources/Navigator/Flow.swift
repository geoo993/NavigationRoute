// https://medium.com/@iamsandytwix/swiftui-navigation-0fbb8aaa6c52
// https://swiftwithmajid.com/2022/06/21/mastering-navigationstack-in-swiftui-deep-linking/
// https://swiftwithmajid.com/2022/10/05/mastering-navigationstack-in-swiftui-navigationpath/
// https://www.swiftyplace.com/blog/swiftui-sheets-modals-bottom-sheets-fullscreen-presentation-in-ios
// https://www.avanderlee.com/swiftui/deeplink-url-handling/

import Foundation
import SwiftUI

public typealias Route = Hashable

@MainActor
public class Flow<T: Route>: ObservableObject {

    let initialPath: T
    @Published var routes: [T] = []
    @Published var presenter: Presentable<T>?
    public var current: T? {
        presenter?.route ?? routes.last ?? initialPath
    }
    private let logger: Logger?

    public init(initial: T, debug: Bool = false) {
        logger = debug ? DebugLog() : nil
        logger?.log("Flow - Pilot Initialize \(initial).")
        initialPath = initial
    }

    public func push(_ route: T) {
        logger?.log("Flow - Pushing \(route) route.")
        routes.append(route)
        logger?.log("Flow - \(routes) routes and \(current)")
    }

    public func pop() {
        guard !routes.isEmpty else { return }
        routes.removeLast()
        logger?.log("Flow - popped to \(current)")
    }
    
    public func popToRoot() {
        guard !routes.isEmpty else { return }
        routes.removeAll()
        logger?.log("Flow - pop to \(current)")
    }

    public func popTo(route: T) {
        logger?.log("Flow - Popping route \(route).")

        guard !routes.isEmpty  else {
            logger?.log("Flow - Path is empty.")
            return
        }
        
        guard let index = routes.lastIndex(of: route) else {
            logger?.log("Flow - Flow not found.")
            return
        }

        let range = (index + 1)..<routes.count
        logger?.log("Flow - popped to \(route) route")
        routes.removeSubrange(range)
        logger?.log("Flow - \(routes) routes")
    }
    
    public func close() {
        logger?.log("Flow - closing sheet")
        presenter = nil
        logger?.log("Flow - dismissing \(current) sheet")
    }

    public func present(
        _ route: T,
        style: PresentableStyle = .sheet,
        detents: Set<PresentationDetent> = [.large],
        onDismiss: (() -> Void)? = nil
    ) {
        let presentable = Presentable(
            style: style,
            route: route,
            detents: detents,
            onDismiss: onDismiss
        )
        presenter = presentable
        logger?.log("Flow - \(route) route presented as \(style), current \(current)")
    }
}

extension Flow: @preconcurrency CustomDebugStringConvertible {
    public var debugDescription: String {
        "[\(routes.map { "\($0)" }.joined(separator: ", "))]"
    }
}
