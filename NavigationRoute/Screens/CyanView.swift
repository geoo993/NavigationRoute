import SwiftUI
import Navigator

struct CyanModel: Hashable {
    let title: String
    let action: String
}

struct CyanView: View {
    @EnvironmentObject var flow: Flow<RedRoute>
    let model: CyanModel

    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        ZStack {
            Color.cyan
            VStack {
                Spacer()
                Button {
                    flow.push(.plum)
                } label: {
                    Text(model.action)
                }
                .foregroundColor(.black)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(model.title)
    }
}
