import Foundation
import SwiftUI
import SwiftUIIntrospect

public struct RouteFactory<T: Route, Screen: View>: View {

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
        contentView
            .introspect(
                .navigationView(style: .stack),
                on: .iOS(.v16, .v17, .v18),
                scope: .ancestor,
                customize: registerFlowEvents(nvc:)
            )
    }

    private var contentView: some View {
        flow.routes
            .first
            .flatMap(view(forRoute:))
    }

    @ViewBuilder
    private func view(forPresentable presentable: Presentable<T>) -> some View {
        view(forRoute: presentable.route)
    }

    private func view(forRoute route: T) -> some View {
        routeMap(route)
            .environmentObject(flow)
    }

    private func registerFlowEvents(nvc: UINavigationController) {

        flow.dismissAll = { [weak nvc] in
            nvc?.presentedViewController?.dismiss(animated: true)
        }

        flow.onPresent = { [weak nvc] presentable in
            guard let nvc else { return }
            let view = view(forRoute: presentable.route)
            let vc = DismissHostingViewController(rootView: view)
            vc.onDismiss = presentable.onDismiss
            if presentable.isTransparent {
                vc.view.backgroundColor = .clear
            }
            vc.modalPresentationStyle = presentable.modalPresentationStyle
            vc.modalTransitionStyle = presentable.transition
            vc.sheetPresentationController?.detents = presentable.sheetDetents
            nvc.topPresentedViewController.present(vc, animated: presentable.animated)
        }

        flow.onPush = { [weak nvc] route, animated in
            guard let nvc else { return }
            let view = view(forRoute: route)
            let vc = PopHostingViewController(rootView: view)
            vc.onPop = { flow.poppedLast(route: route) }
            nvc.pushViewController(vc, animated: animated)
        }

        flow.onReplace = { [weak nvc] count, route, animated in
            guard let nvc else { return }
            let view = view(forRoute: route)
            let vc = PopHostingViewController(rootView: view)
            vc.onPop = { flow.poppedLast(route: route) }
            
            let vcs = nvc.viewControllers.dropLast(count) + [vc]
            nvc.setViewControllers(Array(vcs), animated: animated)
        }

        flow.onPopLast = { [weak nvc] numToPop, animated in
            guard let nvc else { return }
            if numToPop == nvc.viewControllers.count {
                if nvc.presentingViewController != nil {
                    nvc.dismiss(animated: animated)
                } else {
                    nvc.viewControllers = []
                }
            } else {
                let popToIndex = max(nvc.viewControllers.count - numToPop - 1, 0)
                let popTo = nvc.viewControllers[popToIndex]
                nvc.popToViewController(popTo, animated: animated)
            }
        }
    }

    private class DismissHostingViewController<Content: View>: UIHostingController<Content> {
        var onDismiss: (() -> Void)?
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            guard isBeingDismissed else {
                return
            }
            onDismiss?()
        }
    }

    private class PopHostingViewController<Content: View>: UIHostingController<Content> {
        var onPop: (() -> Void)?

        override func willMove(toParent parent: UIViewController?) {
            super.willMove(toParent: parent)
            
            guard parent == nil else { return }
            onPop?()
        }
    }
}

extension UIViewController {

    var topPresentedViewController: UIViewController {
        var presented = self.presentedViewController
        while presented?.presentedViewController != nil {
            presented = presented?.presentedViewController
        }
        return presented ?? self
    }
}
