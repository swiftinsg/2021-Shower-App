import SwiftUI

struct Graph: View {
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text("Water consumption")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                Text("Litres of water used")
                    .foregroundColor(.white)
                    .font(.headline)
                HStack {
                    Text("'y axis'")
                        .foregroundColor(.white)
                    Text("'Graph'")
                        .foregroundColor(.white)
                }
                .padding(.vertical, 100.0)
                Text("'x axis'")
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                Text("Past 30 days")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
    }
}

struct Graph_Previews: PreviewProvider {
    static var previews: some View {
        Graph()
    }
}
