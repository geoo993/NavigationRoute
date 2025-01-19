import SwiftUI

struct PurpleView: View {
    
    @EnvironmentObject var flow: NavFlow<YellowRoute>

    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        ZStack {
            Color.purple
            VStack {
                Spacer()
                Button {
//                    flow.pop()
                    flow.popToRoot()
                } label: {
                    Text("Ending")
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
