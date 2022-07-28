//
//  deeplink_swiftui_tutorialApp.swift
//  deeplink_swiftui_tutorial
//
//  Created by minkyuLee on 2022/07/29.
//

import SwiftUI

@main
struct deeplink_swiftui_tutorialApp: App {
    
    @State var selectedTab = TabIdentifier.todos
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab,
                content: {
                TodosView().tabItem{
                    VStack{
                        Image(systemName: "list.bullet")
                        Text("할일목록")
                    }
                }.tag(TabIdentifier.todos)
                ProfileView().tabItem{
                    VStack{
                        Image(systemName: "person.circle.fill")
                        Text("프로필")
                    }
                }.tag(TabIdentifier.profile)
            })
            .onOpenURL(perform: {url in
                //열려야 하는 url 처리
                guard let tabid = url.tabIdentifier else { return }
                selectedTab = tabid
            })
        }
    }
}

struct deeplink_swiftui_tutorialApp_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World")
    }
}

// 어떤 탭이 선택되었는지.
enum TabIdentifier : Hashable {
    case todos
    case profile
}

enum PageIdentifier: Hashable {
    case todoItem(id: UUID)
}

extension URL {
    // info에서 추가한 딥링크가 들어왔는지 여부
    var idDeeplink : Bool {
        return scheme == "deeplink-swiftui"
    }
    
    // url 들어오는 것으로 어떤 타입의 탭을 보여줘야 하는지 가져오기
    var tabIdentifier: TabIdentifier? {
        guard idDeeplink else { return nil }
        
        // deeplink-swiftui://hohoho
        switch host {
        case "todos":
            return .todos
        case "profile":
            return .profile
        default:
            return nil
        }
    }
    
    var detailPage: PageIdentifier? {
        guard let tabId = tabIdentifier,
              pathComponents.count > 1,
              let uuid = UUID(uuidString: pathComponents[1])
        else { return nil }
        
        switch tabId {
        case .todos:
            return .todoItem(id: uuid)
        default:
            return nil
        }
    }
}
