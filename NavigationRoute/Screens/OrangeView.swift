import SwiftUI
import Navigator

struct OrangeView: View {

    @EnvironmentObject var flow: Flow<RedRoute>

    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        ZStack {
            Color.orange
            VStack {
                Spacer()
                Button {
                    flow.popTo(route: .cyan(.init(title: "CYAN", action: "Go to Plum")))
                } label: {
                    Text("POP To Cyan")
                }
                .foregroundColor(.black)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("ORANGE")
    }
}

