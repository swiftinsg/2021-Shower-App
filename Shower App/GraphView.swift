import SwiftUI

struct Graph: View {
    @Environment(\.colorScheme) var colorScheme

    @State var pickerSelection = 2
    @State var barValues : [CGFloat] = [325,150,350,100,250,110,65]
    var body: some View {
            VStack{
                Text("Graph of last 7 showers")
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .font(.largeTitle)
                HStack(alignment: .center, spacing: 10)
                {

                    ForEach(barValues, id: \.self){
                        data in
                        BarView(value: data, cornerRadius: CGFloat(integerLiteral: 20))
                    }
                }.padding(.top, 10).animation(.default)
            }
        }


}
struct BarView: View{
    @Environment(\.colorScheme) var colorScheme
    var value: CGFloat
    var cornerRadius: CGFloat
    @ State private var hovering : Bool = false
    var body: some View {
        VStack {
            ZStack (alignment: .bottom) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 45, height: 600).foregroundColor(colorScheme == .dark ? .black : .white)
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


struct Graph_Previews: PreviewProvider {
    static var previews: some View {
        Graph()
    }
}
