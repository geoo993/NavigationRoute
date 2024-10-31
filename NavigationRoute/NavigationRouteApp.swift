import SwiftUI

enum AppRoute: Route {
    case red
    case blue
    case orange

    var id: Self { self }
}

struct BlueView: View {

    @EnvironmentObject var flow: Flow<AppRoute>

    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            VStack {
                Spacer()
                Button {
                    flow.push(.orange)
                } label: {
                    Text("Orange")
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("BLUE")
    }
}

struct OrangeView: View {

    @EnvironmentObject var flow: Flow<AppRoute>

    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()
            VStack {
                Spacer()
                Button {
                    flow.popTo(.red)
                } label: {
                    Text("POP TO Red")
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("ORANGE")
    }
}


struct RedView: View {

    @EnvironmentObject var flow: Flow<AppRoute>

    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            VStack {
                Spacer()
                Button {
                    flow.push(.blue)
                } label: {
                    Text("Blue")
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("RED")
    }
}

@main
struct NavigationRouteApp: App {
    @StateObject var flow = Flow<AppRoute>(initial: .red, debug: true)

    @ViewBuilder
    var contentView: some View {
        FlowNavigationView {
            RouteFactory(flow) { route in
                switch route {
                case .red:
                    RedView()
                case .blue:
                    BlueView()
                case .orange:
                    OrangeView()
                }
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            contentView
        }
    }
}

