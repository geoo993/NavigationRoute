import SwiftUI
import Navigator

struct GoldView: View {
    @EnvironmentObject var flow: Flow<PinkRoute>

    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        ZStack {
            Color.gold
            VStack {
                Spacer()
                Button {
                    flow.popToRoot()
                } label: {
                    Text("Pop to root")
                }
                .foregroundColor(.black)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("GOLD")
    }
}
