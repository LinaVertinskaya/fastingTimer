//
//  ProgressRing.swift
//  FastingTimer
//
//  Created by Лина Вертинская on 21.11.22.
//

import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var fastingManager: FastingManager

    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        ZStack {
            
            // MARK: - Placeholder Ring
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)

            // MARK: - Colored Ring
            Circle()
                .trim(from: 0.0, to: min(fastingManager.progress, 1.0))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1838368475, green: 0.4429545403, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.4825739861, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.7956622839, blue: 0.9899762273, alpha: 1)), Color(#colorLiteral(red: 0.3597189486, green: 0.8493903279, blue: 0.7645320296, alpha: 1)), Color(#colorLiteral(red: 0.4799151421, green: 0.6093613505, blue: 1, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect((Angle(degrees: 270)))
                .animation(.easeInOut(duration: 1.0), value: fastingManager.progress)

            VStack(spacing: 30) {
                if fastingManager.fastingState == .notStarted {

                    // MARK: - Upcoming Fast
                    VStack(spacing: 5) {
                        Text("Upcoming fast")
                            .opacity(0.7)

                        Text("\(fastingManager.fastingPlan.fastingPeriod.formatted()) Hours")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                } else {

                    // MARK: - Elapsed Time
                        VStack(spacing: 5) {
                            Text("Elapsed time (\(fastingManager.progress.formatted(.percent)))")
                                .opacity(0.7)

                            Text(fastingManager.startTime, style: .timer)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .padding(.top)

                    // MARK: - Remaining Time
                    VStack(spacing: 5) {
                        if !fastingManager.elapsed {
                            Text("Remaining time (\((1 - fastingManager.progress).formatted(.percent)))")
                                .opacity(0.7)
                        } else {
                            Text("Extra time")
                                .opacity(0.7)
                        }
                    }

                    Text(fastingManager.endTime, style: .timer)
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
        .frame(width: 250, height: 250)
        .padding()
        .onReceive(timer) { _ in
            fastingManager.track()
        }
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing()
            .environmentObject(FastingManager())
    }
}
