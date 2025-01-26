import SwiftUI
import Navigator

enum PinkRoute: Route {
    case pink
    case gold

    var id: Self { self }
}

struct PinkView: View {
    @EnvironmentObject var redFlow: Flow<RedRoute>
    @StateObject var flow = Flow<PinkRoute>(initial: .pink, debug: true)

    var body: some View {
        FlowRouter(flow) {
            view(forScreen: $0)
        }
    }
    
    @ViewBuilder
    private func view(forScreen route: PinkRoute) -> some View {
        switch route {
        case .pink:
            contentView
                .toolbar {
                    ToolbarItem {
                        Button {
                            redFlow.close()
                        } label: {
                            Label("Close", systemImage: "xmark.circle")
                        }
                    }
                }
        case .gold:
            GoldView()
        }
    }

    private var contentView: some View {
        ZStack {
            Color.pink
            VStack {
                Spacer()
                Button {
                    flow.push(.gold)
                } label: {
                    Text("Go to Gold")
                }
                .foregroundColor(.black)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Pink")
    }
}
