import SwiftUI

struct Graph: View {
    @State var pickerSelection = 0
    @Environment(\.colorScheme) var colorScheme
    @State var barValues : [Time]
    var body: some View {
        VStack{
            Text("Graph of last \(barValues.count) showers")
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .font(.largeTitle)
                .padding(.top, 35)
            
            Picker(selection: $pickerSelection, label: Text("Stats"))
            {
                Text("Time").tag(0)
                Text("Water").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 80)
            HStack(alignment: .center, spacing: 10)
            {
                if pickerSelection == 0 {
                    ForEach(barValues, id: \.self){
                        data in
                        TimeBarView(value: data.seconds, cornerRadius: CGFloat(integerLiteral: 20))
                            .padding(.bottom, 20.0)
                    }
                } else {
                    ForEach(barValues, id: \.self){
                        data in
                        WaterBarView(value: data.water, cornerRadius: CGFloat(integerLiteral: 20))
                            .padding(.bottom, 20.0)
                    }
                }
                
            }.padding(.vertical, 20.0)
        }.padding(.bottom,60.0)
    }
}
struct TimeBarView: View{
    @Environment(\.colorScheme) var colorScheme
    var value: CGFloat
    var cornerRadius: CGFloat
    @ State private var hovering : Bool = false
    var body: some View {
        VStack {
            ZStack (alignment: .bottom) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 45, height: 500).foregroundColor(colorScheme == .dark ? .black : .white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 45, height: value).foregroundColor(value > 300 ? darkRed : lightBlue)
                Text("\(Int(value/60)):\(String(format : "%02d", Int(value)%60))")
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.bottom)
            }.padding(.bottom, 8)
        }
    }
}

struct WaterBarView: View{
    @Environment(\.colorScheme) var colorScheme
    var value: CGFloat
    var cornerRadius: CGFloat
    @ State private var hovering : Bool = false
    var body: some View {
        VStack {
            ZStack (alignment: .bottom) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 45, height: 500).foregroundColor(colorScheme == .dark ? .black : .white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 45, height: value * 5).foregroundColor(value > 40 ? darkRed : lightBlue)
                Text("\(value,specifier: "%.1f")")
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.bottom)
            }.padding(.bottom, 8)
        }
    }
}

struct Graph_Previews: PreviewProvider {
    static var previews: some View {
        Graph(barValues: [Time(seconds: 100,water: 30)])
    }
}
