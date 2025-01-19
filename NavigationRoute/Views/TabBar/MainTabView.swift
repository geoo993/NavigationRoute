import SwiftUI

enum TabItem: CaseIterable, Hashable, Identifiable {
    case red
    case blue
    case green
    case yellow

    var id: Self { self }

    var title: String {
        switch self {
        case .red:
            return "Red"
        case .blue:
            return "Blue"
        case .green:
            return "Green"
        case .yellow:
            return "Yellow"
        }
    }

    var icon: Image {
        switch self {
        case .red:
            return Image(systemName: "eraser.fill")
        case .blue:
            return Image(systemName: "tray.circle.fill")
        case .green:
            return Image(systemName: "inset.filled.circle.dashed")
        case .yellow:
            return Image(systemName: "bolt.shield.fill")
        }
    }
}

struct MainTabView: View {
    
    @State private var selection: TabItem = .red

    var body: some View {
        tabView
    }
    
    private var tabView: some View {
        TabView(selection: $selection) {
            ForEach(tabs) { tab in
                view(forTabItem: tab)
                    .tabItem {
                        Label(
                            title: { Text(tab.title) },
                            icon: { tab.icon.renderingMode(.template) }
                        )
                    }
                    .tag(tab)
            }
        }
        .onChange(of: selection) { new, prev in
            switch new {
            case .red:
                print("Red selected")
            case .blue:
                print("Orange selected")
            case .green:
                print("Green selected")
            case .yellow:
                print("Yellow selected")
            }
        }
    }

    @ViewBuilder
    private func view(forTabItem item: TabItem) -> some View {
        switch item {
        case .red:
            RedView()
        case .blue:
            BlueView()
        case .green:
            GreenView()
        case .yellow:
            YellowView()
        }
    }

    private var tabs: [TabItem] {
        TabItem.allCases
    }
}

//struct MasterView: View {
//    
//    @StateObject var flow = Flower<TabItem>(initial: .red, debug: true)
//
//    var body: some View {
//        RouterFactory(flow) {
//            view(forScreen: $0)
//        }
//    }
//    
//    @ViewBuilder
//    private func view(forScreen route: TabItem) -> some View {
//        switch route {
//        case .red:
//            contentView
//        case .blue:
//            BlueView()
//        case .green:
//            GreenView()
//        case .yellow:
//            YellowView()
//        }
//    }
//    
//    private var contentView: some View {
//        VStack(spacing: 40) {
//            Button("Go to Green") {
//                flow.push(.green)
//            }
//            Button("Go to Blue") {
//                flow.push(.blue)
//            }
//            Button("Go to Yellow") {
//                flow.push(.yellow)
//            }
//        }
//        .navigationTitle("Main View")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
