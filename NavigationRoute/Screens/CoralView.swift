import SwiftUI
import Navigator

struct CoralView: View {

    @EnvironmentObject var flow: Flow<YellowRoute>

    var body: some View {
        NavigationStack {
            contentView
        }
    }
    
    private var contentView: some View {
        ZStack {
            Color.coral
            VStack {
                Spacer()
                Button {
                    flow.close()
                } label: {
                    Text("Close")
                }
                .foregroundColor(.black)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Coral")
    }
}
