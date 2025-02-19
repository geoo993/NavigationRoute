import SwiftUI
import Navigator

struct TealView: View {

    @EnvironmentObject var flow: Flow<BlueRoute>

    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        ZStack {
            Color.teal
            VStack {
                Spacer()
                Button {
                    flow.popToRoot()
                } label: {
                    Text("Pop To Blue")
                }
                .foregroundColor(.black)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Teal")
    }
}

