//
//  ContentView.swift
//  Flashzilla
//
//  Created by varun bhoir on 11/03/21.
//

import CoreHaptics
import SwiftUI

// vibrations
struct ContentView3: View {
    @State private var engine: CHHapticEngine?
    var body: some View {
        Text("")
            .onAppear {
                makeEngine()
            }.onTapGesture {
                complexSuccess()
            }
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func makeEngine() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
        } catch {
            print("Error while creating engine - \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        var events = [CHHapticEvent]()
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1))
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1))
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        // crate pattern of those events and play immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern - \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView3()
    }
}



// gestures
struct ContentView2: View {
    @State private var offset: CGSize = .zero
    @State private var isDragging = false
    var body: some View {
        let dragGesture = DragGesture().onChanged { (value) in
            
                offset = value.translation
            
        }
        .onEnded { (value) in
            isDragging = false
            offset = .zero
        }
        
        let longPressGesture = LongPressGesture(minimumDuration: 1, maximumDistance: 100).onChanged({ (value) in
            
        }).onEnded { (value) in
            
                isDragging = true
            
            
        }
        let combineGesture = longPressGesture.sequenced(before: dragGesture)
        Circle()
            .fill(Color.red)
            .frame(width: 50, height: 50)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combineGesture)
            .animation(.default)
        

    }
}

// hit testing
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello")
            Spacer()
                .frame(width: 100, height: 100)
            Text("World")
        }
        //.contentShape(Rectangle())
        .allowsHitTesting(false)
        .onTapGesture {
            print("VStack tapped")
        }
    }
}
