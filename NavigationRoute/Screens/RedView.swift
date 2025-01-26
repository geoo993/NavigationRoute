import SwiftUI
import Navigator

enum RedRoute: Route {
    case red
    case cyan(CyanModel)
    case plum
    case orange
    case pink

    var id: Self { self }
}

struct RedView: View {

    @StateObject var flow = Flow<RedRoute>(initial: .red, debug: true)

    var body: some View {
        FlowRouter(flow) {
            view(forScreen: $0)
        }
    }
    
    @ViewBuilder
    private func view(forScreen route: RedRoute) -> some View {
        switch route {
        case .red:
            contentView
        case .cyan(let model):
            CyanView(model: model)
        case .plum:
            PlumView()
        case .orange:
            OrangeView()
        case .pink:
            PinkView()
        }
    }

    private var contentView: some View {
        ZStack {
            Color.red
            VStack {
                Spacer()
                Button {
                    flow.push(.cyan(.init(title: "CYAN", action: "Go to Plum")))
                } label: {
                    Text("Go to Cyan")
                }
                .foregroundColor(.black)
                Button {
                    flow.present(.pink) {
                        print("Finished dismissing Pink")
                    }
                } label: {
                    Text("Go to Pink in sheet")
                }
                .foregroundColor(.black)
                Button {
                    flow.present(.pink, style: .fullScreenCover) {
                        print("Finished dismissing Pink")
                    }
                } label: {
                    Text("Go to Pink in full cover")
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
