//
//  Tips.swift
//  Shower App
//
//  Created by Student on 15/11/21.
//

import SwiftUI

struct Tips: View {
    @State private var current_tip = 0
    
    
    var tips = ["It is recommended to shower between 5-10 minutes for each shower.",
                "Showering too much not only waste a lot of water, it will lead to dry skin and hair!",
                "Cutting back on showers would make you smell or risk having skin infections",
                "Plan your showers! Do up shower schedules based on your activities everyday!",
                "Your hair needs does not need as much as showering as your body because it is made of dead cells",
                "If you want to shave, you might want to do it last.",
                "Don't rub with a towel dry but instead pat yourself with it.",
                "You might want to apply moisturiser 2-3mins after shower to keep your skin plump.",
                "Showering from top to bottom let the soap make its way down.",
                "Focus showering in the dirtiest areas instead of your arms and legs.",
                "It is better to shower in lukewarm water or cooler water as it is healthier for blood circulation." ]
    
    var body: some View {
        VStack {
            Text("TIP💡")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            
            Text(tips[current_tip])
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.all, 50)

        }
        
    }
}

struct Tips_Previews: PreviewProvider {
    static var previews: some View {
        Tips()
    }
}
