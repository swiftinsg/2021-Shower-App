//
//  CircularProgressView.swift
//  Shower App
//
//  Created by sap on 13/11/21.
//

import SwiftUI

struct CircularProgressView: View {
    @Environment(\.colorScheme) var colorScheme

    var displayText : String
    var progress: CGFloat
    var overtime: Bool
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(lightBlue)
            Circle()
                .stroke(lineWidth: 50)
                .foregroundColor(colorScheme == .dark ? .black : .white)
            
            Text(displayText)
                .font(.largeTitle)
                .fontWeight(.bold)
                
            
            Circle()
                .trim(from: 0 , to: progress)
                .stroke(style: .init(lineWidth: 50,
                                     lineCap: .butt,
                                     lineJoin: .round))
                .foregroundColor(overtime ?  darkRed : darkBlue )
                .rotationEffect(Angle(degrees: 270))
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(displayText: "3:00", progress: 0.8, overtime: true)
            .frame(width: 300, height: 300)
    }
}
