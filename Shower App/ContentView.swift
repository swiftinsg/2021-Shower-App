//
//  ContentView.swift
//  Shower App
//
//  Created by Student on 11/11/21.
//

import SwiftUI
import Combine
import AVKit

let darkBlue = Color(red: 0.3412, green: 0.3922, blue: 0.5647)
let lightBlue = Color(red: 0.5961, green: 0.7412, blue: 0.7725)
let steelGray = Color(white: 0.55)
let darkRed = Color(red: 0.8, green: 0.0, blue: 0.0)
let white = Color(white: 1)


struct ContentView: View {
    @Binding var times: [Time]
    
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("rate", store: .standard) var rate = "7"
    
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
    
    @State var equivalentString = ""
    @State private var isModalTipsPresented = false
    @State private var isModalGraphPresented = false
    
    @State var audioPlayer : AVAudioPlayer!
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .onTapGesture {
                    hideKeyboard()
                }
            
            VStack {
                if !started {
                    HStack {
                        Spacer()
                        Button(action: {isModalTipsPresented.toggle()}, label: {
                            Text("\(Image(systemName: "lightbulb"))")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(colorScheme == .dark ? lightBlue : darkBlue)
                                .padding()
                        })
                            .sheet(isPresented: $isModalTipsPresented,
                                   content: {
                                Tips(current_tip: Int.random(in: 0..<tips.count))
                            })
                    }
                }
                
                
                CircularProgressView(displayText: "\(displayMinutes):\(String(format: "%02d",displaySeconds ))", progress: CGFloat(displayMinutes * 60 + displaySeconds) / CGFloat(5 * 60), overtime: overtime, isTextHidden: restarted && !started)
                    .padding()
                
                if !started {
                    
                    if !restarted {
                        HStack {
                            TextField("",text: $rate)
                                .font(Font.system(size: 20))
                                .padding(.all, 15.0)
                                .background(RoundedRectangle(cornerRadius: 16).fill(steelGray.opacity(0.1)))
                                .foregroundColor(.black)
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
                        }
                        .padding(.horizontal)
                        
                    } else {
                        HStack {
                            ScrollView {
                                Text("You spent \(Int(totalTime/60))m \(String(format: "%02d",Int(totalTime%60)))s showering and used \(String(format: "%.2f", (CGFloat(Int(rate)! * totalTime)/60))) litres of water, that’s equal to drinking \(Int(rate)! * totalTime/15) cups of water")
                                    .font(.title)
                                    .fontWeight(.semibold)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10.0)
                    }
                    HStack {
                        Button(action:{
                            withAnimation {
                                startTimer()
                            }
                        })
                        {
                            Text("START")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(lightBlue)
                                .cornerRadius(30)
                        }
                        
                        Button(action: {
                            isModalGraphPresented.toggle()
                        })
                        {
                            Text("\(Image(systemName: "chart.bar.fill"))")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(colorScheme == .dark ? lightBlue : darkBlue)
                                .cornerRadius(30)
                        }
                        .sheet(isPresented: $isModalGraphPresented,
                               content: {
                            ZStack {
                                Graph(barValues: times)
                                WaterWaveView()
                            }
                        })
                    }
                    .padding()
                } else {
                    Button(action:{
                        withAnimation {
                            stopTimer()
                        }
                    })
                    {
                        Text("STOP")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(darkRed)
                            .cornerRadius(30)
                            .padding()
                    }
                    
                }
            }
        }
        .onAppear {
            let sound = Bundle.main.path(forResource: "alarm", ofType: "mp3")
            audioPlayer = try! AVAudioPlayer(contentsOf:URL(fileURLWithPath: sound!))
        }
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
            withAnimation {
                if (countdownMinutes == 0 && countdownSeconds == 0) {
                    totalTime = 5 * 60 + countupMinutes * 60 + countupSeconds
                    if countupSeconds == 59 {
                        audioPlayer.play()
                        countupMinutes += 1
                        countupSeconds = 0
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
                    
                    if countdownMinutes == 2  {
                        audioPlayer.play()
                    }
                    displayMinutes = countdownMinutes
                    displaySeconds = countdownSeconds
                    countupSeconds = 0
                    countupMinutes = 0
                    overtime = false
                }
            }
        }
    }
    
    func stopTimer(){
        started = false
        timer?.invalidate()
        timer = nil
        times.append(Time(seconds: CGFloat(totalTime),water: CGFloat(Int(rate)! * totalTime)/60))
        times = Array(times.suffix(7))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(times: .constant([]))
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
