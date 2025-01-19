import SwiftUI

enum RedRoute: Route {
    case red
    case cyan
    case orange

    var id: Self { self }
}

struct RedView: View {

    @StateObject var flow = NavFlow<RedRoute>(initial: .red, debug: true)

    var body: some View {
        NavFlowRouter(flow) {
            view(forScreen: $0)
        }
    }
    
    @ViewBuilder
    private func view(forScreen route: RedRoute) -> some View {
        switch route {
        case .red:
            contentView
        case .cyan:
            CyanView()
        case .orange:
            OrangeView()
        }
    }

    private var contentView: some View {
        ZStack {
            Color.red
            VStack {
                Spacer()
                Button {
                    flow.push(.cyan)
                } label: {
                    Text("Go to Cyan")
                }
                .foregroundColor(.black)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("RED")
    }
}
