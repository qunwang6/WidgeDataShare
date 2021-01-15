//
//  ContentView.swift
//  Widget
//
//  Created by qun on 2021/1/15.
//

import SwiftUI
import WidgetKit
struct ContentView: View {
    @State private var name = ""
    @AppStorage("zombie", store: UserDefaults(suiteName: "group.com.qun.widget.Widget"))
    var zombie = ""
    var body: some View {
        VStack {
            HStack {
                TextField("殭屍的名字", text: $name)
              .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Save") {
                    zombie = name
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
            Image("沒人會特地去殺殭屍")
                .resizable()
                .scaledToFit()
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
