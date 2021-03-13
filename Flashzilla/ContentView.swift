//
//  ContentView.swift
//  Flashzilla
//
//  Created by varun bhoir on 11/03/21.
//

import CoreHaptics
import SwiftUI


struct ContentView: View {
    @State private var name = ""
    var body: some View {
        VStack {
            TextField("Enter the name", text: $name)
            Text("hwllo world")
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification), perform: { _ in
                    print("keyboard shown")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

