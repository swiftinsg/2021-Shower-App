import SwiftUI

struct Graph: View {
    @State var pickerSelection = 0
    @Environment(\.colorScheme) var colorScheme
    @State var barValues : [Time]
    var body: some View {
        VStack{
            HStack {
                Text("Graph of Last \(barValues.count) Showers")
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .font(.largeTitle)
                    .padding()
                Spacer()
            }
            
            Picker(selection: $pickerSelection, label: Text("Stats"))
            {
                Text("Time").tag(0)
                Text("Water").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            HStack(alignment: .center, spacing: 10) {
                if pickerSelection == 0 {
                    ForEach(barValues, id: \.self){
                        data in
                        TimeBarView(value: data.seconds, cornerRadius: CGFloat(integerLiteral: 20))
                            .padding(.bottom)
                    }
                } else {
                    ForEach(barValues, id: \.self){
                        data in
                        WaterBarView(value: data.water, cornerRadius: CGFloat(integerLiteral: 20))
                            .padding(.bottom)
                    }
                }
                
            }
            
            Spacer()
        }
    }
}
struct TimeBarView: View{
    @Environment(\.colorScheme) var colorScheme
    var value: CGFloat
    var cornerRadius: CGFloat
    @ State private var hovering : Bool = false
    var body: some View {
        GeometryReader { reader in
            HStack(alignment: .center) {
                Spacer()
                ZStack (alignment: .bottom) {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: 45, height: reader.size.height)
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: 45, height: value / 500 * reader.size.height)
                        .foregroundColor(value > 300 ? darkRed : lightBlue)
                    Text("\(Int(value/60)):\(String(format : "%02d", Int(value)%60))")
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding(.bottom)
                }.padding(.bottom, 8)
                Spacer()
            }
        }
    }
}

struct WaterBarView: View{
    @Environment(\.colorScheme) var colorScheme
    var value: CGFloat
    var cornerRadius: CGFloat
    @ State private var hovering : Bool = false
    var body: some View {
        GeometryReader { reader in
            HStack {
                Spacer()
                ZStack (alignment: .bottom) {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: 45, height: reader.size.height)
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: 45, height: value * 5 / 500 * reader.size.height)
                        .foregroundColor(value > 40 ? darkRed : lightBlue)
                    Text("\(value,specifier: "%.1f")")
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .padding(.bottom)
                }.padding(.bottom, 8)
                Spacer()
            }
        }
    }
}

struct Graph_Previews: PreviewProvider {
    static var previews: some View {
        Graph(barValues: [Time(seconds: 100,water: 30)])
    }
}
