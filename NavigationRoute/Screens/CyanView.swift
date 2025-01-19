import SwiftUI

struct CyanView: View {
    @EnvironmentObject var flow: NavFlow<RedRoute>

    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        ZStack {
            Color.cyan
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
        .navigationTitle("CYAN")
    }
}

