import SwiftUI
import Navigator

enum TabItem: String, CaseIterable, Hashable, Identifiable {
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
    
    private var tabs: [TabItem] {
        TabItem.allCases
    }

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
        .onOpenURL(perform: openURL(_:))
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

    private func openURL(_ url: URL) {
        print("Link selected: \(url.absoluteString)")
        guard url.scheme == "navigationroute" else {
            return
        }
//        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
//            print("Invalid URL")
//            return
//        }

        guard let path = url.pathComponents.last else {
            print("Missing URL Path")
            return
        }
        print("path found: \(path)")

        if let tab = TabItem(rawValue: path) {
            selection = tab
        }
    }
}
