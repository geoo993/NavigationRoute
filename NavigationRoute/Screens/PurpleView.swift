import SwiftUI
import Navigator

struct PurpleView: View {
    
    @EnvironmentObject var flow: Flow<YellowRoute>

    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        ZStack {
            Color.purple
            VStack {
                Spacer()
                Button {
                    flow.present(.coral)
                } label: {
                    Text("Present Coral")
                }
                .foregroundColor(.white)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("PURPLE")
    }
}
