//
//  TimerBootcamp.swift
//  SwiftUIIntermediateLearning
//
//  Created by Asya Tealdi on 16/05/2024.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let color1 = Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
    let color2 = Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    /*
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
    */
    
    /*
    @State var count = 10
    @State var finishedText: String? = nil
    */
    
    //Countdown to date
    /*
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour):\(minute):\(second)"
    }
     */
    
    //Animation Counter
    @State var count: Int = 1
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [color1, color2]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
//            Text(timeRemaining)
//                .font(.system(size: 100, weight: .semibold, design: .rounded))
//                .foregroundStyle(Color.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
//                .padding(.horizontal)
//            HStack(spacing: 15) {
//                Circle()
//                    .offset(y:count == 1 ? -20 : 0)
//                Circle()
//                    .offset(y:count == 2 ? -20 : 0)
//                Circle()
//                    .offset(y:count == 3 ? -20 : 0)
//            }
//            .frame(width: 150)
//            .foregroundStyle(Color.white)
            
            TabView(selection: $count,
                    content:  {
                Rectangle()
                    .foregroundStyle(Color.red)
                    .tag(1)
                Rectangle()
                    .foregroundStyle(Color.blue)
                    .tag(2)
                Rectangle()
                    .foregroundStyle(Color.green)
                    .tag(3)
                Rectangle()
                    .foregroundStyle(Color.orange)
                    .tag(4)
                Rectangle()
                    .foregroundStyle(Color.pink)
                    .tag(5)
            })
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1

            }
        })
    }
}

#Preview {
    TimerBootcamp()
}
