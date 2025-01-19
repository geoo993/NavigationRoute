import SwiftUI

struct OrangeView: View {

    @EnvironmentObject var flow: NavFlow<RedRoute>

    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        ZStack {
            Color.orange
            VStack {
                Spacer()
                Button {
                    flow.popToRoot()
//                    flow.pop()
                } label: {
                    Text("POP TO Red")
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

