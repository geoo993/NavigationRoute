import SwiftUI
import Navigator

enum YellowRoute: Route {
    case yellow
    case purple
    case coral

    var id: Self { self }
}

struct YellowView: View {
    
    @StateObject var flow = Flow<YellowRoute>(initial: .yellow, debug: true)

    var body: some View {
        FlowRouter(flow) {
            view(forScreen: $0)
        }
    }
    
    @ViewBuilder
    private func view(forScreen route: YellowRoute) -> some View {
        switch route {
        case .yellow:
            contentView
        case .purple:
            PurpleView()
        case .coral:
            CoralView()
        }
    }

    private var contentView: some View {
        ZStack {
            Color.yellow
            VStack {
                Spacer()
                Button {
                    flow.push(.purple)
                } label: {
                    Text("Go to Purple")
                }
                .foregroundColor(.black)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("YELLOW")
    }
}
