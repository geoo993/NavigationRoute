import SwiftUI

struct TealView: View {

    @EnvironmentObject var flow: NavFlow<BlueRoute>

    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        ZStack {
            Color.teal
            VStack {
                Spacer()
                Button {
//                    flow.popToRoot()
//                    flow.pop()
                    flow.popTo(route: .blue)
                } label: {
                    Text("POP TO Blue")
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

