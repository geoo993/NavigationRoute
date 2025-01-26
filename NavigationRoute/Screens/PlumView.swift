import SwiftUI
import Navigator

struct PlumView: View {
    @EnvironmentObject var flow: Flow<RedRoute>

    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        ZStack {
            Color.plum
            VStack {
                Spacer()
                Button {
                    flow.push(.orange)
                } label: {
                    Text("Go to Orange")
                }
                .foregroundColor(.black)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Plum")
    }
}

