import Foundation
import UIKit
import SwiftUI

public typealias Route = Hashable

public enum PresentingStyle {
    case single
    case flow
}

struct Presentable<T: Route> {
    var route: T
    var isTransparent: Bool
    var modalPresentationStyle: UIModalPresentationStyle
    var transition: UIModalTransitionStyle
    var sheetDetents: [UISheetPresentationController.Detent] = [.large()]
    var animated: Bool
    var onDismiss: (() -> Void)?
}

public class Flow<T: Route>: ObservableObject {

    private let logger: Logger?
    public private(set) var routes: [T] = []
    private var presentedRoutes = LinkedList<Presentable<T>>()

    var onPush: ((T, Bool) -> Void)?
    var onPopLast: ((Int, Bool) -> Void)?
    var onReplace: ((Int, T ,Bool) -> Void)?
    var onPresent: ((Presentable<T>) -> Void)?
    var dismissAll: (() -> Void)?

    public init(initial: T, debug: Bool = false) {
        logger = debug ? DebugLog() : nil
        logger?.log("Flow - Pilot Initialized.")
        push(initial, animated: false)
    }

    public var current: T? {
        presentedRoutes.last?.value.route ?? routes.last
    }

    public func push(_ route: T, animated: Bool = true) {
        logger?.log("Flow - Pushing \(route) route.")
        routes.append(route)
        onPush?(route, animated)
        logger?.log("Flow - \(routes) routes")
    }

    public func pop(animated: Bool = true) {
        guard !routes.isEmpty else { return }
        logger?.log("Flow - \(String(describing: routes.last)) route popped.")
        onPopLast?(1, animated)
    }

    public func popTo(_ route: T, inclusive: Bool = false, animated: Bool = true) {
        logger?.log("Flow - Popping route \(route).")

        guard !routes.isEmpty else {
            logger?.log("Flow - Path is empty.")
            return
        }

        guard var found = routes.lastIndex(where: { $0 == route }) else {
            logger?.log("Flow - Flow not found.")
            return
        }

        if !inclusive { found += 1 }

        let numToPop = (found..<routes.endIndex).count
        logger?.log("Flow - Popping \(numToPop) routes")
        onPopLast?(numToPop, animated)
        logger?.log("Flow - \(routes) routes")
    }

    public func popToRoot(animated: Bool = true) {
        guard let first = routes.first else { return }
        popTo(first, inclusive: false, animated: animated)
    }

    public func replaceLastWith(_ route: T, animated: Bool = false) {
        onReplace?(1, route, animated)
        routes.append(route)
    }

    public func replaceAllWith(_ route: T, animated: Bool = true) {
        onReplace?(routes.count, route, animated)
        routes = [route]
    }

    public func close(animated: Bool = true) {
        onPopLast?(routes.count, animated)
        routes = []
        dismissAll?()
        presentedRoutes.removeAll()
    }

    public func presentSheet(
        _ route: T,
        animated: Bool = true,
        transition: UIModalTransitionStyle = .coverVertical,
        detents: [UISheetPresentationController.Detent] = [.large()],
        onDismiss: (() -> Void)? = nil
    ) {
        let presentable = Presentable(
            route: route,
            isTransparent: false,
            modalPresentationStyle: .pageSheet,
            transition: transition,
            sheetDetents: detents,
            animated: animated,
            onDismiss: { [weak self] in
                onDismiss?()
                guard let self, !self.presentedRoutes.isEmpty else { return }
                _ = self.presentedRoutes.removeLast()
            }
        )
        presentedRoutes.append(presentable)
        logger?.log("Flow - \(route) route presented as sheet")
        onPresent?(presentable)
    }

    public func presentCover(
        _ route: T,
        animated: Bool = true,
        isTransparent: Bool = false,
        transition: UIModalTransitionStyle = .coverVertical,
        modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
        onDismiss: (() -> Void)? = nil
    ) {
        let presentable = Presentable(
            route: route,
            isTransparent: isTransparent,
            modalPresentationStyle: modalPresentationStyle,
            transition: transition,
            animated: animated,
            onDismiss: { [weak self] in
                onDismiss?()
                guard let self, !self.presentedRoutes.isEmpty else { return }
                _ = self.presentedRoutes.removeLast()
            }
        )
        presentedRoutes.append(presentable)
        logger?.log("Flow - \(route) route presented as cover")
        onPresent?(presentable)
    }

    func poppedLast(route: T) {
        guard let index = routes.lastIndex(of: route) else { return }
        logger?.log("Flow - \(route) route popped")
        routes.remove(at: index)
        logger?.log("Flow - \(routes) routes")
    }
}

extension Flow: CustomDebugStringConvertible {
    public var debugDescription: String {
        "[\(routes.map { "\($0)" }.joined(separator: ", "))]"
    }
}
