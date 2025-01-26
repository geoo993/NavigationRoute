import SwiftUI
import Navigator

enum GreenRoute: Route {
    case green

    var id: Self { self }
}

struct GreenView: View {

    @StateObject var flow = Flow<GreenRoute>(initial: .green, debug: true)

    var body: some View {
        FlowRouter(flow) {
            view(forScreen: $0)
        }
    }
    
    @ViewBuilder
    private func view(forScreen route: GreenRoute) -> some View {
        switch route {
        case .green:
            contentView
        }
    }
    
    private var contentView: some View {
        ZStack {
            Color.green
            VStack {
                Spacer()
                Button {
                    guard let url = URL(string: "navigationroute://applink/red") else { return }
                    UIApplication.shared.open(url)
                } label: {
                    Text("Switch to Red")
                }
                .foregroundColor(.black)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("GREEN")
    }
}
