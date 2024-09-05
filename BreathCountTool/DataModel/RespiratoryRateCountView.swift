//
//  RespiratoryRateCountView.swift
//  BreathCountTool
//
//  Created by Christian Schinkel on 2024-09-03.
//

import SwiftUI

struct RespiratoryRateCountView: View {
    // MARK: Counter
    @State private var count: Int = 0
    // MARK: Date and time
    @State private var startDate: Date = Date.now
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeElapsed: Int = 0
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Timer: \(timeElapsed)")
                .onReceive(timer, perform: { firedDate in
                    timeElapsed = Int(firedDate.timeIntervalSince(startDate))
                })
            
            Spacer()
            
            Text("Taken: \(count) breaths per minute")
            Text("Estimated: \(count) breaths per minute")
            
            Spacer()
            Spacer()
            
            // Tap me to count upp
            Button(action: {
                countUp()
            }, label: {
                makeImageString()
            })
            
            Spacer()
            // Tap me to reset count
            Button(action: {
                resetCounter()
            }, label: {
                Image(systemName: "stop.fill")
            })
            
            Spacer()
        }
    }
    // MARK: - Functions for this View:
    /// Calculates factor for elapsed time fits in 60 seconds.
    /// - Parameter t: time elapsed since start.
    /// - Returns: Factor of how many times the time fits in 60 seconds aka 1 minute.
    fileprivate func calculate(factorOf t: Int) -> Double {
        let minute: Double = 60.0
        return Double(t) / minute
    }
    /// Calculates estimated counts per minute at this point of time.
    /// - Parameter count: registred counts.
    /// - Returns: Estimated counts per minute.
    fileprivate func calculate(estimated count: Double) -> Double {
        return Double(count) * count
    }
    fileprivate func makeImageString() -> Image {
        count == 0 ? Image(systemName: "play.fill") : Image(systemName: "hand.tap.fill")
    }
    fileprivate func countUp() {
        count += 1
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    fileprivate func resetCounter() {
        count = 0
        // reset timer
        timer.upstream.connect().cancel()
        timeElapsed = 0
    }
    
    fileprivate func calculateEstimatedRespiratoryRate() -> Double {
        Double(count) / Double (timeElapsed)
    }
}

#Preview {
    RespiratoryRateCountView()
}
