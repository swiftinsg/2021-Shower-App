//
//  ContentView.swift
//  Shower App
//
//  Created by Student on 11/11/21.
//

import SwiftUI
import Combine

let darkBlue = Color(red: 0.3412, green: 0.3922, blue: 0.5647)
let lightBlue = Color(red: 0.5961, green: 0.7412, blue: 0.7725)
let steelGray = Color(white: 0.55)
let darkRed = Color(red: 0.8, green: 0.0, blue: 0.0)
let white = Color(white: 1)


struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var rate: String = "5"
    
    @State var countupMinutes: Int = 0
    @State var countupSeconds: Int = 0
    
    @State var countdownMinutes: Int = 5
    @State var countdownSeconds: Int = 0
    
    @State var displayMinutes: Int = 5
    @State var displaySeconds: Int = 0
    
    @State var totalTime: Int = 0
    
    @State var timer: Timer? = nil
    
    @State var started: Bool = false
    @State var restarted: Bool = false
    @State var overtime: Bool = false
    
    @State private var isModalPresented = false
    
    var body: some View {
        VStack {
            Button(action: {isModalPresented = true}, label: {
                Text("\(Image(systemName: "lightbulb"))")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(lightBlue)
            })
            .padding(.leading, 300.0)
            
            
            CircularProgressView(displayText: "\(displayMinutes):\(String(format: "%02d",displaySeconds ))", progress: CGFloat(displayMinutes * 60 + displaySeconds) / CGFloat(5 * 60), overtime: overtime)
                .frame(width: 300, height: 300)
                .padding(.all, 100.0)
                .position(x:UIScreen.main.bounds.size.width/2,y: 250)
            
            if !started {
                
                if !restarted {
                    HStack {
                        TextField("",text: $rate)
                            .font(Font.system(size: 20))
                            .padding(.all, 15.0)
                            .background(RoundedRectangle(cornerRadius: 20).fill(steelGray.opacity(0.8)))
                            .foregroundColor(.black)
                            .padding(.all, 10.0)
                            .keyboardType(.numberPad)
                            .onReceive(Just(rate)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.rate = filtered
                                }
                                
                            }
                        Text("litres / min")
                            .font(.title2)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                        
                    }.padding(.bottom, 60.0)
                    .padding(.horizontal, 80.0)
                } else {
                    HStack {
                        Text("You spent \(Int(totalTime/60)):\(String(format: "%02d",Int(totalTime%60))) mins showering and used \((Int(rate)! * totalTime)/60) litres of water, that’s equal to")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 60.0)
                    .padding(.bottom, 60.0)
                }
                
                Button(action:{
                    startTimer()
                })
                {
                    Text("START")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }.padding(.horizontal, 140.0)
                .padding()
                .background(lightBlue)
                .cornerRadius(30)
                .padding()
                
            } else {
                Button(action:{
                    stopTimer()
                })
                {
                    Text("STOP")
                        .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                }.padding(.horizontal, 140.0)
                .padding()
                .background(darkRed)
                .cornerRadius(30)
                .padding()
            }
        }
        .sheet(isPresented: $isModalPresented,
                       content: {
                        Tips(current_tip: Int.random(in: 0..<tips.count))
                })
    }
    
    func startTimer(){
        started = true
        restarted = true
        countdownMinutes = 5 // Goal Time
        countdownSeconds = 0
        
        countupMinutes = 0
        countdownSeconds = 0
        
        displayMinutes = countdownMinutes
        displaySeconds = countdownSeconds
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true)
        { tempTimer in
            if (countdownMinutes == 0 && countdownSeconds == 0) {
                totalTime = 5 * 60 + countupMinutes * 60 + countupSeconds
                if countupSeconds == 59 {
                    countupMinutes += 1
                } else {
                    countupSeconds += 1
                }
                
                displayMinutes = countupMinutes
                displaySeconds = countupSeconds
                overtime = true
            } else {
                totalTime = (4-countdownMinutes) * 60 + (60-countdownSeconds)+1
                if countdownSeconds == 0 {
                    countdownMinutes -= 1
                    countdownSeconds = 59
                } else {
                    countdownSeconds -= 1
                }
                
                if countdownMinutes == 2 {
                    print("beep")
                }
                displayMinutes = countdownMinutes
                displaySeconds = countdownSeconds
                countupSeconds = 0
                countupMinutes = 0
                overtime = false
            }
        }
    }
    
    
    
    func stopTimer(){
        started = false
        timer?.invalidate()
        timer = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
