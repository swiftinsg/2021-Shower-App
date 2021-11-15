//
//  ContentView.swift
//  Shower App
//
//  Created by Student on 11/11/21.
//

import SwiftUI

let darkBlue = Color(red: 0.3412, green: 0.3922, blue: 0.5647)
let lightBlue = Color(red: 0.5961, green: 0.7412, blue: 0.7725)
let steelGray = Color(white: 0.4745)
let darkRed = Color(red: 0.8, green: 0.0, blue: 0.0)
let white = Color(white: 1)


struct ContentView: View {
    @State var countupMinutes: Int = 0
    @State var countupSeconds: Int = 0
    
    @State var countdownMinutes: Int = 5
    @State var countdownSeconds: Int = 0
    
    @State var displayMinutes: Int = 5
    @State var displaySeconds: Int = 0
    
    @State var timer: Timer? = nil
    @State var started: Bool = false
    @State var overtime: Bool = false
    
    var body: some View {
        VStack {
            CircularProgressView(displayText: "\(displayMinutes):\(String(format: "%02d",displaySeconds ))", progress: CGFloat(displayMinutes * 60 + displaySeconds) / CGFloat(5 * 60), overtime: overtime)
                .frame(width: 300, height: 300)
                .padding(.all, 100.0)
            
            if !started {
                Button(action:{
                    startTimer()
                })
                {
                    Text("TEST")
                }
            } else {
                Button(action:{
                    stopTimer()
                })
                {
                    Text("STOP")
                }
            }
        }
    }
    
    func startTimer(){
        started = true
        
        countdownMinutes = 5 // Goal Time
        countdownSeconds = 0
        
        countupMinutes = 0
        countdownSeconds = 0
        
        displayMinutes = countdownMinutes
        displaySeconds = countdownSeconds
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true)
        { tempTimer in
            if (countdownMinutes == 0 && countdownSeconds == 0) {
                print(countupMinutes)
                print(countupSeconds)
                print("------")
                if countupSeconds == 59 {
                    countupMinutes += 1
                } else {
                    countupSeconds += 1
                }
                
                displayMinutes = countupMinutes
                displaySeconds = countupSeconds
                overtime = true
            } else {
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
