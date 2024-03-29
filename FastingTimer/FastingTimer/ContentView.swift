//
//  ContentView.swift
//  FastingTimer
//
//  Created by Лина Вертинская on 21.11.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var fastingManager = FastingManager()

    var title: String {
        switch fastingManager.fastingState {
        case .notStarted:
            return "Let's get started!"
        case .fasting:
            return "You are now fasting"
        case .feeding:
            return "You are now feeding"
        }
    }

    var body: some View {
        ZStack {

            // MARK: - Background
            Color(#colorLiteral(red: 0.02364313975, green: 0.003222482279, blue: 0.04070087522, alpha: 1))
                .ignoresSafeArea()

            content
        }
    }

    var content: some View {
        ZStack {
            VStack(spacing: 40) {

                // MARK: - Title
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red: 0.1838368475, green: 0.4429545403, blue: 1, alpha: 1)))

                // MARK: - Fasting Plan
                Text(fastingManager.fastingPlan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)

                Spacer()
            }
            .padding()

            VStack(spacing: 40) {

                // MARK: - Progress Ring
                ProgressRing()
                    .environmentObject(fastingManager)

                HStack(spacing: 60) {

                    // MARK: - Start Time
                    VStack(spacing: 5) {
                        Text(fastingManager.fastingState == .notStarted ? "Start" : "Started")
                            .opacity(0.7)

                        Text(fastingManager.startTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }

                    // MARK: - End Time
                    VStack(spacing: 5) {
                        Text(fastingManager.fastingState == .notStarted ? "End" : "Ends")
                            .opacity(0.7)

                        Text(fastingManager.endTime.addingTimeInterval(16), format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                }

                // MARK: - Button
                Button {
                    fastingManager.toggleFastingState()
                } label: {
                    Text(fastingManager.fastingState == .fasting ? "End fast" : "Start fasting")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                }
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
