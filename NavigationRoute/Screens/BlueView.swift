import SwiftUI
import Navigator

enum BlueRoute: Route {
    case blue
    case teal

    var id: Self { self }
}

struct BlueView: View {

    @StateObject var flow = Flow<BlueRoute>(initial: .blue, debug: true)

    var body: some View {
        FlowRouter(flow) {
            view(forScreen: $0)
        }
    }
    
    @ViewBuilder
    private func view(forScreen route: BlueRoute) -> some View {
        switch route {
        case .blue:
            contentView
        case .teal:
            TealView()
        }
    }
    
    private var contentView: some View {
        ZStack {
            Color.blue
            VStack {
                Spacer()
                Button {
                    flow.push(.teal)
                } label: {
                    Text("Go to Teal")
                }
                .foregroundColor(.black)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("BLUE")
    }
}
