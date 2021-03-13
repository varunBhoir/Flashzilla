//
//  ContentView.swift
//  Flashzilla
//
//  Created by varun bhoir on 11/03/21.
//

import CoreHaptics
import SwiftUI


struct ContentView: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var count = 0
    var body: some View {
        Text("Varun")
            .onReceive(timer, perform: { time in
                if count == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("time is now \(time)")
                }
                count += 1
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

