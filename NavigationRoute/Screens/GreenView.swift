import SwiftUI

struct GreenView: View {

    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        ZStack {
            Color.green
            VStack {
                Spacer()
                Button {
                    
                } label: {
                    Text("Sup")
                }
                .foregroundColor(.black)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("GREEN")
    }
}
