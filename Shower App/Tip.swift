import SwiftUI

struct Tips: View {
    @State private var current_tip = 0
    var tips = ["It is recommended to shower between 5-10 minutes for each shower.",
                "Showering too much not only waste a lot of water, it will lead to dry skin and hair!",
                "Cutting back on showers would make you smell or risk having skin infections",
                "Plan your showers! Do up shower schedules based on your activities everyday!",
                "Your hair needs does not need as much as showering as your body because it is made of dead cells"]
    
    var body: some View {
        VStack {
            Text(tips[current_tip])
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
                .padding()
                
        }
        
    }
}

struct Tips_Previews: PreviewProvider {
    static var previews: some View {
        Tips()
    }
}
