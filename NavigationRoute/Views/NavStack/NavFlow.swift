import Foundation
import SwiftUI

public class NavFlow<T: Route>: ObservableObject {

    private let logger: Logger?
    public private(set) var routes: [T] = []
    public private(set) var initialPath: T
    @Published var path = NavigationPath()

    var onPush: ((T, Bool) -> Void)?

    public init(initial: T, debug: Bool = false) {
        logger = debug ? DebugLog() : nil
        logger?.log("Flow - Pilot Initialize \(initial).")
//        push(initial, animated: false)
        initialPath = initial
        routes.append(initial)
    }

    public func push(_ route: T, animated: Bool = true) {
        logger?.log("Flow - Pushing \(route) route.")
        path.append(route)
        routes.append(route)
        logger?.log("Flow - \(routes) routes")
//        logger?.log("Flow - \(path) routes")
    }

    public func pop(animated: Bool = true) {
        guard !path.isEmpty, !routes.isEmpty, let last = routes.last else { return }
        popTo(route: last)
    }
    
    public func popToRoot(animated: Bool = true) {
        guard !path.isEmpty, !routes.isEmpty, let first = routes.first else { return }
        popTo(route: first)
    }

    public func popTo(route: T) {
        logger?.log("Flow - Popping route \(route).")

        guard !path.isEmpty, !routes.isEmpty  else {
            logger?.log("Flow - Path is empty.")
            return
        }
        
        guard let index = routes.lastIndex(of: route) else {
            logger?.log("Flow - Flow not found.")
            return
        }
        
        print("Index: \(index), count: \(path.count)")

        logger?.log("Flow - \(route) route popped")
        routes.remove(at: index)
        path.removeLast(path.count - index)
        logger?.log("Flow - \(routes) routes")
    }
}

extension NavFlow: CustomDebugStringConvertible {
    public var debugDescription: String {
        "[\(routes.map { "\($0)" }.joined(separator: ", "))]"
    }
}
